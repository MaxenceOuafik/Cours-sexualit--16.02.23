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

mg_survey_2023 <- read_delim(here::here("2023/data/MG_survey.csv"))

mg_survey_2024 <- read_delim(here::here("2024/data/MG_survey.csv"))

lgbt_survey <- read_delim(here::here("data/LGBT_survey.csv"))

cities_geocoded <- read_delim("data/belgian-cities-geocoded.csv") |>
    distinct(postal, .keep_all = TRUE) |>
    select(postal, lat, lng)
patients_geocoded <- left_join(patients_data, cities_geocoded, by = "postal") |>
    filter(!is.na(lat)) |>
    unite("coord", lat, lng, sep = "+")