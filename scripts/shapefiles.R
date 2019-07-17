###################################
## Evaluating over dynamic zones ##
###################################

  ##Canada
  CRS.new<-CRS("+proj=utm +zone=20 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")

  CRS.utm<-CRS("+proj=utm +zone=20 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

  CRS.latlon<-CRS("+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs +towgs84=0,0,0")
  
######
crab_grid<-readOGR(shapepath, layer = "Snow_Crab_Grids")
dyna_ship<-readOGR(shapepath, layer = "Dynamic_Shipping_Section")
slow_0719<-readOGR(smapath, layer = "SlowZoneJuly2019")
#stat_fish<-readOGR(shapepath, layer = "Static_Fishing_Closure")
GSL_grid<-readOGR(shapepath, layer = "cropped_full_grid")
##france
#spm<-readOGR(shapepath, layer = "spm")

## projected properly
##dynamic fishing grid
crab_grid.tr<-spTransform(crab_grid, CRS.new)
##dynamic shipping
dyna_ship.tr<-spTransform(dyna_ship, CRS.new)
##shipping slow zone July2019
slow_0719.tr<-spTransform(slow_0719, CRS.new)
##full fishing grid
GSL_grid.tr<-spTransform(GSL_grid, CRS.new)
#st. pierre et micquelon
#spm<-spTransform(spm, CRS.new)

######  
crab_grid.sp<-spTransform(crab_grid.tr,CRS.latlon)
dyna_ship.sp<-spTransform(dyna_ship.tr,CRS.latlon)
slow_0719.sp<-spTransform(slow_0719.tr,CRS.latlon)
GSL_grid.sp<-spTransform(GSL_grid.tr,CRS.latlon)

