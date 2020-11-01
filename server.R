
shinyServer(

           function(input, output, session) {


# cached plots directory

shinyOptions(cache = diskCache(file.path('./cache')))

# call server data


    dt0 <- dataServer('data')


stopifnot(is.reactive(dt0))

# call Server module for plots

#plan(multisession)

graphServer('plot1', data = dt0)

#plan(sequential)


# call Server filter module for data

 mapData <- selectServer('filter1', data = dt0)

 stopifnot(is.reactive(mapData))


# center view coordinates

  centerView <- reactive({mapData()[, lapply(.SD, median), .SDcols = c('Lon','Lat')]})


# the data table tab

  output$tbl <- renderDataTable(mapData()[, c(1:2, 5, 7, 9:10, 12:14, 20) := NULL]
    , server = FALSE
    , rownames = FALSE
    , style = 'jqueryui'
    , extensions = c('Buttons', 'Scroller')
    , selection = 'multiple'
    , options = list(columnDefs = list(list(className = 'dt-center', targets = '_all'))
                     , scrollY = 300
                     #, scrollX = 200
                     , scroller = TRUE
                     , deferRender = TRUE
                     , dom = 'Bfrtip'
                     , buttons = c('csv'))

                   )

# the map tab

   output$BalticSea <- renderLeaflet(


      leaflet(data = mapData()) %>%
      addProviderTiles(group = "Base Map", provider = providers$CartoDB.Positron
                       , options = tileOptions) %>%
      setView(lng = centerView()$Lon, lat = centerView()$Lat, zoom = 20) %>%
      clearBounds() %>%

## is this first set of markers really needed?
      addCircleMarkers(lng = ~ Lead.lon, lat = ~ Lead.lat
                      , radius = 2
                     , fillOpacity = 0.05, group = "Ship's Path"
                      , color = ~ getColors(Is.parked)
                     , label = ~ Shipname) %>%

      addCircleMarkers(lng = ~ Lon, lat = ~ Lat
                       , radius = 2
                       , fillOpacity = 0.05, group = "Ship's Path"
                       , color = ~ getColors(Is.parked)
                       , label = ~ Shipname) %>%

      addCircleMarkers(lng = ~ mapData()[Idx == 1,]$Lead.lon, lat = ~ mapData()[Idx == 1,]$Lead.lat
                       , radius = 4
                       , fillOpacity = 0.8, weight = 1, group = "MaxDBS"
                       , color = 'red'
                       , fill = getColors(mapData()[Idx == 1,]$Is.parked)
                       , label = ~ paste(mapData()[Idx == 1]$Shipname, 'MaxDBS: ', mapData()[Idx == 1]$Dist)
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
                           , ifelse(!'royalblue' %chin% mapData()$Legend.colors, ''
                                    , sprintf('Not Parked, MaxDBS = %s meters'
                                       , mapData()[Legend.colors %chin% 'royalblue' & Idx %in% 1, Dist]))
                           , ifelse(!'orange' %chin% mapData()$Legend.colors, ''
                                    , sprintf('Parked, MaxDBS = %s meters'
                                       , mapData()[Legend.colors %chin% 'orange' & Idx %in% 1, Dist])))

                               )

                     )

           })
