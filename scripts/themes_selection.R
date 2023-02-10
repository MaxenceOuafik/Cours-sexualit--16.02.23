library(tidyverse)

# Par souci de clarté, les fonctions personnalisées se trouvent dans leurs propres scripts afin de ne pas encombrer celui-ci. 
source("./scripts/functions.R")

# On commence par diviser les données issues de mg_survey en deux jeux de données : celles liées à l'intérêt (mg_int) et celles liées à l'aisance (mg_ais). 
# Les variables étant de type "caractères", on les transformera également en facteurs. 
mg_int <- mg_survey |>
    select(ends_with("_int"))

mg_int <- as.data.frame(unclass(mg_int), 
                            stringsAsFactors = TRUE)

mg_ais <- mg_survey |>
    select(ends_with("_ais"))

mg_ais <- as.data.frame(unclass(mg_ais), 
                            stringsAsFactors = TRUE)

# On fait la même chose pour lgbt_survey, en excluant la question ouverte. 
lgbt_int <- lgbt_survey |>
    select(1:10) 

lgbt_int <- as.data.frame(unclass(lgbt_int), 
                            stringsAsFactors = TRUE)

# L'idée est ensuite de créer une liste avec différents seuils d'accord (100%, 80%, 60%) en utilisant les fonctions personnalisées

variable_int_mg <- list()
for (i in 1:10){
    variable_int_mg[["100%"]][[i]] <- select_variables(mg_int[i], 
                                                         threshold = 1)
    variable_int_mg[["80%"]][[i]] <- select_variables(mg_int[i], 
                                                         threshold = 0.8)
    variable_int_mg[["60%"]][[i]] <- select_variables(mg_int[i], 
                                                         threshold = 0.6)
}

variable_ais_mg <- list()
for (i in 1:10){
    variable_ais_mg[["100%"]][[i]] <- select_variables_ais(mg_ais[i], 
                                                         threshold = 1)
    variable_ais_mg[["80%"]][[i]] <- select_variables_ais(mg_ais[i], 
                                                         threshold = 0.8)
    variable_ais_mg[["60%"]][[i]] <- select_variables_ais(mg_ais[i], 
                                                         threshold = 0.6)
}

variable_int_lgbt <- list()
for (i in 1:10){
    variable_int_lgbt[["100%"]][[i]] <- select_variables_lgbt(lgbt_int[i], 
                                                         threshold = 1)
    variable_int_lgbt[["80%"]][[i]] <- select_variables_lgbt(lgbt_int[i], 
                                                         threshold = 0.8)
    variable_int_lgbt[["60%"]][[i]] <- select_variables_lgbt(lgbt_int[i], 
                                                         threshold = 0.6)
}
