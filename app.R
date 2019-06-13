#############################################
## App file for DFO dynamic management APP ##
## Leah Crowe 2019                         ##
#############################################


#############
##  Global ##
#############

source('./scripts/global_libraries.R', local = TRUE)$value

####################
## User interface ##
####################

ui <- dashboardPage(
  dashboardHeader(title = "DFO Shiny"),
  ## Sidebar content
  dashboardSidebar(
    sidebarMenu(
      menuItem("Trigger Analysis", tabName = "Trig")
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "Trig",
              source('./scripts/DFO_app.R', local = TRUE)$value
      )
    )
  )
)

server = function(input, output, session) {
  

}

shinyApp(ui, server)
