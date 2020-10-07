# libraries

pcks <- pkgs <- c('DT', 'geosphere', 'data.table', 'leaflet', 'ggplot2', 'shiny')

source('./utils/utilFuns.R')

loadPkg(pkgs)

dt <- readRDS('./data/shinyData.rds')

