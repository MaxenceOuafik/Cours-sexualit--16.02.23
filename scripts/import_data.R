library(tidyverse)

# On récupère les données de patients_data.csv en spécifiant les colonnes devant être traitées comme logiques 
# (vrai/faux) et quelles colonnes sont numériques. 

patients_data <- read_delim(here::here("data/patients_data.csv"),
                            locale = locale(encoding = "UTF-8"),
                            col_types = cols(dmg = col_logical(),
                                             BIM = col_logical(),
                                            postal = col_number()))

# Transformation de la variable province en facteurs                                            
patients_data$province <- as.factor(patients_data$province)

# Importation des données de l'AIM en précisant que les décimales sont marquées par une virgule 
aim_data <- read_delim(here::here("data/AIM_data.csv"),
                       locale = locale(decimal_mark = ","))       

refnis_postal <- read_delim(here::here("data/refnis_postal.csv"),
                            locale = locale(encoding = "UTF-8"))

mg_survey <- read_delim(here::here("data/MG_survey.csv"))

lgbt_survey <- read_delim(here::here("data/LGBT_survey.csv"))