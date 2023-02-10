# LISEZ-MOI

## Objectifs du projet
Le 16/02/23, je donne un cours intituté "Abord inclusif de la sexualité", à destination des médecins généraliste en formation de l'Université de Liège. 
Énormement de sujets pouvant être abordés et n'ayant que trois heures de cours, j'ai donc décidé de sonder les assistant·e·s et une partie de la communauté pour dégager certains thèmes prioritaires. 
En outre, en vue d'illustrer les enjeux d'accès au soin, j'ai repris quelques données démographiques anonymes issues de mon dossier médical. 

Les objectifs de ce cours sont donc doubles : 
1. Former les assistant·e·s sur les points qu'ils ont identifiés comme prioritaires 
2. Leur donner envie de se former sur les soins trans-spécifiques en démontrant l'enjeu d'accès au soin 

## Structure du répertoire 

* **data**: ce dossier contient les données analysées pour mettre au point ce cours. Une description précise de chaque fichier de données se trouve dans le README.md du dossier. 
* **scripts** : ce dossier contient les scripts ayant permis d'importer les données, de les manipuler, et de mettre au point les graphiques et tables intégrées au PowerPoint
* **renv** : ce dossier contient les fichiers nécessairs au fonctionnement du package *renv*, afin d'assurer la portabilité du projet en gardant un environnement contenu au sein de ce projet. Les richiers *renv.lock* et *.Rprofile* permettent d'activer la machinerie de *renv*

Dans le dossier racine, on retrouve également le fichier *cours_presentation.qmd* qui contient le texte, les images, et les tableaux de la présentation afin de générer un fichier PowerPoint à partir de ce fichier. 

## Pour reproduire ce travail 
1. Entrez la commande `renv::restore()` dans le terminal afin de récupérer les packages ayant permis de réaliser ce travail
2. Pour recréer un nouveau fichier PowerPoint, il vous suffit d'utiliser la commande render de Quarto. 

Pour ce faire, vous aurez besoin d'avoir [R](https://www.r-project.org/) installé sur votre ordinateur ainsi que [Quarto](https://quarto.org/).
