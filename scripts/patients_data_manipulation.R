
# L'objectif de ces lignes de code est d'obtenir le même format de données que pour l'AIM afin de faciliter
# la comparaison. Pour ce faire, on retire les valeurs de Bruxelles et de France,
# On groupe ensuite par DMG et statut BIM et on compte les valeurs
# vraies, puis on remplace l'opérateur booléen par DMG, s'il y a un DMG ouvert, PDMG (pas de DMG) sinon 
# BIM, si la personne est BIM et AO (assuré·e ordinaire) sinon
# On crée une colonne dmg_BIM en unissant les deux valeurs et on pivote la table en format large
# pour obtenir le même format. Enfin, on se sert de mutate pour créer des moyennes et on ne garde que 
# les colonnes pertinentes 

source("./scripts/import_data.R", encoding = "UTF-8")

patient_summary <- patients_data |>
    filter(!province %in% c("Bruxelles", "France")) |>
    group_by(dmg, BIM) |>
    summarise(count = n()) |>
    rowwise() |>
    mutate(dmg = ifelse(isTRUE(dmg), "DMG", "PDMG"),
           BIM = ifelse(isTRUE(BIM), "BIM", "AO")) |>
    unite(dmg_BIM, c("dmg", "BIM")) |>
    pivot_wider(names_from = dmg_BIM, values_from = count) |>
    na.omit() |>
    mutate(BIM = (PDMG_BIM + DMG_BIM) / (DMG_AO + PDMG_AO + DMG_BIM + PDMG_BIM),
           DMG = (DMG_AO + DMG_BIM) / (DMG_AO + DMG_BIM + PDMG_AO + PDMG_BIM),
           DMG_AOp = (DMG_AO / (DMG_AO + PDMG_AO)),
           DMG_BIMp = (DMG_BIM / (DMG_BIM + PDMG_BIM))) |>
    select(DMG, DMG_AOp, DMG_BIMp, BIM)

# Ici, on se contente de filtrer les lignes qui serviront à une comparaison et à obtenir une moyenne
# entre les deux groupes d'âge pour n'avoir qu'une valeur ) comparer. On garde les mêmes colonnes que
# pour patient_summary

aim_summary <- aim_data |>
    filter(Région == "Région wallonne") |>
    rowwise() |>
    mutate(DMG_AO = mean(c(DMG_AO_1524, DMG_AO_2544)) / 100,
           DMG_BIM = mean(c(DMG_BIM_1524, DMG_BIM_2544)) / 100,
           DMG = DMG / 100, 
           BIM_2064 = BIM_2064 / 100) |>
    select(Région, DMG, DMG_AO, DMG_BIM, BIM_2064)
