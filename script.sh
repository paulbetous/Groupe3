#! /bin/sh

#vérification nombre de paramètres
if [ $# -eq 0 ]
then
    ville="Toulouse"
elif [ $# -ne 1 ]
then
    echo "Usage : ./script.sh <Ville>"
    exit 1
else
    ville=$1
fi

#exportation données brutes dans fichier .txt
curl -s wttr.in/$ville?format=j2 > local.txt
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de l'exportation des données brutes" >> meteo_error.log
    exit 1
fi

#récupération température actuelle
tempact=$(curl -s wttr.in/$ville?format="%t")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de la récupération de la température actuelle" >> meteo_error.log
    exit 1
fi

if [ "${tempact:0:1}" = "+" ]
then
    tempact=$(echo $tempact | cut -c 2-)
fi

#récupération température du lendemain
templen=$(head -n 103 local.txt | tail -n 1 | grep -oE "\-*[0-9]*")°C

#récupération de la vitesse du vent
vent=$(curl -s wttr.in/$ville?format="%w")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de la récupération de la vitesse du vent" >> meteo_error.log
    exit 1
fi

#récupération du taux d'humidité
humidite=$(curl -s wttr.in/$ville?format="%h")
if [ $? -ne 0 ]
then
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Erreur de connexion à wttr.in pour $ville lors de la récupération de l'humidité" >> meteo_error.log
    exit 1
fi

#récuperation de la visibilite
visibilite=$(head -n 17 local.txt | tail -n 1 | grep -oE "[0-9]*")

#meteo en une ligne
heure=$(date +"%H:%M")
date=$(date +"%Y-%m-%d")

###modification de la mise en forme méteo car on rajoute plus d'informations ###
meteo="$date - $heure - $ville : Température actuelle : $tempact, Prévision du lendemain : $templen, Vent : $vent, Humidité : $humidite, Visibilité : $visibilite"

#enregistrement dans un fichier journalier
datefichier=$(date +"%Y%m%d")
fichier="meteo_$datefichier.txt"
echo $meteo >> $fichier

#enregistrement dans un fichier json (écrasé à chaque nouvel enregistrement)
fichierjson="meteo_$datefichier.json"
saisie="{\n \"date\": \"$date\",\n \"heure\": \"$heure\",\n \"ville\": \"$ville\",\n \"température\": \"$tempact\",\n \"vent\": \"$vent\",\n \"humidité\": \"$humidite\",\n \"visibilité\": \"$visibilite\"\n}"
echo -e $saisie > $fichierjson

exit 0
