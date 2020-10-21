
shinyUI(

  tagList(useShinyjs(),


    navbarPage(title = div(img(src = ''
                         , style = "float:left; padding: 0px 20px; width: 10px")
                           , style = "color:darkmagenta"
                           , tags$b("Baltic Sea Naval Traffic"))
               , position = 'fixed-bottom', collapsible = TRUE
               , theme = shinythemes::shinytheme('lumen')

   , tabPanel('Map',

    fluidPage(#suppress_bootstrap = TRUE,

      tags$style(type = 'text/css'
                   , ".shiny-output-error { visibility: hidden; }"
                   , ".shiny-output-error:before { visibility: hidden; }"
                   , 'html
                   , body {width:100%;height:100%}')
                   , leafletOutput('BalticSea'
                                   , width = '100%', height = '550px')
                   , absolutePanel(top = 10, right = 5
                                   , width = '230px'


# call UI module data filter

        , selectUI('filter1')


                )

         )

     )



  , tabPanel('Data',

        DT::dataTableOutput(outputId = 'tbl', height = "auto")

        )

   )

  )

)
