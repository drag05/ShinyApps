# the UI module for data filtering

selectUI <- function(id) {

 tagList(

     dateRangeInput(NS(id, 'drang'), 'Select Date Range'
                    , start = median(dt$Date)
                    , end = max(dt$Date)
                    , min = min(dt$Date)
                    , max = max(dt$Date)
                    , width = '230px'
                   )

      , plotOutput(NS(id, 'densTBO')
                    , height = '230px'
                    , width = '230px'
                    )

      , selectInput(NS(id, 'shiptype')
                        , label = c('Select Ship Type')
                        , choices = unique(dt[['Ship.type']])
                        , width = '200px', size = 3
                        , multiple = FALSE
                        , selectize = FALSE
                       )

      , uiOutput(NS(id, 'shipName')
                      , label = c('Select Ship Name')
                      , width = '200px'
                      , selectize = FALSE
                     )

          )

}

# the Server module for data filtering

   selectServer <- function(id) {

      moduleServer(id,

           function(input, output, session) {

             dt0 <- reactive({

               dt[between(Date,
                          lower = input$drang[1]
                          , upper = input$drang[2], NAbounds = NA)
               ][order(Shipname, Date)]

             })


                output$densTBO <- renderPlot(

          ggplot(dt0(), aes(x = Date, y = Dist)) +
                 geom_point(color = 'green', fill = 'green') + theme_bw() +
                 scale_x_date('Day', date_labels = '%a', minor_breaks = NULL) +
                 theme(axis.text.x = element_text(angle = 90)) +
                 theme(axis.text.y = element_text(angle = 20)) +
                 xlab('Day Of Week') + ylab('Total Covered Distance (meters)') +
                 facet_wrap(~ Ship.type)
                 
          , cacheKeyExpr = { list(input$drang[1], input$drang[2]) }

             )


        selShipnames <- reactive({


        unique(dt0()[between(Date,
                             lower = input$drang[1]
                             , upper = input$drang[2], NAbounds = NA)
                     ][Ship.type %in% input$shiptype], by = 'Shipname')

                        })

                  output$shipName <- renderUI({

                                            ns <- session$ns

                                            selectInput(ns('shipname')
                                           , label = 'Select Ship Name'
                                           , choices = selShipnames()[['Shipname']]
                                           , multiple = TRUE)

                                       })


          return(reactive({

        dt0()[Ship.type %in% input$shiptype & Shipname %in% input$shipname,]

                              })

                       )

             })

     }
