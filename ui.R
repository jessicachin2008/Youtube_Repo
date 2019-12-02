library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(rlang)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
combined_sleep_data <- read.csv("data/combined_sleep_gpa.csv")
shinyUI(fluidPage(
  titlePanel(title = "Sleepy, why?"), #title
  navbarPage("Sections",
    tabPanel("Trend Lines", # first tab
             mainPanel(
               selectInput("select1", label = h4("Parameter 1 (X)"),
                           choices = list("Depression Score" =
                                            "DepressionScore",
                                          "Anxiety Score" = "AnxietyScore",
                                          "Stress Score" = "StressScore",
                                          "Number of Drinks" = "Drinks",
                                          "Average Sleep" = "AverageSleep"),
                           selected = 1),
               selectInput("select2", label = h4("Parameter 2 (Y)"),
                           choices = list("Depression Score" =
                                            "DepressionScore",
                                          "Anxiety Score" = "AnxietyScore",
                                          "Stress Score" = "StressScore",
                                          "Number of Drinks" = "Drinks",
                                          "Average Sleep" = "AverageSleep"),
                           selected = 1),
               plotOutput("trend")
             )),
    tabPanel("Slider", # second tab
             sidebarPanel(
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 3,
               max = 11,
               value = 7
             ),
             imageOutput("img1")),
             mainPanel(
               plotOutput("barChart")
             )),
    tabPanel("Sleep Simulation", # third tab
             sidebarPanel(
               sliderInput(
                 inputId = "hoursOfSleep",
                 label = "Please specify hours of sleep",
                 min = 3,
                 max = 11,
                 value = 7
               ),
               selectInput("depressionLevel",
                           label = h3("Please choose depression level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               selectInput("anxietyLevel",
                           label = h3("Please choose anxiety level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               selectInput("stressLevel",
                           label = h3("Please choose stress level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               sliderInput(
                 inputId = "numberOfDrinks",
                 label = "Please specify amount of drinks taken",
                 min = 0,
                 max = 24,
                 value = 0
               ),
               actionButton("simulate", label = "Simulate"),
               hr(),
               actionButton("reset", label = "Reset")
             ),
             mainPanel(
               h5("In this section of our website, we are simulating
                  how the hours of sleep, depression level, anxiety level,
                  stress level, and the numbers of drinks affects your
                  overall happiness level. The way we determined the
                  happiness score was finding the line of regression
                  for each variable compared to the happiness score
                  that was provided in the data. Using this, We formulated
                  a equation that can determine the happiness level of the
                  person. Make note that this scale is 100% based on data
                  provided and regression lines, so some of the numbers may
                  seem off."),
               textOutput("HappinessScore"),
               plotOutput("happinessPlot")
             )),
    tabPanel("About", # the about tab
             mainPanel(
               h5("We decided to focus on sleep as our topic because we wanted to know
                  how sleep can affect college students. Stress, anxiety, and depression
                  can play a huge role on how many hours a person sleeps per day. We wanted
                  to observe how mental illness can affect someone's happiness and depicted 
                  happiness score as one of our visualizations. The other two information
                  visualizations were based on a slider and trend lines. We hope that our
                  project can help other college students who suffer from sleep deprivation
                  to get an idea on what factors can effect a person's sleep cycle. We do not
                  give any specific soultions but include information that the reader can
                  analyze and think about what changes they could implement into their lives.
                  This project was done by Samuel Kim, Jessica Chin, and Abdirihman Mohamud.")
             )))
  )
)
