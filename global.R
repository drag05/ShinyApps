# libraries

require(checkmate)
require(DT)
require(geosphere)
require(data.table)
require(leaflet)
require(ggplot2)
require(shiny)


# source utility functions and shiny modules

source('./modules/filter.R')
source('./utils/utilFuns.R')


dt <- assertDataTable(readRDS('./data/shinyData.rds'))

