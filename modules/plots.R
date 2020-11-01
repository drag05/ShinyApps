graphUI <- function(id) {

         tagList(

           plotOutput(NS(id, 'densTBO')
                    , height = '200px'
                    , width = '200px'
                   ), tags$br()

            )

}


graphServer <- function(id, data) {


     moduleServer(id,

           function(input, output, session) {


                  output$densTBO <- renderCachedPlot({

                    plotData <- data()[, c('Date', 'Dist', 'Ship.type')]

    # future({

              ggplot(plotData , aes(x = Date, y = Dist %/% 1e3L)) +
                    geom_point(color = 'green', fill = 'green') + theme_bw() +
                    scale_x_date('Day', date_labels = '%a', minor_breaks = NULL) +
                    theme(axis.text.x = element_text(angle = 90)) +
                    theme(axis.text.y = element_text(angle = 20)) +
                    xlab('Day Of Week') + ylab('Total Covered Distance (Km)') +
                    facet_wrap(~ Ship.type)

                                      # })

                                }

            , cacheKeyExpr = { list(data()) }

                       )

        })


}