
# L'objectif de ces lignes de code est d'obtenir le même format de données que pour l'AIM afin de faciliter
# la comparaison. Pour ce faire, on retire les valeurs de Bruxelles et de France,
# On groupe ensuite par DMG et statut BIM et on compte les valeurs
# vraies, puis on remplace l'opérateur booléen par DMG, s'il y a un DMG ouvert, PDMG (pas de DMG) sinon 
# BIM, si la personne est BIM et AO (assuré·e ordinaire) sinon
# On crée une colonne dmg_BIM en unissant les deux valeurs et on pivote la table en format large
# pour obtenir le même format. Enfin, on se sert de mutate pour créer des moyennes et on ne garde que 
# les colonnes pertinentes 

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
    mutate(BIM = round((PDMG_BIM + DMG_BIM) / (DMG_AO + PDMG_AO + DMG_BIM + PDMG_BIM), digits = 3) * 100,
           DMG = round((DMG_AO + DMG_BIM) / (DMG_AO + DMG_BIM + PDMG_AO + PDMG_BIM), digits = 3) * 100,
           DMG_AOp = round((DMG_AO / (DMG_AO + PDMG_AO)), digits = 3) * 100,
           DMG_BIMp = round((DMG_BIM / (DMG_BIM + PDMG_BIM)), digits = 3) * 100) |>
    select(DMG, DMG_AOp, DMG_BIMp, BIM)

# Ici, on se contente de filtrer les lignes qui serviront à une comparaison et à obtenir une moyenne
# entre les deux groupes d'âge pour n'avoir qu'une valeur ) comparer. On garde les mêmes colonnes que
# pour patient_summary

aim_summary <- aim_data |>
    filter(Région == "Région wallonne") |>
    rowwise() |>
    mutate(DMG_AO = mean(c(DMG_AO_1524, DMG_AO_2544)),
           DMG_BIM = mean(c(DMG_BIM_1524, DMG_BIM_2544))) |>
    select(Région, DMG, DMG_AO, DMG_BIM, BIM_2064)
