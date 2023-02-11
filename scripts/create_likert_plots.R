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
    mutate(score = (`Pas du tout` * -2) + (`Un peu` * -1) + (Moyennement * 0) + (Beaucoup) + (Enormément * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas du tout", "Un peu", "Moyennement", "Beaucoup", "Enormément"))) |>
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value)), color = "grey30", position = position_stack(vjust = 0.5)) +
    geom_hline(yintercept = 0.5, linetype = "dotted", color = "grey50", linewidth = 0.75) +
    coord_flip() + 
    labs(title = "Le sujet m'intéresse",
         fill = "Réponses",
         x = NULL,
         y = NULL) +
    scale_fill_manual(values = c("#e64747", "#f28752", "#ffe0b4", "#75abb8", "#138b9e")) + 
    theme_minimal() + 
    theme(legend.position = "bottom",
          plot.title = element_text(hjust = 0.5, size = 16, face = "bold", family = "Lato")) +
    scale_y_reverse(labels = NULL)

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
    mutate(score = (`Pas du tout` * -2) + (`Un peu` * -1) + (Moyennement * 0) + (Beaucoup) + (Enormément * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas du tout", "Un peu", "Moyennement", "Beaucoup", "Enormément"))) |>
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value)), color = "grey30", position = position_stack(vjust = 0.5)) +
    geom_hline(yintercept = 0.5, linetype = "dotted", color = "grey50", linewidth = 0.75) +
    coord_flip() + 
    labs(title = "Je me sens à l'aise",
         fill = "Réponses",
         x = NULL,
         y = NULL) +
    scale_fill_manual(values = c("#e64747", "#f28752", "#ffe0b4", "#75abb8", "#138b9e")) + 
    theme_minimal() + 
    theme(legend.position = "bottom",
          plot.title = element_text(hjust = 0.5, size = 16, face = "bold", family = "Lato")) +
    scale_y_reverse(labels = NULL)

lgbt_likert_int <- lgbt_int |>
    rename("Accueil des patients" = accueil,
           "Les bloqueurs de puberté" = bloqueurs, 
           "ISTs" = IST,
           "Santé mentale" = mental,
           "PrEP" = prep,
           "Enjeux reproductifs des THAG" = repro,
           "Déterminants sociaux de la santé" = social,
           "THAG" = THAG, 
           "Vieillir avec le VIH" = vieillir) |>
    pivot_longer(everything(), names_to = "themes", values_to = "reponse") |>
    group_by(themes, reponse) |>
    summarise(count = n()) |>
    mutate(pct = round(count / nrow(lgbt_survey), digits = 2)) |>
    select(-count) |>
    pivot_wider(names_from = reponse, values_from = pct, values_fill = 0) |>
    mutate(score = (`Pas important du tout` * -2) + (`Peu important` * -1) + (Neutre * 0) + (Important) + (`Très important` * 2)) |>
    arrange(desc(score)) |>
    pivot_longer(cols = 2:6, names_to = "variable", values_to = "value") |>
    mutate(variable = factor(variable, levels = c("Pas important du tout", "Peu important", "Neutre", "Important", "Très important"))) |>
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value, accuracy = 1)), color = "grey30", position = position_stack(vjust = 0.5)) +
    geom_hline(yintercept = 0.5, linetype = "dotted", color = "grey50", linewidth = 0.75) +
    coord_flip() + 
    labs(title = "Il est important que les généralistes soient formés sur la question",
         fill = "Réponses",
         x = NULL,
         y = NULL) +
    scale_fill_manual(values = c("#e64747", "#f28752", "#ffe0b4", "#75abb8", "#138b9e")) + 
    theme_minimal() + 
    theme(legend.position = "bottom",
          plot.title = element_text(hjust = 0.5, size = 16, face = "bold", family = "Lato")) +
    scale_y_reverse(labels = NULL)
