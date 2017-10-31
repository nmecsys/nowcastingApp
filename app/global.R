library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyBS)
library(dygraphs)
library(lubridate)
library(zoo)
library(nowcasting)

list_series_available <- readRDS("data/list_series_available.rds")
data_series_available <- window(readRDS("data/data_series_available.rds"), start = c(2000,1), freq = 12)



# séries disponíveis dia 31/10/2017 às 10h18
# series_disponiveis <- as.numeric(as.character(RTDB()$series_code))
# labels <- sapply(series_disponiveis, FUN = function(x) BETS.search(code = x, view = F)$description)
# data_series_disponiveis <- data.frame(series_disponiveis,labels)
# saveRDS(data_series_disponiveis, "data/list_series_available.rds")
# base_extraction 31/10/2017 começando às 10h50
# x <- base_extraction(list_series_available$series_disponiveis)
# saveRDS(x, "data_series_available.rds")