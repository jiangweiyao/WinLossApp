#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Win Loss Calculator"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            h3("Introduction"),
            h5("One of the keys in successful stock market trading is understanding that an equal percent win does not cancel out an equal percent loss, and this relationship gets progressively worse as the percent loss increases. 
               This app explores this concept. Fill in a percent win and a percent loss to see what the net effect is. The heat plot on the right shows the percent return (green is gain, white is neutral, red is loss) as a function of percent win and loss, and where your entered value is."),
            numericInput("win", "Percent Win",  0, min = 0, max = 100),
            numericInput("loss", "Percent Loss", 0, min = 0, max = 100),
            submitButton(text = "Submit", icon = NULL, width = NULL),
            h2("Your net return is", align = "center"),
            h2(textOutput("WinLoss"), align = "center")
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("WLplot")
        )
    )
))
