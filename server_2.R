
library(shiny)
library(ggplot2)
library(lubridate)




server <- function(input, output) {


  
  output$plot1 <- renderPlot({
    year11 <- input$year1
    submeterselect <- input$meterselect
    #change amro_gatherMM to dfAll, x = as.numeric(month) to as.numeric(Month)
    ggplot(data = dfAll[dfAll$Year %in%year11 & (dfAll$variable %in% submeterselect),] ,aes(y=value,x=as.numeric(Month))) + 
      geom_line(aes(color =variable), size = 3,alpha=.8)+
      geom_point(aes(colour = variable),size = 4)+
      scale_x_continuous(name="Month", breaks=c(3,6,9,12))+
      theme_dark()+theme(plot.background = element_rect(fill = "gray"),
                         legend.background = element_rect(fill = "gray"),
                         legend.key = element_rect(colour = "transparent", fill = NA))
    
    
    
  })
  
  df1 <- dfAll %>%
    filter(variable =="All")
  df1 <- df1[order(df1$value),]
  df1 <- df1 %>%
    mutate(id = row_number())
  
  df2 <- dfAll %>%
    filter(variable =="Kitchen") 
  df2 <- df2[order(df2$value),]
  df2 <- df2 %>%
    mutate(id = row_number())
  df3 <- dfAll %>%
    filter(variable =="Laundry")
  df3 <- df3[order(df3$value),]
  df3 <- df3 %>%
    mutate(id = row_number())
  df4 <- dfAll %>%
    filter(variable =="ACandHS")
  df4 <- df4[order(df4$value),]
  df4 <- df4 %>%
    mutate(id = row_number())
  df5 <- dfAll %>%
    filter(variable =="Others")
  df5 <- df5[order(df5$value),]
  df5 <- df5 %>%
    mutate(id = row_number())
  
  
  output$Allmin <- renderValueBox({
    year11 <- input$year1
    df1 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df1[df1$value == min(df1$value),]$Month,
      subtitle = "The lowest overall energy consumption month"
    )
  })
  output$Allmax <- renderValueBox({
    year11 <- input$year1
    df1 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df1[df1$value == max(df1$value),]$Month,
      subtitle = "The highest overall energy consumption month"
    )
  })
  output$Kitchenmin <- renderValueBox({
    year11 <- input$year1
    df2 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df2[df2$value == min(df2$value),]$Month,
      subtitle = "The lowest kitchen energy consumption month"
    )
  })
  output$Kitchenmax <- renderValueBox({
    year11 <- input$year1
    df2 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df2[df2$value == max(df2$value),]$Month,
      subtitle = "The higest kitchen energy consumption month"
    )
  })
  output$Laundrymin <- renderValueBox({
    year11 <- input$year1
    df3 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df3[df3$value == min(df3$value),]$Month,
      subtitle = "The lowest laundry energy consumption month"
    )
  })
  output$Laundrymax <- renderValueBox({
    year11 <- input$year1
    df3 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df3[df3$value == max(df3$value),]$Month,
      subtitle = "The highest laundry energy consumption month"
    )
  })
  output$ACandHSmin <- renderValueBox({
    year11 <- input$year1
    df4 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df4[df4$value == min(df4$value),]$Month,
      subtitle = "The lowest air conditioner and heating water system energy consumption month"
    )
  })
  output$ACandHSmax <- renderValueBox({
    year11 <- input$year1
    df4 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df4[df4$value == max(df4$value),]$Month,
      subtitle = "The highest air conditioner and heating water system energy consumption month"
    )
  })
  output$Othersmin <- renderValueBox({
    year11 <- input$year1
    df5 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df5[df5$value == min(df5$value),]$Month,
      subtitle = "The lowest other energy consumption month"
    )
  })
  output$Othersmax <- renderValueBox({
    year11 <- input$year1
    df5 <- dfAll %>%
      filter(Year == year11)
    valueBox(
      value = df5[df5$value == max(df5$value),]$Month,
      subtitle = "The highest other energy consumption month"
    )
  })
  
  output$plot2 <- renderPlot({
    
    year22 <- input$year2
    month22 <- input$month2
    submeterselect2 <- input$meterselect2
    #change amro_gatherDD to dfDaily
    ggplot(dfDaily[(dfDaily$Year %in% year22) & (dfDaily$Month %in% month22) & (dfDaily$variable %in% submeterselect2),] ,aes(y=value,x=as.numeric(Day))) + 
      geom_line(aes(color =variable ), size = 3,alpha=.6)+
      geom_point(aes(colour = variable), size = 4)+
      scale_x_continuous(name="day", breaks=c(5,10,15,20,25,30))+
      theme_dark()+theme(plot.background = element_rect(fill = "gray"),
                         legend.background = element_rect(fill = "gray"),
                         legend.key = element_rect(colour = "transparent", fill = NA))
    
  })
  
  output$plot3 <- renderPlot({
    
    selectedDate <- input$chosenDate
    submeterselect3 <- input$meterselect3
    ggplot(dfhourEnergy[(as.Date(dfhourEnergy$DateTime_2) %in% selectedDate & (dfhourEnergy$variable %in% submeterselect3)),] ,aes(as.numeric(x=hour(DateTime_2)), value))+
      geom_line(aes(color =variable ), size = 3,alpha=.6)+
      geom_point(aes(colour = variable), size = 4)+
      scale_x_continuous(name="hour", breaks=c(1,5,10,15,20,24))+
      theme_dark()+theme(plot.background = element_rect(fill = "gray"),
                         legend.background = element_rect(fill = "gray"),
                         legend.key = element_rect(colour = "transparent", fill = NA))
    
    
    
  })
  
  output$mybill <- renderPrint({
    
    Y <- input$yearB
    M <- input$monthB
    
    readdate <- function()
    { 
      

      c <- paste(Y,M,sep = "-")
      d <- as.yearmon(c)
      yearrr <- year(d)
      monthhh <- month(d)
      mdate <- dfAll_sl[dfAll_sl$Year%in%yearrr&dfAll_sl$Month%in%monthhh,]
      cost <- (mdate$value)*14.72/100/1000
      cost1 <- round(cost)
      
      cat(paste0("        ",cost1,"  Euro "))
      
      
      if(cost1>=140){
        "\U0001f483\U0001f483"
        cat("\n\nSaving Stars :   \U0001f483")
        h4("audio",tags$audio(src = "a.mp3", type = "audio/mp3", autoplay = T, controls = NA))
        
      }
      else if(cost1<=139&cost1>=110){
        cat("\n\nSaving Stars :   \U0001f483\U0001f483")
      }
      else if(cost1<=109&cost1>=90){
        cat("\n\nSaving Stars :   \U0001f483\U0001f483\U0001f483")
      } 
      else if(cost1<=89&cost1>=80){
        cat("\n\nSaving Stars : \U0001f483\U0001f483\U0001f483\U0001f483")
        
        
        
      } 
      else if(cost1==0){
        cat("\n\n NO DATA ")
        
        
      }
      
      else{
        cat("\n\nSaving Stars : \U0001f483\U0001f483\U0001f483\U0001f483\U0001f483")
        
        
      }
      
      cat("\n\n\n\n\U0001f483\U0001f483\U0001f483\U0001f483\U0001f483 Great")
      cat("\n\n\U0001f483\U0001f483\U0001f483\U0001f483 Good" )
      cat("\n\n\U0001f483\U0001f483\U0001f483 Ok" )
      cat("\n\n\U0001f483\U0001f483 Bad" )
      cat("\n\n\U0001f483 Too Bad")
      
      
    }
    
    
    return(readdate())
    
    
    
    
  })


  
 
  
   output$savingTip <- renderPrint({
     Y <- input$yearB
     M <- input$monthB
     kcid <- df2[(df2$Year %in% Y) &(df2$Month %in% M),]$id
     launid <- df3[(df3$Year %in% Y) &(df3$Month %in% M),]$id
     acid <- df4[(df4$Year %in% Y) &(df4$Month %in% M),]$id
     
     
     if((kcid >launid) & (kcid > acid)){
       cat("\U0001f373 Turn off the heat a couple of minutes before your food is cooked.")
       cat(" \n\n\U0001f958 Always cover pots and pans they will boil much quicker. Or even better, boil the water
            in the kettle first then pour it into the pan, as this uses less energy. ")
       cat("\n\n\U0001f37D Open up the door of dishwasher after the wash cycle and let the hot dishes air-dry.
           This will save a considerable amount of electricity.")
     }
     #how to insert website link ??????
     else if((launid > kcid) & (launid > acid)){
      
       cat("\U0001f459Your washing machine and tumble dryer are two of the most power hungry appliances in the house.
           Make sure the washing machine is full before you switch it on, or use the half load setting if it has one. 
           As for the dryer — do you really need to use it? 
           Putting your clothes out on the line instead is a really simple way to save electricity, 
           and your clothes will last longer too!")
       cat("\n\n\U0001f192Putting hot food straight into the fridge is a big no-no! \U0001f645
           The fridge has to work extra hard and draw more energy to cool it down. 
           Let hot food cool on the side first before it goes in. 
           The same goes for the freezer. Avoid leaving the fridge or freezer door open for too long, defrost it when necessary.
           Finally, make sure there is at least a 10cm gap behind your fridge — this lets heat flow away
           more easily and saves electricity.")
       cat("\n\n\U0001f4A1LED bulbs are the most energy efficient lighting option .
           LED bulbs use 75% less electricity than incandescent bulbs (Energy Star).
           The also have no mercury, and last about 25 times longer than traditional
           incandescent bulbs (DoE).",
      href="www.cnet.com/topics/smart-home/best-smart-home-devices/best-led-light-bulbs/")
          
       
 
     }
     else if((acid > kcid) & (acid  > launid)){
       cat("\U0002744 During the night you don't require the same level of conscious cool. Try turning your AC down (so it is running less)
           during your sleep hours or, if your unit has one, utilize the ´sleep mode´ which lowers the output on a timer.")
       cat("\n\n\U0001f6bf Take short showers instead of baths. ")
       cat("\n\n\U0002B07 Install heat traps on your water heater tank. You could save $15–$30 on your water heating bill.")
     }
     else{
       cat("\U0001f5A5 Shutdown your computer")
       cat("\n\n\U0001f50c Unplug idle electronics Devices like televisions, microwaves, scanners, and printers use standby
                                         power, even when off. Some chargers continue to pull small amounts of energy,
                                         To avoid paying for this vampire power, use a power strip to turn all devices
                                         off at once.")
       cat("\n\n\U0001F4A1 Turn off the lights!")
     }
  })

  
}
  
shinyApp(ui = ui, server = server)
