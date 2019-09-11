###################################
## Evaluating over dynamic zones ##
###################################

  ##Canada
  CRS.new<-CRS("+proj=utm +zone=20 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")

  CRS.utm<-CRS("+proj=utm +zone=20 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

  CRS.latlon<-CRS("+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs +towgs84=0,0,0")
  
######
##import shapefiles
  ##dynamic fishing grid
crab_grid<-readOGR(shapepath, layer = "Snow_Crab_Grids")
  ##dynamic shipping
dyna_ship<-readOGR(shapepath, layer = "Dynamic_Shipping_Section")
  ##shipping slow zone July2019
slow_0719<-readOGR(shapepath, layer = "SlowZoneJuly2019")
  ##full CA fishing grid (even though it is labeled as GSL_grid - I didn't change it because I am going home 9/9)
  ##for processes on how this was made, check out "Background"
GSL_grid<-readOGR(shapepath, layer = "ecan_grid")
  ##st. pierre et micquelon
spm<-readOGR(shapepath, layer = "spm")
  ##critical habitat
crit_habi<-readOGR(shapepath, layer = "NARW_Critical_Habitat")
  ##10 & 20 fathom lines
  ## need to subset this
fath_1020<-readOGR(shapepath, layer = "10_and_20_fathom_lines_ATLCAN")

## projected properly
crab_grid.tr<-spTransform(crab_grid, CRS.new)
dyna_ship.tr<-spTransform(dyna_ship, CRS.new)
slow_0719.tr<-spTransform(slow_0719, CRS.new)
GSL_grid.tr<-spTransform(GSL_grid, CRS.new)
spm.tr<-spTransform(spm, CRS.new)
crit_habi.tr<-spTransform(crit_habi, CRS.new)
fath_1020.tr<-spTransform(fath_1020, CRS.new)


######  
crab_grid.sp<-spTransform(crab_grid.tr,CRS.latlon)
dyna_ship.sp<-spTransform(dyna_ship.tr,CRS.latlon)
slow_0719.sp<-spTransform(slow_0719.tr,CRS.latlon)
GSL_grid.sp<-spTransform(GSL_grid.tr,CRS.latlon)
spm.sp<-spTransform(spm.tr,CRS.latlon)
crit_habi.sp<-spTransform(crit_habi.tr, CRS.latlon)
fath_1020.sp<-spTransform(fath_1020.tr, CRS.latlon)
