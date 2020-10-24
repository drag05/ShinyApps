
# 1. load packages as character vector (doesn't work for `leaflet` package)

loadPkg <- function(x) {

     miss <- x[which(lapply(x, function(i) { require(i, character.only = TRUE) }) == FALSE)]

         if (!is.null(miss)) install.packages(miss, quietly = TRUE)


         lapply(x, require, character.only = TRUE)

}

# other custom functions

# 2. edit column names (very slow, maybe needs `Rcpp` extension)

fancyCols <- function(x) {

require(magrittr)

  tools::toTitleCase(

                     tolower(x)

                ) %>% gsub('_', '.', .)

             }


# 3. change color by parking status

getColors <- function(x) {ifelse(x == 0, 'royalblue', 'orange')}

# 4. add legend colors to data file

addLegendColors = function(x) {

        fifelse(x == 0, 'royalblue', 'orange')
}

