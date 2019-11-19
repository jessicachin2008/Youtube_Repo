library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)

shinyUI(fluidPage(
  titlePanel(title = "Sleep and GPA"),
  navbarPage("My Application",
    tabPanel("Scatterplot",
             mainPanel(
               plotOutput('scatterplot')
             )),
           #  plotOutput(outputId = "scatterplot")),
    tabPanel("Slider",
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 1,
               max = 24,
               value = 7
             )),
    tabPanel("CheckBoxes")
  )
  )
)

