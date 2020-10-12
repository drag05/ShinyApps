
# 1. load packages as character vector

loadPkg <- function(x) {

     miss <- x[which(lapply(x, function(i) { require(i, character.only = TRUE) }) == FALSE)]

         if (!is.null(miss)) install.packages(miss, quietly = TRUE)

              
         lapply(x, require, character.only = TRUE)

}

# other custom functions

# 2. edit column names 

fancyCols <- function(data) {tools::toTitleCase(
                                         
                                   tolower(names(data)
               
                                         )
                                 ) %>% 

                      gsub('_', '.', .)

             }

# 3. change color by parking status

getColors <- function(x) {ifelse(x == 0, 'royalblue', 'orange')}