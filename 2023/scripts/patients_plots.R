source("./2023/scripts/patients_data_manipulation.R", encoding = "UTF-8")

bim_plot <- ggplot() +
    geom_bar(data = aim_summary, 
             aes(y = BIM_2064, x = "Région wallonne"),
             stat = "identity",
             fill = "#FFE0B4") +
    geom_bar(data = patient_summary,
             aes(y = BIM, x = "Patientèle"),
             stat = "identity",
             fill = "#75ABB8") +
    geom_label(data = patient_summary,
             aes(y = BIM, x = "Patientèle", label = scales::percent(BIM, accuracy = 0.1))) +
    geom_label(data = aim_summary,
             aes(y = BIM_2064, x = "Région wallonne", label = scales::percent(BIM_2064, accuracy = 0.1))) +
    labs(title = "Comparaison de la proportion de BIM entre ma patientèle transgenre et la moyenne wallonne",
         x = NULL,
         y = NULL) +
    scale_y_continuous(labels = scales::percent) +
    theme_minimal() +
    theme(plot.title = element_text(color = "#138B9E",
                                    size = 12),
          axis.text = element_text(size = 11))

dmg_plot <- ggplot() +
    geom_bar(data = aim_summary, 
             aes(y = DMG, x = "Région wallonne"),
             stat = "identity",
             fill = "#FFE0B4") +
    geom_bar(data = patient_summary,
             aes(y = DMG, x = "Patientèle"),
             stat = "identity",
             fill = "#75ABB8") +
    geom_label(data = patient_summary,
             aes(y = DMG, x = "Patientèle", label = scales::percent(DMG, accuracy = 0.1))) +
    geom_label(data = aim_summary,
             aes(y = DMG, x = "Région wallonne", label = scales::percent(DMG, accuracy = 0.1))) +
    labs(title = "Comparaison de la proportion de DMG ouverts dans ma patientèle transgenre par rapport à la moyenne wallonne",
         x = NULL,
         y = NULL) +
    scale_y_continuous(labels = scales::percent) +
    theme_minimal() +
    theme(plot.title = element_text(color = "#138B9E",
                                    size = 12),
          axis.text = element_text(size = 11))
