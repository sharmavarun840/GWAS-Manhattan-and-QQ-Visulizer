
# Load Packages ------------------

library(shiny)
library(qqman)
library(data.table)
library(CMplot)
library(manhattanly)
library(plotly)

# Import data

data <- read.csv("./data/varunnew.csv")


# Source all the files in the code folder ---------------

for (file in list.files("code", full.names = TRUE)){
  source(file, local = TRUE)
}


# File list in data folder

tables <- list.files(path = "./data", full.names = FALSE)