fluidPage(
  useShinyjs(),
  titlePanel("DFO Trigger Analysis - Potential Fishing Closures"),
  sidebarLayout(
    sidebarPanel(
      fileInput("egcanada", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")),
      br(),#space
      br(),#space
      "Centroid:",
      tableOutput("centroidtable"),
      br(),#space
      downloadButton("mappdf","Download")
      ),
    mainPanel(
      (HTML(paste('<br/>',
                  "CSV must include only right whale sightings and have at least these fields:",'<br/>',
                  '<br/>',
                  "time (D/M/YYYY 24HH:MM), lat, lon, number",'<br/>',
                  '<br/>',
                  "The trigger analysis may take a minute or two."
                  ))),
      br(),#space
      br(),#space
      textOutput("trigmessage"),
      br(),
      splitLayout(leafletOutput("map1"),leafletOutput("map2"),
      width = 2),
      br(),
      splitLayout(leafletOutput("map3"),leafletOutput("map4"),
      width = 2)
    )
    )
    )
    
    