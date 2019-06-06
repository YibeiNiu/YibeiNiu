library(openxlsx)
library(ggplot2)
library(plotly)
library(shiny)

setwd("E://FIT//FIT5147//newFinial")
mydata = read.xlsx("Data_tables_Criminal_Incidents_Visualisation_year_ending_December_2018.xlsx", sheet = 2)
mydata_sheet4 = read.xlsx("Data_tables_Criminal_Incidents_Visualisation_year_ending_December_2018.xlsx", sheet = 4)

navbarPage("Crime Statistic Dashborad", id = "Tabs",
           tabPanel("Crime curve",
                    sidebarPanel(
                      selectInput("groupby","Grouped by",
                                  c("All"="All",
                                    "Offence.Division" = "Offence.Division",
                                    "Offence.Subdivision" = "Offence.Subdivision")),
                      actionButton("selectall", "All"),
                      checkboxGroupInput("selectline", "",c())
                      
                    ),
                    
                    mainPanel(
                      h1(textOutput("caption")),
                      plotlyOutput("plotArea")
                    )
           )
)