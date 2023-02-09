library(tidyverse)
mg_int <- mg_survey |>
    select(ends_with("_int"))

mg_int <- as.data.frame(unclass(mg_int), 
                            stringsAsFactors = TRUE)

mg_ais <- mg_survey |>
    select(ends_with("_ais"))

mg_ais <- as.data.frame(unclass(mg_ais), 
                            stringsAsFactors = TRUE)

lgbt_int <- lgbt_survey |>
    select(1:10) 

lgbt_int <- as.data.frame(unclass(lgbt_int), 
                            stringsAsFactors = TRUE)

select_variables <- function(x, threshold) {
    if ((sum(x == "Beaucoup", na.rm = TRUE) + 
    sum(x == "Enormément", na.rm = TRUE)) >= round(threshold * nrow(x))) {
        variablename <- colnames(x)
    } else {
       variablename <- NULL
    }
   return(variablename)
}

select_variables_ais <- function(x, threshold) {
    if ((sum(x == "Un peu", na.rm = TRUE) + 
    sum(x == "Pas du tout", na.rm = TRUE)) >= round(threshold * nrow(x))) {
        variablename <- colnames(x)
    } else {
       variablename <- NULL
    }
   return(variablename)
}

select_variables_lgbt <- function(x, threshold) {
    if ((sum(x == "Important", na.rm = TRUE) + 
    sum(x == "Très important", na.rm = TRUE)) >= round(threshold * nrow(x))) {
        variablename <- colnames(x)
    } else {
       variablename <- NULL
    }
   return(variablename)
}

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
