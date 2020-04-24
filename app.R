#############################################
## App file for DFO dynamic management APP ##
## Leah Crowe 2019, updated for 2020       ##
#############################################


#############
##  Global ##
#############

source('./scripts/global_libraries.R', local = TRUE)$value

####################
## User interface ##
####################

ui <- dashboardPage(
  dashboardHeader(title = "DFO/TC Shiny"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Fishing Trigger Analysis", tabName = "FishTab"),
      menuItem("Shipping Trigger Analysis", tabName = "ShipTab")
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "FishTab",
              source('./scripts/DFO_fish.R', local = TRUE)$value),
      ## Second tab content
      tabItem(tabName = "ShipTab",
              source('./scripts/TC_ship.R', local = TRUE)$value)
    )
  )
)

server = function(input, output, session) {
  

}

shinyApp(ui, server)
