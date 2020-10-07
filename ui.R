
shinyUI(

    fluidPage(

         tags$style(type = 'text/css'
                   , 'html
                   , body {width:100%;height:100%}')
                , leafletOutput('BalticSea'
                , width = '75%', height = '500px')
                , absolutePanel(top = 10, right = 5
                                , width = '200px'



         ,plotOutput(outputId = 'densTBO'
                       , height = '200px'
                       , width = '190px'
                      )


          ,sliderInput(inputId = 'TBO'
                       , label = c('Mins Btw Observations')
                       , min = 1.0, max = 6000
                       , value = range(1.5, 3), step = 0.1
                       , width = '200px'
                     )

          ,selectInput(inputId = 'shiptype'
                        , label = c('Select Ship Type')
                        , choices = unique(dt[['Ship.type']])
                        , width = '200px'
                        , multiple = TRUE
                     )

             ,uiOutput(outputId = 'shipName'
                      , label = c('Select Ship Name')
                      , width = '200px'
                     ), tags$br()

          )

   )

)