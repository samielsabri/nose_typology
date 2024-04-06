#### Preamble ####
# Purpose: Simulates phonosemantic typology data on the word "Nose"
# Author: Sami El Sabri
# Date: 31 March 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)

# Set seed for reproducibility
set.seed(2023)

# Define the number of languages to simulate
n_languages <- 200

# Simulate language names by creating unique identifiers
language_names <- paste("Language", seq(1, n_languages))
language_families <- c("Family A", "Family B", "Family C", "Family D", "Family E")
assigned_families <- sample(language_families, n_languages, replace = TRUE)

# Simulate the presence of nasal sounds in the word for "nose"
# Assuming 50% of languages have nasal sounds in their words for "nose"
nasal_presence <- sample(c(TRUE, FALSE), n_languages, replace = TRUE, prob = c(0.5, 0.5))

# Simulate whether the nasal sound is at the onset
# Assuming that among languages with nasal sounds, 40% have it at the onset
nasal_onset <- ifelse(nasal_presence, sample(c(TRUE, FALSE), n_languages, replace = TRUE, prob = c(0.4, 0.6)), FALSE)

# Combine all simulated data into a dataframe
simulated_data <- data.frame(Language = language_names,
                             Language_Family = assigned_families,
                             Nasal_Presence = nasal_presence,
                             Nasal_Onset = nasal_onset)

