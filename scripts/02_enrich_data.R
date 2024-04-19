#### Preamble ####
# Purpose: Downloads and Cleans geojson files from Phoible and WALS to enrich data with geographic information
# Author: Sami El Sabri
# Date: 31 March 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT


library(sf)
library(dplyr)
library(tools)
library(tidyverse)

# Specify the path to your TXT file containing GeoJSON data


# Read the GeoJSON data which has been compiled through a combination of Phoible, WALS, and manual search
geo_data <- st_read("inputs/data/all_languages.geojson", quiet = TRUE)
nose_typology_data <- read_csv("inputs/data/nose_typology_dataset.csv")


languages_in_sample <- nose_typology_data %>% select(language)
languages_in_sample <- as.vector(languages_in_sample)

geo_data <- geo_data %>%
  mutate(name = str_to_lower(name) %>% str_trim())


# Create Function that renames languages to how they are called in our sample
rename_languages <- function(geo_data) {
  geo_data <- geo_data %>%
    mutate(name = case_when(
      name == "northern tosk albanian" ~ "albanian",
      name == "standard arabic" ~ "arabic",
      name == "eastern armenian" ~ "armenian",
      name == "north azerbaijani" ~ "azerbaijani",
      name == "mandarin chinese" ~ "mandarin",
      name == "yue chinese" ~ "cantonese",
      name == "hmong njua" ~ "hmong",
      name == "central khmer" ~ "khmer",
      name == "central kurdish" ~ "kurdish (western)",
      name == "northern kurdish" ~ "kurdish",
      name == "standard latvian" ~ "latvian",
      name == "plateau malagasy" ~ "malagasy",
      name == "standard malay" ~ "malay",
      name == "halh mongolian" ~ "mongolian",
      name == "northern pashto" ~ "pashto",
      name == "western farsi" ~ "farsi",
      name == "eastern panjabi" ~ "punjabi",
      name == "eastern yiddish" ~ "yiddish",
      name == "northern uzbek" ~ "uzbek",
      name == "tarifiyt-beni-iznasen-eastern middle atlas berber" ~ "tarifit",
      name == "mezquital otomi" ~ "otomi",
      name == "tonga (tonga islands)" ~ "tongan",
      name == "luo (kenya and tanzania)" ~ "dholuo",
      name == "central kanuri" ~ "kanuri",
      name == "northeastern dinka" ~ "dinka",
      name == "nama (namibia)" ~ "nama",
      name == "bini" ~ "edo",
      name == "orokaivaa" ~ "aeka",
      name == "aghu tharnggalu" ~ "aghu",
      name == "koyraboro senni songhai" ~ "koyraboro senni",
      name == "min nan chinese" ~ "min nan",
      name == "north saami" ~ "northern sami",
      name == "hokkaido ainu" ~ "ainu",
      name == "san miguel el grande mixtec" ~ "silacayoapan mixtec",
      name == "northern altai" ~ "altai",
      name == "forest enets" ~ "enets",
      name == "tundra nenets" ~ "nenets",
      name == "northern mansi" ~ "mansi",
      name == "komi-zyrian" ~ "komi",
      name == "komi-permyak" ~ "permyak",
      name == "south saami" ~ "southern sami",
      name == "ter saami" ~ "lule sami",
      name == "pite saami" ~ "pite sami",
      name == "kildin saami" ~ "kildin sami",
      name == "hakka chinese" ~ "hakka",
      name == "min dong chinese" ~ "min dong",
      name == "eastern oromo" ~ "oromo",
      name == "huaylas ancash quechua" ~ "ancash quechua",
      name == "central moroccan berber" ~ "central atlas tamazight",
      name == "tohono o'odham" ~ "o'odham",
      name == "northern puebla nahuatl" ~ "nahuatl",
      name == "island carib" ~ "carib",
      name == "central aymara" ~ "aymara",
      name == "paraguayan guaraní" ~ "guaraní",
      name == "maharashtrian konkani" ~ "konkani",
      TRUE ~ name  # Default case to keep the name as is if no match is found
    ))
  return(geo_data)
}

geo_data <- rename_languages(geo_data)


# Apply normalization to languages_in_sample
languages_in_sample <- sapply(languages_in_sample, function(name) str_to_lower(name) %>% str_trim())

# Filter geo_data for exact matches in languages_in_sample
filtered_geo_data <- geo_data %>%
  filter(name %in% languages_in_sample) %>% select(id, name, language_macroarea, language_pk, language_family_pk, language_latitude, language_longitude, geometry) %>% 
  rename('language'='name') %>% mutate(language=tools::toTitleCase(language))

final_geo_data <- filtered_geo_data %>% left_join(nose_typology_data, by="language") 

# Export final geojson file
st_write(final_geo_data, "outputs/data/final_geo_data.geojson", driver = "GeoJSON")
st_write(final_geo_data, "outputs/nose_typology_app/final_geo_data.geojson", driver = "GeoJSON")














