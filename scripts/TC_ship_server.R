disable("mappdf")
FS<-'SHIP'
values <- reactiveValues()
df <- reactive({
  # input$file will be NULL initially. After the user selects
  # and uploads a file, it will be a data frame with 'name',
  # 'size', 'type', and 'datapath' columns. The 'datapath'
  # column will contain the local filenames where the data can
  # be found.
  
  inFile <- input$egcanada

  if (is.null(inFile)){
    return("")
  }else{
    x<-read.csv(inFile$datapath, header = TRUE, stringsAsFactors = FALSE)
    x$time<-mdy_hm(x$time)
    values$sigdate<-unique(date(x$time))
    values$webshotpath<-paste0(getwd(),"/",values$sigdate,"_map")
    
    read.csv(inFile$datapath, header = TRUE, stringsAsFactors = FALSE)
    }
  })
##observe looks at reactive but does not produce anything
observe({
  egdaily<-df()
  if(egdaily != ""){
    withProgress(message = 'Analyzing sightings for new protection zones...', value = 0, {
    shapepath<-"./shapefiles"
    
    source('./scripts/shapefiles.R', local = TRUE)$value
    incProgress(1/5)
    source('./scripts/trigger analysis.R', local = TRUE)$value
    enable("mappdf")
    
    #################
    ## Buffer Zone ##
    #################
      
      ##spatialize the corners
      corebounds_nw<-polymaxmin
      coordinates(corebounds_nw)<-~minlon+maxlat
      proj4string(corebounds_nw)<-CRS.latlon
      
      corebounds_sw<-polymaxmin
      coordinates(corebounds_sw)<-~minlon+minlat
      proj4string(corebounds_sw)<-CRS.latlon
      
      corebounds_ne<-polymaxmin
      coordinates(corebounds_ne)<-~maxlon+maxlat
      proj4string(corebounds_ne)<-CRS.latlon
      
      corebounds_se<-polymaxmin
      coordinates(corebounds_se)<-~maxlon+minlat
      proj4string(corebounds_se)<-CRS.latlon
      
      if (input$bzone == ""){
        buffnm<-15
      } else {
      buffnm<-input$bzone
      }
      print(buffnm)
      buffnm<-as.numeric(buffnm)
      bufftext<-as.character(buffnm)
      values$boundscap<-paste0("Core Area Bounds and ",bufftext,"nm Buffer Zone Around Core Area")
      ##the below calculates the distance that needs to be added to each corner (the hypotenuse) to add the dynamic buffer
      dmabuffnm<-buffnm/cos(45*pi/180)
      
      nw<-315
      sw<-225
      ne<-45
      se<-135
      
      ##coords needs to be in degrees
      nw_p=destPoint(corebounds_nw, nw, dmabuffnm/m_nm, a=6378137, f=1/298.257222101)
      sw_p=destPoint(corebounds_sw, sw, dmabuffnm/m_nm, a=6378137, f=1/298.257222101)
      ne_p=destPoint(corebounds_ne, ne, dmabuffnm/m_nm, a=6378137, f=1/298.257222101)
      se_p=destPoint(corebounds_se, se, dmabuffnm/m_nm, a=6378137, f=1/298.257222101)
      #make buffer polygons
      #cbind the dynamic buffer zone with the original cardinal direction point
      #rbind them together and then group by Clustmax
      nwdf<-as.data.frame(cbind(corebounds_nw,nw_p))
      swdf<-as.data.frame(cbind(corebounds_sw,sw_p))
      nedf<-as.data.frame(cbind(corebounds_ne,ne_p))
      sedf<-as.data.frame(cbind(corebounds_se,se_p))
      
      dmabuff<-rbind(nwdf,swdf,sedf,nedf,nwdf)
      
      dmabuff<-dmabuff %>% 
        dplyr::select(cluster, lon, lat)
      
      IDclustbuff<-split(dmabuff, dmabuff$cluster)
      
      IDclustbuff<-lapply(IDclustbuff, function(x) { x["cluster"] <- NULL; x })
      
      polyclustbuff<-lapply(IDclustbuff, Polygon)
      
      polyclust_buff<-lapply(seq_along(polyclustbuff), function(i) Polygons(list(polyclustbuff[[i]]), ID = names(IDclustbuff)[i]))
      
      polyclust_spbuff<-SpatialPolygons(polyclust_buff, proj4string = CRS.latlon)
      
      polyclust_sp_dfbuff<-SpatialPolygonsDataFrame(polyclust_spbuff, data.frame(id = unique(dmabuff$cluster), row.names = unique(dmabuff$cluster)))
      
      print("new dma bounds")
      boundsbuff<-polyclust_spbuff %>%
        fortify() %>%
        mutate(LAT = round(lat, 2), LON = round(long, 2))%>%
        dplyr::select(id,order,LAT,LON)%>%
        dplyr::rename("ID" = "id", "VERTEX" = "order")
      
      
################
## Buffer map ##  
################
      
      minlonb<-min(boundsbuff$LON)
      minlatb<-min(boundsbuff$LAT)
      maxlonb<-max(boundsbuff$LON)
      maxlatb<-max(boundsbuff$LAT)
      
      map5<-mapbase %>% 
        addCircleMarkers(data = centroid, weight = 2, color = "red", fillOpacity = 1, radius = 5) %>%
        addPolygons(data = polyclust_sp, weight = 2, color = "blue")%>%
        addPolygons(data = polyclust_spbuff, weight = 2, color = "purple")%>%
        addLegend(colors = c("red"), labels = "Calculated Center of Core Area", opacity = 0.9, position = "topleft")%>%
        addLegend(colors = c("blue","purple"), labels = c("Core Area","Buffer Zone"), opacity = 0.3, position = "topleft")%>%
        clearBounds()%>%
        fitBounds(minlonb,minlatb,maxlonb,maxlatb)
      
      snap(map5,5) 
      print("map 5")
      output$map5<-renderLeaflet({map5})
      
##############
## core and buffer table
##############
      
      bothbounds<-bounds%>%
        left_join(boundsbuff, by = c("ID","VERTEX"))%>%
        dplyr::rename("Core Latitude" = "LAT.x", "Core Longitude" = "LON.x","Buffer Latitude" = "LAT.y","Buffer Longitude" = "LON.y")
      print(bothbounds)
      
      values$bothbounds<-bothbounds%>%
        filter(VERTEX != 5)
      output$bothbounds<-renderTable({values$bothbounds},  striped = TRUE)
      
    })
  }

})
    output$mappdf<-downloadHandler(
      
      filename = function() {
        paste0(values$sigdate,"_Shipping_Trigger_Analysis.pdf")},
      content = function(file) {
        tempReport<-file.path("./scripts/SHIP_TrigAnalysisPDF.Rmd")
        
        file.copy("SHIP_TrigAnalysisPDF.Rmd", tempReport, overwrite = FALSE)
        print("button pressed")
        
        params<-list(sigdate = values$sigdate, webshotpath = values$webshotpath, bothbounds = values$bothbounds, boundscap = values$boundscap, cent_df = values$cent_df)
        
        rmarkdown::render(tempReport, output_file = file,
                          params = params,
                          envir = new.env(parent = globalenv())
        )
        })
    



