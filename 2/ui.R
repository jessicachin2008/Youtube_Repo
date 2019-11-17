library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
shinyUI(fluidPage(
  titlePanel(title = "Sleepy, why?"),
  navbarPage("My Application",
    tabPanel("Scatterplot",
             scatterplot <- sleep_data %>%
               ggplot(aes(x = AverageSleep, y = Drinks,
                          text = paste0("Depression Score: ", DepressionScore,
                                        "\nAnxiety Score: ", AnxietyScore,
                                        "\nStress Score: ", StressScore,
                                        "\nAlcohol Use: ", AlcoholUse,
                                        "\nAverage Sleep: ", AverageSleep))) +
               geom_point())
    tabPanel("Slider",
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 1,
               max = 24,
               value = 7
             )),
    tabPanel("CheckBoxes")),

  )
)
