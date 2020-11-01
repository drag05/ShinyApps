# libraries

require(checkmate)
require(DT)
require(geosphere)
require(leaflet)
require(ggplot2)
require(shiny)
require(shinyjs)
require(data.table)
#require(future)
#require(promises)


# source utility functions and shiny modules

source('./utils/utilFuns.R')
source('./modules/data.R')
source('./modules/filter.R')
source('./modules/plots.R')



dt <- assertDataTable(readRDS('./data/shinyData.rds'))

