fluidPage(
  useShinyjs(),
  titlePanel("TC Trigger Analysis - Potential Shipping Speed Restriction Zones"),
  sidebarLayout(
    sidebarPanel(
      textInput("bzone","Buffer Zone Around Core Area (nm)", placeholder = "15"),
      fileInput("egcanada", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")),
      downloadButton("mappdf","Download"),
      br(),#space
      tableOutput("corebounds")
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
      width = 2),
      br()
    )
    )
    )
    
    