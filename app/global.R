library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyBS)
library(dygraphs)
library(lubridate)
library(zoo)
library(nowcasting)
library(xts)
library(plotly)

# just do it --------------
list_series_available <- readRDS("data/list_series_available.rds")
data_series_available <- window(readRDS("data/data_series_available.rds"), start = c(2000,1), freq = 12)

# homepage ---------------
hoje<-Sys.time()-hours(3)
# download PIB usando BETS
# pib<-na.omit(mestri(lag(base_extraction(22109),-2)))
# pib <- BETS.get("22109", to = c("2017","1"), frequency = 4)
# saveRDS(pib,"data/pib.rds")
pib <- readRDS("data/pib.rds")
retpib <- window(round((pib/lag(pib, k = -1) -1)*100,2), start = c(2007,1), freq = 4)
datashiny <- readRDS("data/datashiny.rds")
RMSE <- datashiny$RMSE

# leitura dos resultados do pibnow
resul_pibnow_yoy <- datashiny$yoy
ncol_pibnow_yoy <- ncol(resul_pibnow_yoy)
nrow_pibnow_yoy <- nrow(resul_pibnow_yoy)

# ts nowcasting
nowcasting_yoy <- round((xts(resul_pibnow_yoy[,ncol_pibnow_yoy - 1], order.by = as.Date(rownames(resul_pibnow_yoy)))),2)
data_nowcasting_yoy <- colnames(resul_pibnow_yoy)[ncol_pibnow_yoy - 1]
tri_nowcasting_yoy <-  paste0(substr(data_nowcasting_yoy,7,7),"º TRIMESTRE ",substr(data_nowcasting_yoy,1,4))
data_quadrado_now_yoy <- as.Date(as.yearqtr(names(datashiny$yoy)))[2]

# ts backcasting
backcasting_yoy <- round((xts(resul_pibnow_yoy[,ncol_pibnow_yoy - 2], order.by = as.Date(rownames(resul_pibnow_yoy)))),2)
data_backcasting_yoy <- colnames(resul_pibnow_yoy)[ncol_pibnow_yoy - 2]
tri_backcasting_yoy <- paste0(substr(data_backcasting_yoy,7,7),"º TRIMESTRE ",substr(data_backcasting_yoy,1,4))
data_quadrado_back_yoy <- as.Date(as.yearqtr(names(datashiny$yoy)))[1]

# ts forecasting
forecasting_yoy <- round((xts(resul_pibnow_yoy[,ncol_pibnow_yoy], order.by = as.Date(rownames(resul_pibnow_yoy)))),2)
data_forecasting_yoy <- colnames(resul_pibnow_yoy)[ncol_pibnow_yoy]
tri_forecasting_yoy <- paste0(substr(data_forecasting_yoy,7,7),"º TRIMESTRE ",substr(data_forecasting_yoy,1,4))
data_quadrado_fore_yoy <- as.Date(as.yearqtr(names(datashiny$yoy)))[3]

# séries disponíveis dia 31/10/2017 às 10h18
# series_disponiveis <- as.numeric(as.character(RTDB()$series_code))
# labels <- sapply(series_disponiveis, FUN = function(x) BETS.search(code = x, view = F)$description)
# data_series_disponiveis <- data.frame(series_disponiveis,labels)
# saveRDS(data_series_disponiveis, "data/list_series_available.rds")
# base_extraction 31/10/2017 começando às 10h50
# x <- base_extraction(list_series_available$series_disponiveis)
# saveRDS(x, "data_series_available.rds")