
shinyServer(

           function(input, output, session) {

      dt0 <- reactive({
             dt[Int >= input$TBO[1] & Int < input$TBO[2]]})

      output$densTBO <- renderPlot(

                       if(nrow(dt0()) == 0) return(NULL) else

                ggplot(dt0(), aes(x = Int)) + geom_density(color = 'red')

                 )


  selShipnames <- reactive({

            unique(dt[input$shiptype, on = 'Ship.type'], by = 'Shipname')

                             })

  output$shipName <- renderUI(selectInput(inputId = 'shipname'
                                          , label = 'Select Ship Name'
                                          , choices = selShipnames()[['Shipname']], multiple = TRUE))


  mapData <- reactive(

    {dt0()[Ship.type %in% input$shiptype & Shipname %in% input$shipname, ]}

                )

   centerView <- reactive(as.data.table(mapData())[, lapply(.SD, median), .SDcols = c('Lon','Lat')])

   output$BalticSea <- renderLeaflet(


    leaflet(data = mapData()) %>%
      addProviderTiles(group = "Base Map", provider = providers$CartoDB.Positron
                       , options = tileOptions) %>%
      setView( lng = centerView()$Lon, lat = centerView()$Lat, zoom = 20) %>%
      clearBounds() %>%

      addCircleMarkers(lng = ~ Lon, lat = ~ Lat
                       , radius = 2
                       , fillOpacity = 0.05, group = "Ship's Path"
                       , color = getColors(mapData()$Is.parked)
                       , label = ~ Shipname) %>%

      addCircleMarkers(lng = ~ mapData()[Idx == 1,]$Lead.lon, lat = ~ mapData()[Idx == 1,]$Lead.lat
                       , radius = 3
                       , fillOpacity = 0.3, group = "MaxDBO"
                       , color = 'red'
                       , fill = getColors(mapData()[Idx == 1, ]$Is.parked)
                       , label = ~ paste(Shipname, 'MaxDBO: ', mapData()[Idx == 1,]$Dist, 'meters')
                       ) %>%

      addCircleMarkers(lng = ~ mapData()[Idx == 1, ]$Lon, lat = ~ mapData()[Idx == 1, ]$Lat
                       , radius = 3
                       , fillOpacity = 0.1, group = "MaxDBO"
                       , color = "red"
                       , label = ~ mapData()[Idx == 1,]$Shipname) %>%

      addLayersControl(baseGroups = c("Base Map"),
                       overlayGroups = c("Ship's Path","MaxDBO"),
                       options = layersControlOptions(collapsed = FALSE)) %>%

      addLegend(position = 'bottomright'
                , colors = c('orange', 'royalblue'), values = NULL
                , labels = c(sprintf('Parked, MaxDBO = %s meters'
                                     , mapData()[Idx == 1 & Is.parked == 1, if(is.na(Dist)) '0' else Dist])
                             , sprintf('Not Parked, MaxDBO = %s meters'
                                       , mapData()[Idx == 1 & Is.parked == 0, if(is.na(Dist)) '0' else Dist]))
                )


       )


})
