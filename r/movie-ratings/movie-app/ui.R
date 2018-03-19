#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Movie Ratings"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       checkboxGroupInput("Year",
                          "Release years:",
                          c(2007,2008,2009,2010,2011),
                          selected = 2007
       ),
       checkboxGroupInput("Genre",
                          "Genres:",
                          c("Action", "Adventure", "Comedy", "Drama", "Horror", "Romance", "Thriller"),
                          selected = "Action"
       ),
       radioButtons("Ratings",
                    "Ratings: ",
                    choices = c("AudienceRating", "CriticRating"),
                    selected = "CriticRating")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("mainPlot"),
       tableOutput("results")
    )
  )
))
