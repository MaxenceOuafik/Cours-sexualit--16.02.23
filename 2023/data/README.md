# Data dictionary 

Ce travail se compose de 4 jeux de données différents : AIM_data.csv, patients_data.csv, LGBT_survey.csv, et MG_survey.csv. 
En outre, en vue de mettre au point une carte de la répartition géographique des patient·e·s, les données communes_L08 et refnis_postal.csv ont été obtenues.  

## AIM_data.csv

Ces données ont été téléchargées à partir de [la base de données de l’Agence Intermutualiste](https://atlas.aim-ima.be/base-de-donnees/) afin de permettre d’obtenir un point de comparaison par rapport aux données de patients_data.csv. 

* Région : Région dont sont tirées les données 
* DMG : pourcentage de la population ayant un DMG ouvert en 2020 
* DMG_AO_1524 : pourcentage des **assuré·e·s ordinaires** de **15 à 24 ans** ayant un DMG ouvert en 2020
* DMG_BIM_1524 : pourcentage de **bénéficiaires de l’intervention majorée** de **15 à 24 ans** ayant un DMG ouvert en 2020
* DMG_AO_2544 : pourcentage des **assuré·e·s ordinaires** de **25 à 44 ans** ayant un DMG ouvert en 2020
* DMG_BIM_2544 : pourcentage de **bénéficiaires de l’intervention majorée** de **25 à 44 ans** ayant un DMG ouvert en 2020
* BIM_2064 : pourcentage de bénéficiaires de l’intervention majorée en 2021

## patients_data.csv

Ces données proviennent du dossier médical informatisé des patient·e·s que j'ai vus entre le 01/01/2022 et le 08/02/2023 dans le cadre d'un traitement hormonal d'affirmation de genre. 
* dmg : si la personne a un DMG ouvert ou non 
* BIM : si la personne est BIM ou non 
* province : province de résidence de la personne, telle qu'indiquée sur sa carte d'identité
* postal : code postal de résidence de la personne, tel qu'indiqué sur sa carte d'identité

## communes_L08

Il s'agit du fichier shapefile de la carte des communes de Belgique, tel qu'obtenu en consultant [l'Atlas de Belgique](https://www.atlas-belgique.be/index.php/fr/ressources/donnees-cartographiques/). Cela permet d'avoir un canevas vierge sur lequel mettre les données géographiques des patient·e·s. 

## refnis_postal.csv

Ce fichier permettra simplement de joindre les données issues du dossier médical aux données issues de l'Atlas de Belgique. En effet, StatBel utilise un code NSI pour identifier les entités administratives et c'est ce code NSI qui figure dans le fichier de l'Atlas de Belgique. Or, évidemment, ces données sont absentes du dossier médical, dont a été extrait le code postal. Ce fichier est donc simplement un tableau de conversion entre codes postaux et codes des communes. Il a été téléchargé depuis le site de [StatBel](https://statbel.fgov.be/fr/propos-de-statbel/methodologie/classifications/geographie). 