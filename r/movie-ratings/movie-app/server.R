#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)

movies<- read.csv("Movie-Ratings.csv")
# rename columns to get rid of special characters
colnames(movies)<-c("Film", "Genre", "CriticRating", "AudienceRating", 
                    "BudgetMillions", "Year")
# check stucture of the data (6 variables:562 objects loaded)
print(str(movies))
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$mainPlot <- renderPlot({
      filtered <- 
          movies %>%
          filter(Genre ==input$Genre,
                 Year == input$Year
          )
     if(input$Ratings == "AudienceRating"){
      ggplot(filtered, aes(x=BudgetMillions, y=AudienceRating,
                              colour=Genre, size=BudgetMillions)) +
      geom_point(aes(x=BudgetMillions))
     }
      else{
          ggplot(filtered, aes(x=BudgetMillions, y=CriticRating,
                               colour=Genre, size=BudgetMillions)) +
              geom_point(aes(x=BudgetMillions)) 
      }
  })
})
