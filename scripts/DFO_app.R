##################################################
## R Shiny Application for DFO Trigger Analysis ##
##   Written By: Leah Crowe                     ##
##   Updated: June 2019                         ##             
##################################################


####################
## User interface ##
####################

ui = source('./scripts/DFOui.R', local = TRUE)$value
############
## Server ##
############

	## Define server logic 
	server = function(input, output, session) {
	  
	  ## rwData
	  source('./scripts/DFOserver.R', local = TRUE)$value
		
	}

#########################
## Create Shiny object ##
#########################

	shinyApp(ui = ui, server = server, options = list(height = 1080))
