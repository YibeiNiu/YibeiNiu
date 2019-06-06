library(openxlsx)
library(ggplot2)
library(plotly)
library(shiny)

setwd("E://FIT//FIT5147//newFinial")
mydata = read.xlsx("Data_tables_Criminal_Incidents_Visualisation_year_ending_December_2018.xlsx", sheet = 2)

function(input, output, session) {
  
  output$plotArea = renderPlotly({
    if(input$groupby == "All")
    {
      newData = mydata %>%
        group_by(`Year.ending.December`) %>%
        summarise(`Incidents.Recorded` = sum(`Incidents.Recorded`)/1000) %>%
        as.data.frame()
      
      ggplot(newData,aes(Year.ending.December,Incidents.Recorded)) +
        geom_line(color = "blue") +
        labs(x="Year",y="Counts(thound)")
    }
    else
    {
      # newData = mydata %>%
      #   group_by(`Year.ending.December`,.dots=input$groupby) %>%
      #   summarise(`Incidents.Recorded` = sum(`Incidents.Recorded`)/1000) %>%
      #   as.data.frame() %>%
      #   subset(.[,input$groupby] %in% input$selectline)
      
      newData <-  mydata %>%
        group_by_("Year.ending.December", input$groupby) %>%
        summarise(`Incidents.Recorded` = sum(`Incidents.Recorded`)/1000) %>%
        as.data.frame() %>%
        filter_at(vars(input$groupby), any_vars(. %in% input$selectline))
      
      temp = ggplot(newData,aes_string("Year.ending.December","Incidents.Recorded",color = input$groupby)) +
        geom_line() +
        labs(x="Year",y="Counts(thound)")
      
      
    }
  })
 
  observe({
    if(input$groupby == "All")
    {
      updateCheckboxGroupInput(session,"selectline",choices = character(0))
    }
    else
    {
      if(input$selectall %% 2 == 0)
      {
        updateCheckboxGroupInput(session,"selectline", choices = c(unique(mydata[,input$groupby])),selected = c(unique(mydata[,input$groupby])))
      }
      else
      {
        updateCheckboxGroupInput(session,"selectline", choices = c(unique(mydata[,input$groupby])))
      }
    }
    
    
  })
}