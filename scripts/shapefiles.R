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
  ##Full Atlantic grid that we got from DFO via K. Davies Oct 2019
ATL_grid<-readOGR(shapepath, layer = "Full_ATL_grids")
  ##st. pierre et micquelon
spm<-readOGR(shapepath, layer = "spm")
  ##critical habitat
crit_habi<-readOGR(shapepath, layer = "NARW_Critical_Habitat")
  ##10 & 20 fathom lines
fath_10<-readOGR(shapepath, layer = "fath_10")
fath_20<-readOGR(shapepath, layer = "fath_20")

## projected properly
crab_grid.tr<-spTransform(crab_grid, CRS.new)
dyna_ship.tr<-spTransform(dyna_ship, CRS.new)
slow_0719.tr<-spTransform(slow_0719, CRS.new)
ATL_grid.tr<-spTransform(ATL_grid, CRS.new)
spm.tr<-spTransform(spm, CRS.new)
crit_habi.tr<-spTransform(crit_habi, CRS.new)
fath_10.tr<-spTransform(fath_10, CRS.new)
fath_20.tr<-spTransform(fath_20, CRS.new)

######  
crab_grid.sp<-spTransform(crab_grid.tr,CRS.latlon)
dyna_ship.sp<-spTransform(dyna_ship.tr,CRS.latlon)
slow_0719.sp<-spTransform(slow_0719.tr,CRS.latlon)
ATL_grid.sp<-spTransform(ATL_grid.tr,CRS.latlon)
spm.sp<-spTransform(spm.tr,CRS.latlon)
crit_habi.sp<-spTransform(crit_habi.tr, CRS.latlon)
fath_10.sp<-spTransform(fath_10.tr, CRS.latlon)
fath_20.sp<-spTransform(fath_20.tr, CRS.latlon)
