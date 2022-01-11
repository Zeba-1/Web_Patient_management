from operator import le
import psycopg2
import random

# Activer cette ligne pour que le programme genere les meme personnes a chaque fois
# random.seed = 1567864

# Fonction pour les données du patient
def nomPrenom(noms, prenoms):
    """ genere un nom, un prenom et le sex associer """
    nomU = random.randint(0, len(noms)-1)
    nomU = noms[nomU]
    if(random.randint(0, 1)): # Y'a t'il un nom de naissance diff
        nom = random.randint(0, len(noms)-1)
        nom = noms[nom]
    else: nom = ""
    prenom = random.randint(0, len(prenoms)-1)
    prenom = prenoms[prenom]

    return (nomU, nom, prenom)

def adresse(rues):
    """ creer une adresse """
    numero = random.randint(1, 50)
    rue = random.randint(0, len(rues)-1)
    rue = rues[rue]

    return str(numero) + " " + rue + " Paris"

def complete(n, x):
    """
    sert pour le numero de secu. Il rajoute des 0 devant un nombre pour
    atteindre n caractere

    >>> complete(3, 10)
    010
    >>> complete(2, 10)
    10
    >>> complete(2, 1)
    01
    """
    x = str(x)
    while len(x) < n:
        x = "0" + x
    return x
def numeroSecu():
    """ creer un numero de secu """
    num = ""
    num += str(random.randint(1, 2)) # sexe
    num += complete(2, random.randint(0, 99)) # anne de naissance
    num += complete(2, random.randint(1, 12)) # mois de naissance
    num += complete(2, random.randint(1, 99)) # departement de naissance
    num += complete(3, random.randint(1, 999)) # code commune
    num += complete(3, random.randint(1, 999)) # ordre de naissance
    num += complete(2, str(int(num)%97)) # clé de sécurité

    return num

# fonction pour les données médicale du patients
def date(dateMin, dateMax):
    """
    genere une date
    triplet date = (jour, mois, année)
    """
    moisMin, moisMax = (1, 12)
    jourMin, jourMax = (1, 28) # Je veux pas gerer Fevrier

    annee = random.randint(dateMin[2], dateMax[2]) # Quelle annee ?

    if annee == dateMin[2]: # Si c'est l'annee minimun le mois minimum est a respecter
        moisMin = dateMin[1]
    if annee == dateMax[2]: # Si c'est l'annee max le mois max est a respecter
        moisMax = dateMax[1]
    mois = random.randint(moisMin, moisMax) # Quel mois ?

    if mois == dateMin[1]: # Si c'est le mois minimun le jour minimum est a respecter
        jourMin = dateMin[0]
    if mois == dateMax[1]: # Si c'est le mois max le jour max est a respecter
        jourMax = dateMax[0]
    jour = random.randint(jourMin, jourMax) # Quel jour

    return (jour, mois, annee)
def formatDateSQL(date):
    """ Creer une date au format SQL """
    if date == "":
        return "NULL"
    return "'" + complete(4, date[2]) + "-" + complete(2, date[1]) + "-" + complete(2, date[0]) + "'" # format date SQL
def formatDatePy(date):
    """ Donne un triplet date a partir d'un format de date SQL """
    if date == "NULL":
        return (1, 12, 2021)
    date = date[1:-1] # On retire les apostrophe du format SQL
    date = date.split("-")

    return (int(date[2]), int(date[1]), int(date[0]))
def formatDateTimeSQL(date):
    """ Creer un timestamp avec date et heur au format SQL """
    heure = complete(2, random.randint(0, 23))
    minute = complete(2, random.randint(0, 59))
    seconde = complete(2, random.randint(0, 59))

    return "'" + formatDateSQL(date)[1:-1] + " " +  heure + ":" + minute + ":" + seconde + "'"


def genAllergie(allergies):
    """
    creer une liste d'allergie (le nombre d'allergie est random)
    revois la liste des allergies et la liste avec les date d'apparition et
    de disparition de l'allergie sous la forme de tuple (debut, fin)
    """
    nbAllergie = random.randint(0, 5) # On vas donner entre 0 et 5 allergie par patient
    lstAllergie = []
    dateAllergie = []
    dateMin = (1, 1, 2015); dateMax = (18, 11, 2021)
    while len(lstAllergie) < nbAllergie:
        nvAlergie = allergies[random.randint(0, 11)]
        if nvAlergie not in lstAllergie: # Si il n'as pas déjà l'allergie
            lstAllergie.append(nvAlergie)

            dateD = date(dateMin, dateMax)
            if random.randint(1, 2) == 1: # l'allergie est passer
                dateF = date(dateD, dateMax)
            else: # l'allergie n'est pas passer
                dateF = ""
            dateAllergie.append((formatDateSQL(dateD), formatDateSQL(dateF)))

    return lstAllergie, dateAllergie

def passePar(services):
    """
    Donne un liste de par le quelle le patient est passé, avec la date a la
    quelle il est rentrer et sortie, il peut encore être dans le dernier services.
    Cette fonction retourne la liste des services et la liste avec les date de passage
    correspondant. Par exple lstServices[0] correspond au tuple de date datePassage[0],
    le tuple de date est respectivement (entree, sortie) avec sortie = "" si il est
    toujours dans le service
    """
    lstServices = []
    datePassage = []
    dateMin = (1, 1, 2015); dateMax = (1, 12, 2021)
    if random.randint(1, 3) < 3: # 2/3 de nos patient passeront uniquement par les urgences
        for i in range(random.randint(1, 3)): # le patient vas passer jusqu'à 3 fois aooupsu urgence
            lstServices.append(1) # On sait que le premier services est les urgences
            dateMin = date(dateMin, dateMax) # Date de son passage
            while (formatDateSQL(dateMin), formatDateSQL(dateMin)) in datePassage:
                dateMin = date((1, 1, 2015), (1, 12, 2021))
            datePassage.append((formatDateSQL(dateMin), formatDateSQL(dateMin))) # Le passage ne dure qu'une journée
            if dateMin == dateMax:
                return lstServices, datePassage
        return lstServices, datePassage
    else:
        nbPassage = random.randint(1, 5) # passe maximum 5 fois a l'hopital
        for i in range(nbPassage):
            service = services[random.randint(0, len(services)-1)]
            lstServices.append(service)
            dateD = date(dateMin, dateMax)
            while dateD == dateMin:
                dateD = date(dateMin, dateMax)
            if i == nbPassage-1: # Si c'est sont dernier passage
                if random.randint(1, 2) == 1: # Il est sortie
                    dateF = date(dateD, dateMax)
                else: # l'allergie n'est pas passer
                    dateF = ""
                datePassage.append((formatDateSQL(dateD), formatDateSQL(dateF)))
            else:
                dateF = date(dateD, dateMax)
                datePassage.append((formatDateSQL(dateD), formatDateSQL(dateF)))
                dateMin = dateF
            if dateMin == dateMax:
                return lstServices, datePassage
        return lstServices, datePassage

def genActeMed(servicesP, datePassageService, resume, acteMed, curseur):
    lstActe = []
    for i in range(random.randint(0, 4)): #Max 4 actes medicale
        serviceI = random.randint(0, len(servicesP)-1)
        service = servicesP[serviceI]
        #nom de l'acte
        lstNomActe = acteMed[service]
        nom = lstNomActe[random.randint(0, len(lstNomActe)-1)]
        #l'id du medecin
        lstMed = []
        curseur.execute(f"SELECT medecin FROM travaille WHERE services = {service};")
        for med in cursor:
            lstMed.append(med[0])
        medecin = lstMed[random.randint(0, len(lstMed)-1)]
        #date
        dateH = formatDateTimeSQL(date(formatDatePy(datePassageService[serviceI][0]), formatDatePy(datePassageService[serviceI][1])))
        #resumé
        resum = resume[random.randint(0, len(resume)-1)]

        lstActe.append((nom, dateH, resum, medecin))
    return lstActe
    

########### DEBUT PROGRAME ###########
try:
    connexion = psycopg2.connect("dbname='projet' user=''")
except:
    print("erreur durant la connexion a la base de donnée")
    exit(1)

cursor = connexion.cursor() # On creer le curseur pour les requettes

# Dans un premier temps on recupère la liste des alergie, des services et des medecinT et les medecinH (requette SQL)
allergies = []
cursor.execute("SELECT code FROM allergies;")
for code in cursor:
    allergies.append(code[0])

services = []
cursor.execute("SELECT ids FROM services;")
for code in cursor:
    services.append(code[0])

medecinsT = []
cursor.execute("SELECT nPro FROM medecint;")
for code in cursor:
    medecinsT.append(code[0])

medecinsH = []
cursor.execute("SELECT idm FROM medecinh;")
for code in cursor:
    medecinsH.append(code[0])

# Ensuite on vas recuperer les prenoms, noms et rues dans les fichier
prenoms = []; noms = []; rues = []; resume = []
acteMed = {}

prenomsF = open("prenoms.txt", "r", encoding="UTF8")
for prenom in prenomsF:
    prenoms.append(prenom[:-1])
prenomsF.close()
nomsF = open("noms.txt", "r", encoding="UTF8")
for nom in nomsF:
    noms.append(nom[:-1])
nomsF.close()
ruesF = open("rues.txt", "r", encoding="UTF8")
for rue in ruesF:
    rues.append(rue[:-1])
ruesF.close()
resumeF = open("resume.txt", "r", encoding="UTF8")
for l in resumeF:
    resume.append(l[:-1])
resumeF.close()
acteMedF = open("actemed.txt", "r", encoding="UTF8")
for l in acteMedF:
    lstActe = l[:-1].split(".")
    acteMed[int(lstActe[0])] = []
    for i in range(1, len(lstActe)):
        acteMed[int(lstActe[0])].append(lstActe[i])
acteMedF.close()

# Ensuite on creer x patients qu'on ajoute a la base:
nbPatients = 2000
for i in range(nbPatients):
    # on creer nom d'usage, nom, prenom, adresse, numero secu
    nomU, nom, prenom = nomPrenom(noms, prenoms)
    adr = adresse(rues)
    nSec = numeroSecu()

    # On s'occupe des infos médicale du patient
    medecinT = medecinsT[random.randint(0, len(medecinsT)-1)] # On lui affecte un meddesin traitant
    allergiesP, dateAllergies = genAllergie(allergies) # On creer les allergies du patients
    servicesP, datePassageService = passePar(services) # On regarde par quelle service est passé le partient
    lstActe = genActeMed(servicesP, datePassageService, resume, acteMed, cursor) # On recupère la liste des actes médicaux

    cursor.execute(f"INSERT INTO patients VALUES ('{nSec}', '{nomU}', '{nom}', '{prenom}', '{adr}', '{medecinT}');") # On ajoute le patient
    for i in range(len(allergiesP)):
        cursor.execute(f"INSERT INTO possede VALUES ('{nSec}', '{allergiesP[i]}', {dateAllergies[i][0]}, {dateAllergies[i][1]});") # On relis les allergies
    for dated in datePassageService:
        cursor.execute(f"INSERT INTO dateentre(datee) VALUES ({dated[0]}) ON CONFLICT (datee) DO NOTHING;") # On ajoute les dates
    for i in range(len(servicesP)):
        cursor.execute(f"INSERT INTO passepar VALUES ('{nSec}', '{servicesP[i]}', {datePassageService[i][0]}, {datePassageService[i][1]});") # On ajoute les passages par les services
    for acte in lstActe:
        cursor.execute(f"INSERT INTO actemed(nom, dateh, resum, patient, medecin) VALUES ('{acte[0]}', {acte[1]}, '{acte[2]}', '{nSec}', {acte[3]})") # On ajoute les intervention
    connexion.commit() # On envoie les modif a la base