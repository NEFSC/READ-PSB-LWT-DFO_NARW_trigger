###################################
## Evaluating over dynamic zones ##
###################################

  ##Canada
  CRS.new<-CRS("+proj=utm +zone=20 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")

  CRS.utm<-CRS("+proj=utm +zone=20 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

  CRS.latlon<-CRS("+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs +towgs84=0,0,0")
  
######
##import shapefiles
  
  ##management measures
  ##dynamic fishing grid
  dynafish<-readOGR(shapepath, layer = "2020_Dynamic_zone")
  ##Full Atlantic grid that we got from DFO via K. Davies Oct 2019
  ATL_grid<-readOGR(shapepath, layer = "Full_ATL_grids")
  
  ##dynamic shipping
  dynaship<-readOGR(shapepath, layer = "shiplane")
  ##shipping slow zone July2019
  shipzone<-readOGR(shapepath, layer = "NARW_RZs_2020_02_07")

  ##other
  ##st. pierre et micquelon
spm<-readOGR(shapepath, layer = "spm")
  ##critical habitat
crit_habi<-readOGR(shapepath, layer = "NARW_Critical_Habitat")
  ##10 & 20 fathom lines
fath_10<-readOGR(shapepath, layer = "fath_10")
fath_20<-readOGR(shapepath, layer = "fath_20")

## projected properly
dynafish.tr<-spTransform(dynafish, CRS.new)
dynaship.tr<-spTransform(dynaship, CRS.new)
shipzone.tr<-spTransform(shipzone, CRS.new)
ATL_grid.tr<-spTransform(ATL_grid, CRS.new)
spm.tr<-spTransform(spm, CRS.new)
crit_habi.tr<-spTransform(crit_habi, CRS.new)
fath_10.tr<-spTransform(fath_10, CRS.new)
fath_20.tr<-spTransform(fath_20, CRS.new)

######  
dynafish.sp<-spTransform(dynafish.tr,CRS.latlon)
dynaship.sp<-spTransform(dynaship.tr,CRS.latlon)
shipzone.sp<-spTransform(shipzone.tr,CRS.latlon)
ATL_grid.sp<-spTransform(ATL_grid.tr,CRS.latlon)
spm.sp<-spTransform(spm.tr,CRS.latlon)
crit_habi.sp<-spTransform(crit_habi.tr, CRS.latlon)
fath_10.sp<-spTransform(fath_10.tr, CRS.latlon)
fath_20.sp<-spTransform(fath_20.tr, CRS.latlon)
