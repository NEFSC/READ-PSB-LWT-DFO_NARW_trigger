fluidPage(
  useShinyjs(),
  titlePanel("DFO Trigger Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("egcanada", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")),
      downloadButton("mappdf", "Download PDF")),
    mainPanel(
      (HTML(paste('<br/>',
                  "CSV must include these columns:",'<br/>',
                  '<br/>',
                  "time, lat, lon, date, yday, species, score, number, calves, year, platform, name, id"
                  ))),
      br(),#space
      textOutput("finalmess"),
      br(),
      splitLayout(leafletOutput("map1"),leafletOutput("map2"),
                  width = 2),
      br(),
      splitLayout(leafletOutput("map3"),leafletOutput("map4"),
                  width = 2)
    )
    )
    )
    
    