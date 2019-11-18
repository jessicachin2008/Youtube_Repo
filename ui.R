library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
shinyUI(fluidPage(
  titlePanel(title = "Sleepy, why?"),
  navbarPage("My Application",
    tabPanel("Scatterplot",
             mainPanel(
               plotOutput('scatterplot')
             )),
    tabPanel("Slider",
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 1,
               max = 24,
               value = 7
             ),
             fluidRow(
               imageOutput("img1")
             )),
    tabPanel("CheckBoxes")),

  )
)
