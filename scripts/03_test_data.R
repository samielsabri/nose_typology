# Purpose: Does validation tests on nose typology dataset by looking at logical contradictions
# Author: Sami El Sabri
# Date: 31 March 2024
# Contact: sami.elsabri@mail.utoronto.ca
# License: MIT

# Load necessary libraries
library(tidyverse)
library(testthat)

# Load the dataset
nose_typology_data <- read.csv(here::here('outputs/data/nose_typology_dataset.csv'))

# Perform tests on the dataset

# Test 1: Ensure no observation has Nasal phone check as FALSE and then Nasal onset check as TRUE, as it's contradictory
test_that("No contradictory nasal presence and onset data", {
  contradictory_rows <- sum(nose_typology_data$nasal_phoneme == FALSE & nose_typology_data$nasal_onset == TRUE)
  expect_equal(contradictory_rows, 0, info = "There are rows with contradictory nasal presence and onset data.")
})

# Test 2: Ensure all languages are unique
test_that("All languages are unique", {
  expect_equal(length(unique(nose_typology_data$language)), nrow(nose_typology_data), info = "Language entries are not unique.")
})

# Test 3: If an observation has 0 nasal phonemes, it should also have FALSE in Nasal_phone_Check
test_that("Observations with 0 nasal phonemes have FALSE in Nasal_phone_Check", {
  incorrect_rows <- sum(nose_typology_data$nasal_phoneme_number == 0 & nose_typology_data$nasal_phoneme == TRUE)
  expect_equal(incorrect_rows, 0, info = "There are rows with 0 nasal phonemes incorrectly marked as TRUE in Nasal_phone_Check.")
})

# Test 4: If an observation has >0 nasal phonemes, it should have TRUE in Nasal_phone_Check
test_that("Observations with >0 nasal phonemes have TRUE in Nasal_phone_Check", {
  incorrect_rows <- sum(nose_typology_data$nasal_phoneme_number > 0 & nose_typology_data$nasal_phoneme == FALSE)
  expect_equal(incorrect_rows, 0, info = "There are rows with >0 nasal phonemes incorrectly marked as FALSE in Nasal_phone_Check.")
})

