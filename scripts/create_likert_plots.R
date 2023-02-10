requireNamespace("HH")

mg_likert_int <- mg_int |>
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
    mutate(pct = round(count / nrow(mg_survey), digits = 2)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    relocate(`Pas du tout`, .after = themes) |>
    relocate(`Un peu`, .after = `Pas du tout`) |>
    relocate(Moyennement, .after = `Un peu`) |>
    relocate(Beaucoup, .after = `Moyennement`) |>
    relocate(Enormément, .after = Beaucoup)

mg_likert_int <- HH::likert(themes ~ .,
                            mg_likert_int, 
                            positive.order = TRUE, 
                            as.percent = TRUE,
                            main = "Le sujet m'intéresse",
                            xlab = "Pourcentages",
                            ylab = "Thèmes")

mg_likert_ais <- mg_ais |>
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
    mutate(pct = round(count / nrow(mg_survey), digits = 2)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    relocate(`Pas du tout`, .after = themes) |>
    relocate(`Un peu`, .after = `Pas du tout`) |>
    relocate(Moyennement, .after = `Un peu`) |>
    relocate(Beaucoup, .after = `Moyennement`) |>
    relocate(Enormément, .after = Beaucoup)

mg_likert_ais <- HH::likert(themes ~ .,
                            mg_likert_ais, 
                            positive.order = TRUE, 
                            as.percent = TRUE,
                            main = "Je me sens à l'aise",
                            xlab = "Pourcentages",
                            ylab = "Thèmes")

lgbt_likert <- lgbt_int |>
    rename("Accueil des patients" = accueil,
           "Les bloqueurs de puberté" = bloqueurs, 
           "ISTs" = IST,
           "Santé mentale" = mental,
           "PrEP" = prep,
           "Enjeux reproductifs des THAG" = repro,
           "Déterminants sociaux de la santé" = social,
           "THAG" = THAG,
           "TPE" = TPE, 
           "Vieillir avec le VIH" = vieillir) |>
    pivot_longer(everything(), names_to = "themes", values_to = "reponse") |>
    group_by(themes, reponse) |>
    summarise(count = n()) |>
    mutate(pct = round(count / nrow(lgbt_survey), digits = 2)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    relocate(`Pas important du tout`, .after = themes) |>
    relocate(`Peu important`, .after = `Pas important du tout`) |>
    relocate(Neutre, .after = `Peu important`) |>
    relocate(Important, .after = `Neutre`) |>
    relocate(`Très important`, .after = Important)

lgbt_likert <- HH::likert(themes ~ .,
                            lgbt_likert, 
                            positive.order = TRUE, 
                            as.percent = TRUE,
                            main = "Il est important que les MG soient formés sur ces questions",
                            xlab = "Pourcentages",
                            ylab = "Thèmes")
