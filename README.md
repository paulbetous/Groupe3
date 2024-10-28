# Extracteur d'Informations Météorologiques

## Description

Ce projet propose un script Shell qui extrait périodiquement la température actuelle et les prévisions météorologiques pour le lendemain d'une ville donnée en utilisant le service wttr.in. Les informations sont enregistrées dans un fichier texte, avec chaque enregistrement sur une seule ligne. Le projet inclut plusieurs versions qui introduisent des fonctionnalités supplémentaires et utilise GIT pour gérer les versions.

## Fonctionnalités

### Version 1 : Script de base

- **Objectif** : Récupérer la météo locale pour une ville donnée.
- **Étapes** :
  1. Utiliser `curl` pour récupérer les données météo brutes depuis wttr.in pour la ville spécifiée.
  2. Extraire la température actuelle et la température prévue pour le lendemain.
  3. Formater les informations pour les rendre lisibles.
  4. Enregistrer les informations au format `[Date] - [Heure] - Ville : [Température actuelle] - [Prévision du lendemain]` dans un fichier `meteo.txt`.
- **Exemple** :

./meteo.sh Toulouse
2024-10-28 - 15:38 - Toulouse : 17°C - 17°C

### Version 2 : Automatisation périodique

- **Objectif** : Automatiser l'exécution du script.
- **Fonctionnalités ajoutées** :
1. Ville par défaut utilisée si aucun argument n'est fourni.
2. Configuration d'une tâche cron pour exécuter le script périodiquement.
3. Instructions dans le README pour configurer la tâche cron.

### Version 3 : Gestion d’historique

- **Objectif** : Conserver un historique des prévisions.
- **Fonctionnalités ajoutées** :
1. Ajout d'une option pour archiver les données dans un fichier journalier (par exemple `meteo_YYYYMMDD.txt`).
2. Les informations sont ajoutées au fichier de la journée à chaque exécution.

## Installation

1. Clonez le dépôt du projet.
2. Assurez-vous que `curl` est installé sur votre système.

## Utilisation

### Exécution manuelle

```bash
./Extracteur_Météo.sh [ville]
