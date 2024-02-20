mg_likert_int_2024 <- mg_survey_2024 |>
    select(ends_with("_int")) |>
    rename("Accueil des patients" = accueil_int,
           "Les bloqueurs de puberté" = bloqueurs_int, 
           "ISTs" = IST_int,
           "Santé mentale" = mental_int,
           "PrEP" = prep_int,
           "Enjeux reproductifs des THAG" = repro_int,
           "Déterminants sociaux de la santé" = social_int,
           "THAG" = THAG_int,
           "TPE" = tpe_int, 
           "Vieillir avec le VIH" = vieillir_int) |>
    pivot_longer(everything(), names_to = "themes", values_to = "reponse") |>
    group_by(themes, reponse) |>
    summarise(count = n()) |>
    mutate(pct = round(count / nrow(mg_survey_2024), digits = 3)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    mutate(score = (`Pas du tout` * -2) + (`Un peu` * -1) + (Moyennement * 0) + (Beaucoup) + (Enormément * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas du tout", "Un peu", "Moyennement", "Beaucoup", "Enormément"))) 

mg_likert_ais_2024 <- mg_survey_2024 |>
    select(ends_with("_ais")) |>
    rename("Accueil des patients" = accueil_ais,
           "Les bloqueurs de puberté" = bloqueurs_ais, 
           "ISTs" = IST_ais,
           "Santé mentale" = mental_ais,
           "PrEP" = prep_ais,
           "Enjeux reproductifs des THAG" = repro_ais,
           "Déterminants sociaux de la santé" = social_ais,
           "THAG" = THAG_ais,
           "TPE" = tpe_ais, 
           "Vieillir avec le VIH" = vieillir_ais) |>
    pivot_longer(everything(), names_to = "themes", values_to = "reponse") |>
    group_by(themes, reponse) |>
    summarise(count = n()) |>
    mutate(pct = round(count / nrow(mg_survey_2024), digits = 3)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    mutate(score = (`Pas du tout` * -2) + (`Un peu` * -1) + (Moyennement * 0) + (Beaucoup) + (Enormément * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas du tout", "Un peu", "Moyennement", "Beaucoup", "Enormément")))

lgbt_likert <- lgbt_survey |>
    select(1:10) |>
    rename("Accueil des patients" = accueil,
           "Les bloqueurs de puberté" = bloqueurs, 
           "ISTs" = IST,
           "Santé mentale" = mental,
           "PrEP" = prep,
           "Enjeux reproductifs des THAG" = repro,
           "Déterminants sociaux de la santé" = social,
           "THAG" = THAG, 
           "TPE" = tpe,
           "Vieillir avec le VIH" = vieillir) |>
    pivot_longer(everything(), names_to = "themes", values_to = "reponse") |>
    group_by(themes, reponse) |>
    summarise(count = n()) |>
    mutate(pct = round(count / nrow(lgbt_survey), digits = 3)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>  
    mutate(score = (`Pas important du tout` * -2) + (`Peu important` * -1) + (Neutre * 0) + (Important) + (`Très important` * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas important du tout", "Peu important", "Neutre", "Important", "Très important"))) 