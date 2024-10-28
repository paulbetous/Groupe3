#! /bin/sh
#vérification nombre de paramètres
if [ $# -eq 0 ]
then
    ville="Toulouse"
elif [ $# -ne 1 ]
then
    echo "Usage : ./scriptv2.sh <Ville>"
    exit 1
else
    ville=$1
fi

#récuperation parametres ville 
ville=$1

#exportation données brutes dans fichier.txt
curl -s wttr.in/$ville?format=j2 > local.txt

#récupération température actuelle
tempact=$(curl -s wttr.in/$ville?format="%t")
if [ "${tempact:0:1}" = "+" ]
then
    tempact=$(echo $tempact | cut -c 2-)
fi

#récupération température du lendemain
templen=$(head -n 103 local.txt | tail -n 1 | grep -oE "\-*[0-9]*")°C

#meteo en une ligne
heure=$(date +"%H:%M")
date=$(date +"%Y-%m-%d")
meteo="$date - $heure - $ville : $tempact - $templen"
echo $meteo > meteo.txt

exit 0 
