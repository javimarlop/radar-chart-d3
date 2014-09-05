require("shiny")
require("rCharts")
shinyServer(function(input, output) { 
  passData <- reactive({
#    data <- data[data$Country %in% input$Country_filter1,]
#    rownames(data) = data$Year#data$NUTS_CODE
#    print(data)
#    data[,7:9]
	data<-data[,-(3:29)]
	data[data$PA %in% input$PA_filter1,]->data2
	as.data.frame(t(data2[,3:11]))->data3
	as.character(data2$wdpaid)->names(data3)
	print(data3)
	data3
  }) 
#######################################################################################
  #### Radar chart output 2
  output$radar1 <- renderChart2({
    a<- rCharts:::Highcharts$new() 
    a$chart(type='line',polar=TRUE, width=600,height = 350)
    a$pane(size='90%')
    a$title(text= "Environmental Variables")
    a$xAxis(categories= rownames(passData()),tickmarkPlacement='on',lineWidth=0)
    a$yAxis(gridLineInterpolation='polygon',lineWidth=0,min=0)
    a$data(passData(),pointPlacement='on')   
    return(a)    
  })
})

#output$table1 <- renderChart2({
