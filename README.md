# DFO/TC Right Whale Sightings Trigger Analysis

## Getting Started

Required packages include:

```
library(data.table)
library(dplyr)
library(extrafont)
library(fontcm)
library(geosphere)
library(ggplot2)
library(htmlwidgets)
library(igraph)
library(knitr)
library(leaflet)
library(leaflet.esri)
library(lubridate)
library(maptools)
library(raster)
library(RColorBrewer)
library(reshape)
library(rgdal)
library(rgeos)
library(rlist)
library(rmarkdown)
library(scales)
library(shiny)
library(shinydashboard)
library(shinyjs)
library(sf)
library(sp)
library(tinytex)
library(webshot)
library(zoo)
```
You will need to have PhantomJS, which you can install by running the code below:
```
webshot::install_phantomjs()
```

Finally, if you do not get TRUE when you run `tinytex:::is_tinytex()`, then you probably need to run this: `tinytex::install_tinytex(force=TRUE)`. More info on this process and the TinyTex package can be found here: https://yihui.name/tinytex/

## Running the App
The app can be launched by running `shiny::runGitHub("DFO_dyna", username = "leahcrowe", ref = "master")` in your RStudio environment. Click 'Run App' to get started. In the window that pops up, click "Open in Browser".

![](visual_instructions/browser.PNG)


This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.
