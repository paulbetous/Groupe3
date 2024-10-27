#! /bin/sh

#verification nombre de parametres
if [ $# -ne 1 ]
then
	echo "Usage : ./script.sh <ville>"
	exit 1
fi

#récuperation parametres ville 
ville=$1

#exportation données brutes dans fichier.txt
curl -s wttr.in/$ville?format=j2 > local.txt

exit 0
