#### Preamble ####
# Purpose: Creates embeddable leaflet map
# Author: Sami El Sabri
# Date: 31 March 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT

library(sf)
library(leaflet)


final_geo_data <- st_read("outputs/data/final_geo_data.geojson", quiet = TRUE)

leaflet(data = final_geo_data) %>%
  addTiles() %>%
  addCircleMarkers(
    ~language_longitude, ~language_latitude,
    popup = ~ipa_transcription,
    label = ~language,
    color = ifelse(final_geo_data$nasal_phone, 'blue', 'red'),
    radius = 8
  ) %>% addLegend(
    position = "bottomright",
    title = "Has Nasal Phone in word for 'Nose'",
    opacity = 1,
    values = ~nasal_phone,
    labels = c("False", "True"),
    colors = c('red', 'blue')
  )