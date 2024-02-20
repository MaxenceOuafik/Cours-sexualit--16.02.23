source("./2024/scripts/manipulate_likert_data.R", encoding = "UTF-8")
    
mg_likert_int_plot_2024 <- mg_likert_int_2024 |>
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value, accuracy = 1)), color = "grey30", position = position_stack(vjust = 0.5)) +
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

mg_likert_ais_plot_2024 <- mg_likert_ais_2024 |>
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value, accuracy = 1)), color = "grey30", position = position_stack(vjust = 0.5)) +
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

lgbt_likert_plot <- lgbt_likert |>    
    filter(value != 0) |>
    ggplot(aes(x = fct_reorder(themes, score), y = value, fill = variable)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_text(aes(label = scales::percent(value, accuracy = 1)), color = "grey30", position = position_stack(vjust = 0.5)) +
    geom_hline(yintercept = 0.8, linetype = "dotted", color = "grey50", linewidth = 0.75) +
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