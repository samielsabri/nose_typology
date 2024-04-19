library(shiny)
library(leaflet)
library(sf)
library(tidyverse)
library(dplyr)


final_geo_data <- st_read('final_geo_data.geojson', quiet = TRUE)

# Define UI
ui <- fluidPage(
  titlePanel("Cross-Linguistic Sound Symbolism in the word for 'Nose'"),
  sidebarLayout(
    sidebarPanel(
      h3("Map Instructions"),
      p("Follow these steps to interact with the map:"),
      tags$ul(
        tags$li("Drag the map to navigate."),
        tags$li("Use the zoom buttons or trackpad to zoom in and out."),
        tags$li("Hover over a marker to get the language's name."),
        tags$li("Slick over a marker to get the phonetic transcription for the word for 'nose'")
      ),
    ),
    
    mainPanel(
      leafletOutput("map")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$map <- renderLeaflet({
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
  })
}

# Run the app
shinyApp(ui = ui, server = server)
