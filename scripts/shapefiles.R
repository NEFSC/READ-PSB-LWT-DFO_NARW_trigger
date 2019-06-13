###################################
## Evaluating over dynamic zones ##
###################################

  ##Canada
  CRS.new<-CRS("+proj=utm +zone=20 +datum=NAD83 +units=m +no_defs +ellps=GRS80 +towgs84=0,0,0")

  CRS.utm<-CRS("+proj=utm +zone=20 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")

  CRS.latlon<-CRS("+init=epsg:4269 +proj=longlat +ellps=GRS80 +datum=NAD83 +no_defs +towgs84=0,0,0")
  
######
dyna_ship<-readOGR(smapath, layer = "Dynamic_Shipping_Section")
crab_grid<-readOGR(smapath, layer = "Snow_Crab_Grids")
stat_fish<-readOGR(smapath, layer = "Static_Fishing_Closure")
full_grid<-readOGR(smapath, layer = "Full_Gulf_Grids")
##france
spm<-readOGR(smapath, layer = "spm")

## projected properly
##dynamic fishing grid
crab_grid.tr<-spTransform(crab_grid, CRS.new)
##dynamic shipping
dyna_ship.tr<-spTransform(dyna_ship, CRS.new)
#st. pierre et micquelon
spm<-spTransform(spm, CRS.new)

######  

dyna_ship.sp<-spTransform(dyna_ship.tr,CRS.latlon)
crab_grid.sp<-spTransform(crab_grid.tr,CRS.latlon)

