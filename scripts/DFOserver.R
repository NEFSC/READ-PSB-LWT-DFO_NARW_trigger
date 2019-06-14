disable("mappdf")
df <- reactive({
  # input$file1 will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFile <- input$egcanada
  
  if (is.null(inFile)){
    return("")
    print("no pathway")
  }else{
    read.csv(inFile$datapath, header = TRUE, stringsAsFactors = FALSE)}
  })


obslist<-observe({
  egdaily<-df()
  print(egdaily)
  if(egdaily != ""){
    withProgress(message = 'Analyzing sightings for new protection zones...', value = 0, {
    shapepath<-"./shapefiles"
    
    source('./scripts/shapefiles.R', local = TRUE)$value
    incProgress(1/5)
    source('./scripts/trigger analysis.R', local = TRUE)$value
    enable("mappdf")
    })
    
    output$mappdf<-downloadHandler(
      
      filename = paste0(sigdate,"_Trigger_Analysis.pdf"),
      content = function(file) {
        tempReport<-file.path("./scripts/TrigAnalysisPDF.Rmd")
        print("button pressed")
        file.copy("TrigAnalysisPDF.Rmd", tempReport, overwrite = FALSE)
        params<-list(sigdate = sigdate, webshotpath = webshotpath)
        
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )})
    
    }
})

