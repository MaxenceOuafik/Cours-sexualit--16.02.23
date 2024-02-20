library(gmapsdistance)

patients_geocoded$destination <- c("50.64180361036909+5.572660940573747")

origin <- patients_geocoded$coord
destination <- patients_geocoded$destination

distance_matrix <- as.data.frame(
    gmapsdistance(
        origin = origin, 
        destination = destination,
        mode = "driving",
        combinations = "pairwise"
        )
        ) |>
    mutate(
        duration_car = round(Time.Time / 60),
        distance_car = round(Distance.Distance / 1000)
        ) |>
    select(coord = Distance.or, distance_car, duration_car) |>
    distinct()

distance_matrix_transit <- as.data.frame(
    gmapsdistance(
        origin = origin, 
        destination = destination,
        mode = "transit",
        arr_date = "2023-10-09",
        arr_time = "15:00:00",
        combinations = "pairwise"
        )
        ) |>
    mutate(
        duration_transit = round(Time.Time / 60),
        distance_transit = round(Distance.Distance / 1000)
        ) |>
    select(coord = Distance.or, duration_transit, distance_transit) |>
    distinct()

patients_distance <- patients_geocoded |>
    left_join(distance_matrix, by = "coord") |>
    left_join(distance_matrix_transit, by = "coord") |>
    select(-coord, -destination) |>
    pivot_longer(
        cols = c(duration_car, duration_transit, distance_car, distance_transit), 
        names_to = c(".value", "transport"),
        names_sep = "_")
            
patients_duration <- patients_distance |>
    mutate(
        category = factor(
            case_when(
                duration <= 10 ~ 1,
                duration %in% c(11:20) ~ 2,
                duration %in% c(21:30) ~ 3, 
                duration %in% c(31:60) ~ 4,
                duration %in% c(61:90) ~ 5, 
                duration > 90 ~ 6
                ),
            labels = c(
                "Très bonne (Maximum 10 minutes)",
                "Bonne (11 à 20 minutes)",
                "Faible (21 à 30 minutes)",
                "Mauvaise (31 à 60 minutes)",
                "Très mauvaise (61 à 90 minutes)",
                "Excécrable (Plus de 90 minutes)"
                ),
            ordered = TRUE
            )
        ) |>
    group_by(category, transport) |>
    summarize(patients = n()) |>
    mutate(
        percent = round(
            (patients / (nrow(patients_distance) / 2)), 
            digits = 3
            )
        ) 

plot_subtitle <- paste(
    "Distance moyenne (en voiture):", 
    round(mean(patients_distance$distance[patients_distance$transport == "car"])), 
    "kilomètres", 
    "(entre", 
    min(patients_distance$distance[patients_distance$transport == "car"]), 
    "et", 
    max(patients_distance$distance[patients_distance$transport == "car"]), 
    "kilomètres)", 
    "\n",
    "Durée moyenne du trajet (en voiture) :", 
    round(mean(patients_distance$duration[patients_distance$transport == "car"])), 
    "minutes",
    "(entre",
    min(patients_distance$duration[patients_distance$transport == "car"]),
    "et",
    max(patients_distance$duration[patients_distance$transport == "car"]),
    "minutes)",
    "\n",
    "Durée moyenne du trajet (en transports en commun) :",   
    round(mean(patients_distance$duration[patients_distance$transport == "transit"])), 
    "minutes",
    "(entre",
    min(patients_distance$duration[patients_distance$transport == "transit"]),
    "et",
    max(patients_distance$duration[patients_distance$transport == "transit"]),
    "minutes)")


duration_plot <- ggplot(data = patients_duration) +
    geom_bar(
        aes(
            x = category, 
            y = percent, 
            fill = transport),
        stat = "identity", 
        position = "dodge") +
    geom_label(aes(
        x = category, 
        y = percent, 
        label = scales::percent(percent),
        group = transport),
        position = position_dodge(width = 0.9)
        ) +
    scale_y_continuous(
        labels = scales::percent, 
        limits = c(0, 0.45)
        ) +
    scale_fill_discrete(
        name = "Mode de transport",
        labels = c("Voiture", "Transports en commun")) +
    labs(title = "Catégories de durée de trajet pour se rendre en consultation",
         subtitle = plot_subtitle,
         x = "Catégories",
         y = "Nombre de patients",
         caption = "Basé sur les consultations entre entre le 01/01/22 et le 08/02/23") +
    theme_minimal()

ggsave(
    "duration_plot.png", 
    plot = duration_plot, 
    device = png, 
    bg = "white",
    width = 4000,
    height = 2500,
    dpi = 300,
    units = "px")