library(sf)
library(ggthemes)

# On commence par importer les données de la carte des communes belges grâce au package sf
be_map <- st_read(dsn = "./data/communes_L08.shp")

# Afin de pouvoir faire le lien entre les données de la carte et celles de la patientèle, il est nécessaire d'opérer deux jointures
# La première jointure a pour vocation d'associer un code NSI à chaque observation en fonction de son code postal 
# On compte ensuite le nombre de patients par NSI unique 

patient_map_data <- patients_data |>
    left_join(refnis_postal, by = "postal") |>
    na.omit() |>
    group_by(NSI) |>
    summarise(count = n())

# Les données obtenues plus haut sont ensuite liées aux données de la carte importée grâce au NSI, ce qui permet de produire
# le jeu de données qui servira à l'élaboration de la carte
be_merged <- be_map |>
    left_join(patient_map_data, by = "NSI")


# Petits ajustements esthétiques sur le thème de la carte 
theme_patient_map <- theme_set(theme_map(base_size = 10,
                                         base_family = "Lato"))

# La carte est crée simplement via ggplot en utilisant le geom_sf 
patients_map <- be_merged |>
    ggplot() + 
    geom_sf(aes(fill = count), color = "#B3BABC") +
    coord_sf(datum = NA) +
    labs(title = "Mobilité géographique des patients transgenres",
         subtitle = "Patients vus entre le 01/01/22 et le 08/02/23 dans le cadre de leur THAG") +
    theme_patient_map + 
    theme(plot.title = element_text(color = "#138B9E",
                                    size = 14)) +
    scale_fill_distiller(palette = "Spectral",
                         na.value = "#D3D7D8",
                         name = "Nombre de patients")
