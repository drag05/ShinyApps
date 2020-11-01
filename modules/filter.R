# the UI module for data filtering

selectUI <- function(id) {

 tagList(


      selectInput(NS(id, 'shiptype')
                        , label = c('Select Ship Type')
                        , choices = unique(dt[['Ship.type']])
                        , size = 3
                        , multiple = FALSE
                        , selectize = FALSE
                       )

      , uiOutput(NS(id, 'shipName')
                      , label = c('Select Ship Name')
                      , width = '200px'
                      , selectize = FALSE
                     ), tags$br()

          )

}

# the Server module for data filtering

   selectServer <- function(id, data) {


      moduleServer(id,

           function(input, output, session) {


             selShipnames <- reactive({


                        unique(data()[Ship.type %chin% input$shiptype
                                     , .(Ship.type, Shipname)], by = 'Shipname')

             })

             output$shipName <- renderUI({

               ns <- session$ns

               selectInput(ns('shipname')
                           , label = 'Select Ship Name'
                           , choices = selShipnames()[['Shipname']]
                           , multiple = TRUE
                           , selectize = FALSE
                           , size = 3)

             })


          return(reactive({

         data()[Ship.type %chin% input$shiptype & Shipname %chin% input$shipname,]

                    })

               )

         })

  }
