# Par souci de clarté, les fonctions personnalisées se trouvent dans leurs propres scripts afin de ne pas encombrer celui-ci. 
source("./scripts/functions.R", encoding = "UTF-8")

# On commence par diviser les données issues de mg_survey en deux jeux de données : celles liées à l'intérêt (mg_int) et celles liées à l'aisance (mg_ais). 
# Par ailleurs, étant donné que les variables de lgbt_survey ne contiennent pas le suffixe _int, on le retire
# de mg_int pour pouvoir comparer les deux

mg_int_2024 <- mg_survey_2024 |>
    select(ends_with("_int")) |>
    rename_with(~str_remove(., "_int"))

mg_int_2024 <- as.data.frame(unclass(mg_int_2024), 
                            stringsAsFactors = TRUE)

mg_ais_2024 <- mg_survey_2024 |>
    select(ends_with("_ais")) |>
    rename_with(~str_remove(., "_ais"))

mg_ais_2024 <- as.data.frame(unclass(mg_ais_2024), 
                            stringsAsFactors = TRUE)

# On fait la même chose pour lgbt_survey, en excluant la question ouverte. 
lgbt_int <- lgbt_survey |>
    select(1:10) 

# L'idée est ensuite de créer une liste avec différents seuils d'accord (100%, 80%, 60%) en utilisant les fonctions personnalisées

variable_int_mg_2024 <- list()
for (i in 1:10){
    variable_int_mg_2024[["100%"]][[i]] <- select_variables(mg_int_2024[i], 
                                                         threshold = 1)
    variable_int_mg_2024[["80%"]][[i]] <- select_variables(mg_int_2024[i], 
                                                         threshold = 0.8)
    variable_int_mg_2024[["60%"]][[i]] <- select_variables(mg_int_2024[i], 
                                                         threshold = 0.6)
}

variable_ais_mg_2024 <- list()
for (i in 1:10){
    variable_ais_mg_2024[["100%"]][[i]] <- select_variables_ais(mg_ais_2024[i], 
                                                         threshold = 1)
    variable_ais_mg_2024[["80%"]][[i]] <- select_variables_ais(mg_ais_2024[i], 
                                                         threshold = 0.8)
    variable_ais_mg_2024[["60%"]][[i]] <- select_variables_ais(mg_ais_2024[i], 
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

common_variables_2024 <- list()
common_variables_2024[["int"]] <- variable_int_mg_2024[["60%"]][variable_int_mg_2024[["60%"]] %in% variable_int_lgbt[["80%"]]]
common_variables_2024[["ais"]] <- variable_ais_mg_2024[["80%"]][variable_ais_mg_2024[["80%"]] %in% variable_int_lgbt[["80%"]]]