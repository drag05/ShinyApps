dataUI <- function(id) {

         tagList(

           dateRangeInput(NS(id, 'drang'), 'Select Date Range'
                    , start = median(dt$Date)
                    , end = median(dt$Date) + 2L
                    , min = min(dt$Date)
                    , max = max(dt$Date)
                    , width = '230px'
                   )
            )

}


dataServer <- function(id) {

    moduleServer(id,

     function(input, output, session) {

       dt0 <- reactive({

               dt[between(Date,
                          lower = input$drang[1]
                          , upper = input$drang[2], NAbounds = NA)
               ][order(Shipname, Date)]


             })


         return(

                reactive(dt0())

                )

        })

}