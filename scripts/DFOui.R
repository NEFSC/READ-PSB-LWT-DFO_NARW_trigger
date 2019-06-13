fluidPage(
  useShinyjs(),
  titlePanel("DFO Trigger Analysis"),
  sidebarLayout(
    sidebarPanel(
      fileInput("egcanada", "Choose CSV File",
                accept = c(
                  "text/csv",
                  "text/comma-separated-values,text/plain",
                  ".csv")
      )
    ),
    mainPanel(
      (HTML(paste('<br/>',
                  "CSV must include these columns:",'<br/>',
                  '<br/>',
                  "Field EGNO, EG Letter, Local Time, Day, Month, Year, Latitude, Longitude, Area, Obs, Platform, Image Type, Assoc. Type, Behaviors, Notes, Photographer, Frames, First Edit, Second Edit, Final Edit",
                  '<br/>','<br/>',
                  'Latitude, Longitude, Area, Obs, Platform, and Image Type <strong>can be blank</strong>.',
                  '<br/>','<br/>',
                  "Local Time and EG Letter should <strong>not be blank</strong>.",
                  '<br/>','<br/>'))),
      br(),
      textOutput("finalmess"),
      br(),
      leafletOutput("fishzonemap")
    )
    )
    )
    
    