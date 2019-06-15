fluidPage(
  useShinyjs(),
  titlePanel("TC Trigger Analysis - Potential Shipping Speed Restriction Zones"),
  sidebarLayout(
    sidebarPanel(
      fileInput("egcanada", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")),
      downloadButton("mappdf","Download")
      ),
    mainPanel(
      (HTML(paste('<br/>',
                  "CSV must include only right whale sightings and have at least these fields:",'<br/>',
                  '<br/>',
                  "time (DD/MM/YYYY 24HH:MM), lat, lon, number"
                  ))),
      br(),#space
      #uiOutput("finalmess"),
      br(),
      splitLayout(leafletOutput("map1"),leafletOutput("map2"),
      width = 2),
      br(),
      splitLayout(leafletOutput("map3"),leafletOutput("map4"),
      width = 2)
    )
    )
    )
    
    