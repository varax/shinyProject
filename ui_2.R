library(shiny)
library(shinythemes)
library(shinydashboard)

dfAll <- read.csv("dfAll.csv")
dfDaily <- read.csv("dfDaily.csv")
dfhourEnergy <- read.csv("dfhourEnergy.csv")
dfAll_sl <- read.csv("dfAll.csv")

ui <- fluidPage(theme = shinytheme("slate"),
                
                navbarPage(title = "\U0001F412 Power Consumption JAXP ",
                           
                           tabPanel("Visualise",icon = icon("bar-chart-o"), 
                                    sidebarPanel(
                                      conditionalPanel(condition="input.tabselected==1",
                                                       selectInput("year1","pleas select a year",
                                                                   choices = c("2007","2008","2009","2010"),"2007"),
                                                       checkboxGroupInput("meterselect", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                                                          selected = "All")
                                                       
                                      ),
                                      conditionalPanel(condition="input.tabselected==2",
                                                       selectInput("year2","pleas select a year",
                                                                   choices = c("2007","2008","2009","2010"),"2007"),
                                                       sliderInput("month2","Plaese Select a month",
                                                                   min = 1,max=12, value = 1,step = 1,"1"),
                                                       checkboxGroupInput("meterselect2", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                                                          selected = "All")
                                                       
                                                       
                                      ),
                                      conditionalPanel(condition="input.tabselected==3",
                                                       dateInput("chosenDate",
                                                                 "Select a Date:",
                                                                 value = "2009-01-01"),
                                                       checkboxGroupInput("meterselect3", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                                                          selected = "All")
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                      )
                                    ),
                                    mainPanel(
                                      tabsetPanel(
                                        tabPanel("year",value=1,plotOutput("plot1"),
                                                 fluidRow(valueBoxOutput("Allmin", width = 6),
                                                          valueBoxOutput("Allmax", width = 6))
                                                 ),
                                        tabPanel("month",value=2,plotOutput("plot2")),
                                        tabPanel("day",value=3,plotOutput("plot3")),
                                        id="tabselected"
                                        
                                        
                                        
                                        
                                      )
                                      
                                    )
                           ),
                           
                           
                          
                               
                                      tabPanel( title = "The Bill",icon = icon("money"),
                                                 
                                      sidebarPanel(
                                      selectInput("yearB","pleas select a year",
                                                  choices = c("2007","2008","2009","2010"),"2007"),
                                      sliderInput("monthB","Plaese Select a month",
                                                  min = 1,max=12, value = 1,step = 1,"1")
                                      
                                    ),
                                    mainPanel(
                                      h4("Your Bill for this month is:"),
                                      verbatimTextOutput("mybill")
                                     
                                      
                                      
                                    ),
                                    wellPanel(
                                      verbatimTextOutput("savingTip"))
                                    
                           ),
                           tabPanel( "Saving Ideas",icon = icon("question"),
                                    
                                    
                                    
                                    mainPanel(
                                      h3("1. Shutdown your computer:"),
                                      h4("   Computers are some of the biggest energy users in office 
                                         buildings .Turn your monitor off at night and ditch the screensaver.
                                         Today's computers can be turned on and off over 40,000 times.
                                         Opting to shut down over using a screensaver does not affect your
                                         computer's lifespan. (EnergyStar). So power down!."),
                                      h3("  2. Choose the right light:  ") ,                  
                                      h4("   LED bulbs are the most energy efficient lighting option .
                                         LED bulbs use 75% less electricity than incandescent bulbs (Energy Star).
                                         The also have no mercury, and last about 25 times longer than traditional
                                         incandescent bulbs (DoE)."),
                                      h3(" 3. Eliminate vampire power: "),   
                                      h4(" unplug idle electronics Devices like televisions, microwaves, scanners, and printers use standby
                                         power, even when off. Some chargers continue to pull small amounts of energy,
                                         even when plugged in (a good judge of this is if a charger feels warm to the touch.
                                         In the US, the total electricity consumed by idle electronics equals the annual 
                                         output of 12 power plants (EPA)."),
                                      h3("  4. Use a power strip to reduce your plug load:") ,                
                                      h4("   To avoid paying for this vampire power, use a power strip to turn all devices
                                         off at once. Flipping the switch on your power strip has the same effect as unplugging
                                         each socket from the wall, preventing phantom energy loss."),
                                      h3("  5. Turn off the lights:  "),                    
                                      h4(" Just one switch and you're done!")
                                      
                                         
                                      
                                    
                                      
                                    
                                      
                           )     
                                      
                                    
                                         ),
                           
                           
                           
                           
                           
                           
                           tabPanel("Forecasting",icon = icon("eye"),
                                    sidebarPanel(
                                      radioButtons("forecast", "Select forecasting scale:",
                                                   choices = c("Next Month", "Next Week"))
                                    ),
                                    mainPanel(
                                      conditionalPanel(condition="input.forecast == 'Next Month'  ",
                                                       plotOutput("monthforecast"),
                                                       verbatimTextOutput("forecastbill")),
                                      conditionalPanel(condition="input.forecast == 'Next Week' ",
                                                       plotOutput("weekforecast"))
                                    )
                                
                                    
                           )  ,
                           tabPanel("About the App",icon = icon("cogs"),
                                    
                                    mainPanel(
                                      HTML('<iframe width="800" height="500" src="https://www.youtube.com/embed/4Z_Mhsczhp0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'),
                                      tags$h4("powerd by"),
                                      tags$img(src="ubi.png",height=50,width=60),
                                      tags$code('www.ubiqum.com')
                                      
                                    
                                    
                                    
                           )
                           
                           
                )  
                
)
)

                           

