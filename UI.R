
library(shiny)
library(shinydashboard)


shinyUI(
  dashboardPage(
    dashboardHeader(title = "Welcome"),
    dashboardSidebar(
      sidebarMenu(
      menuItem("Year", tabName = "monthly"),
      menuItem("Month", tabName = "daily"),
      menuItem("Day", tabName = "hourly")
    )),
    dashboardBody(
      tabItems(
        tabItem(tabName = "monthly",
                checkboxGroupInput("meterselect", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                                                                selected = "All"),
                selectInput("chosenyear", "Select a year:",c(unique(dfAll$Year))),
                plotOutput("monthlyPlot")),
        tabItem(tabName = "daily",
                checkboxGroupInput("meterselect2", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                   selected = "All"),
                selectInput("chosenyear2", "Select a year:",c(unique(dfAll$Year))),
                sliderInput("chosenMonth", "Select a month:", 1,12,1),
                plotOutput("dailyPlot")),
        tabItem(tabName = "hourly", 
                dateInput("chosenDate",
                                  "Select a Date:",
                                  value = "2009-01-01"),
                checkboxGroupInput("meterselect3", "Select the submeter:", choices = c("All", "Kitchen", "Laundry", "ACandHS","Others"),
                                   selected = "All"),
                 plotOutput("hourlyPlot"))
               
                ))
    
      )
    )

