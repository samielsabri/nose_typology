#### Preamble ####
# Purpose: Downloads dataset on the word nose I manually created using dictionaries of 230 languages
# Author: Sami El Sabri
# Date: 31 March 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT

library(tidyverse)
library(arrow)

nose_typology_data <- read_csv("inputs/data/nose_typology_dataset.csv")

write_csv(nose_typology_data, 'outputs/data/nose_typology_dataset.csv')


# write_parquet(nose_typology_data, 'nose_typology_dataset.parquet')
# this raises an error, couldn't figure it out yet
