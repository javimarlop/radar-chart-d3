library("shiny")
library("rCharts")
shinyUI(pageWithSidebar(  
  headerPanel( "Habitat Explorer"), 
  sidebarPanel(
    selectInput(inputId = "PA_filter1",
                label = (HTML("<b>Select a WDPA ID:</b>")),
                multiple = FALSE,
                selected = '15',
               choices = list("31" = "31", "61" = "61","80"="80","15"="15" )),
                                             
#    checkboxGroupInput(inputId = 'country_filter1',
#                       label = (HTML("<b>Select the region of interest:</b>")), 
#                       sort(unique(data$Country)),
#                       selected = sort(unique(data$Country))),
#    radioButtons(inputId ="year",
#                 label = (HTML("<b>Select the year of interest:</b>")),
#                 choices = list ("2010"= "2010",
#                                 "2020" = "2020",
#                                 "2050" = "2050"
#                 )
#    ),
    submitButton(text="Run", icon("refresh"))  
  ),
  # Show the results from the query  
  mainPanel(  
    tabsetPanel( 
      tabPanel("Habitat zonation", showOutput ("radar1", "highcharts"))
    )
  )))
