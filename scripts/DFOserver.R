
output$finalmess <- renderText({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  disable("mappdf")
  inFile <- input$egcanada
  
  if (is.null(inFile)){
    return("")
    print("no pathway")
  }else{
      
    egdaily<-read.csv(inFile$datapath, header = TRUE, stringsAsFactors = FALSE)
    print(egdaily)
    output$finalmess<-renderText({""})
    
    withProgress(message = 'Analyzing sightings for new protection zones...', value = 0, {
    shapepath<-"./shapefiles"
    
    source('./scripts/shapefiles.R', local = TRUE)$value
    incProgress(1/5)
    source('./scripts/trigger analysis.R', local = TRUE)$value
    })
  }
  
})