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