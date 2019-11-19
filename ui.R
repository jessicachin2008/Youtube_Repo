library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
combined_sleep_data <- read.csv("data/combined_sleep_gpa.csv")
shinyUI(fluidPage(
  titlePanel(title = "Sleepy, why?"),
  navbarPage("My Application",
    tabPanel("BoxPlot",
             mainPanel(
               plotOutput('boxplot')
             )),
    tabPanel("Slider",
             sidebarPanel(
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 1,
               max = 24,
               value = 7
             ),
             imageOutput("img1")),
             mainPanel(
               plotOutput('scatterplot')
             )),
    tabPanel("CheckBoxes")),

  )
)
