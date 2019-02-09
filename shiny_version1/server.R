shinyServer(function(input, output){
 
  output$monthlyPlot <- renderPlot({
    
    year2 <- input$chosenyear
    submetersl <- input$meterselect
    ggplot(dfAll[(dfAll$Year %in% year2) & (dfAll$variable %in% submetersl),], aes(as.numeric(Month),value))+
      geom_line(aes(colour = variable))+
      geom_point(aes(colour = variable))+
      scale_x_continuous(name="Month", breaks=c(3,6,9,12))
    
  })

  output$dailyPlot <- renderPlot({
    
    year3<-input$chosenyear2
    month3<- input$chosenMonth
    submetersl2 <- input$meterselect2
    ggplot(dfDaily[which ((dfDaily$Year %in% year3) & (dfDaily$Month %in% month3) &(dfDaily$variable %in% submetersl2)),],aes(as.numeric(x=Day), value))+
      geom_line(aes(colour = variable))+
      geom_point(aes(colour = variable))+
      scale_x_continuous(name="Day", breaks=c(5,10,15,20,25,30))
  })
  output$hourlyPlot <- renderPlot({
    
    selectedDate <- input$chosenDate
    submetersl3 <- input$meterselect3
    ggplot(dfhourEnergy[which ((as.Date(dfhourEnergy$DateTime_2)) %in% selectedDate  &(dfhourEnergy$variable %in% submetersl3)),],aes(as.numeric(x=hour(DateTime_2)), value))+
      geom_line(aes(colour = variable))+
      geom_point(aes(colour = variable))+
      scale_x_continuous(name="Hour", breaks=c(0,4,8,12,16,20))
  })
})
      



