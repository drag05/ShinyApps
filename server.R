
shinyServer(

           function(input, output, session) {
                      
# cached plots directory

shinyOptions(cache = diskCache(file.path('./cache')))

# call Server module data filter

  mapData <- selectServer('filter1')

# center view coordinates

  centerView <- reactive({mapData()[, lapply(.SD, median), .SDcols = c('Lon','Lat')]})

# data table

  output$tbl <- DT::renderDataTable(mapData()

    , server = FALSE
    , rownames = FALSE
    , style = 'jqueryui'
    , extensions = c('Buttons', 'Scroller')
    , selection = 'multiple'
    , options = list(columnDefs = list(list(className = 'dt-center', targets = '_all'))
                     , scrollY = 300
                     , scrollX = 200
                     , scroller = TRUE
                     , deferRender = TRUE
                     , dom = 'Bfrtip'
                     , buttons = c('csv'))

                   )



   output$BalticSea <- renderLeaflet(

      leaflet(data = mapData()) %>%
      addProviderTiles(group = "Base Map", provider = providers$CartoDB.Positron
                       , options = tileOptions) %>%
      setView(lng = centerView()$Lon, lat = centerView()$Lat, zoom = 20) %>%
      clearBounds() %>%

      addCircleMarkers(lng = ~ Lead.lon, lat = ~ Lead.lat
                       , radius = 2
                       , fillOpacity = 0.05, group = "Ship's Path"
                       , color = getColors(mapData()$Is.parked)
                       , label = ~ Shipname) %>%

      addCircleMarkers(lng = ~ Lon, lat = ~ Lat
                       , radius = 2
                       , fillOpacity = 0.05, group = "Ship's Path"
                       , color = getColors(mapData()$Is.parked)
                       , label = ~ Shipname) %>%

      addCircleMarkers(lng = ~ mapData()[Idx == 1,]$Lead.lon, lat = ~ mapData()[Idx == 1,]$Lead.lat
                       , radius = 4
                       , fillOpacity = 0.8, weight = 1, group = "MaxDBS"
                       , color = 'red'
                       , fill = getColors(mapData()[Idx == 1,]$Is.parked)
                       , label = ~ paste(mapData()[Idx == 1,]$Shipname, 'MaxDBS: ', mapData()[Idx == 1,]$Dist)
                       ) %>%

      addCircleMarkers(lng = ~ mapData()[Idx == 1, ]$Lon, lat = ~ mapData()[Idx == 1, ]$Lat
                       , radius = 4
                       , fillOpacity = 0.1, weight = 1, group = "MaxDBS"
                       , color = "red", label = ~ mapData()[Idx == 1,]$Shipname
                       ) %>%

      addLayersControl(baseGroups = c("Base Map"), position = 'topleft'
                       , overlayGroups = c("Ship's Path","MaxDBS")
                       , options = layersControlOptions(collapsed = FALSE)
                       ) %>%

     addLegend(position = 'bottomleft', title = "Max Geodesic Dist Btw Signals", values = NULL
              , colors = c('red', 'royalblue', 'orange')
              , labels = c('MaxDBS Markers'
                           , ifelse(!'royalblue' %in% mapData()$Legend.colors, ''
                                    , sprintf('Not Parked, MaxDBS = %s meters'
                                       , mapData()[Legend.colors %in% 'royalblue' & Idx %in% 1, max(Dist)]))
                           , ifelse(!'orange' %in% mapData()$Legend.colors, ''
                                    , sprintf('Parked, MaxDBS = %s meters'
                                       , mapData()[Legend.colors %in% 'orange' & Idx %in% 1, max(Dist)])))

                                )

                     )

           })
