library(dplyr)
library(tidyverse)
library(ggplot)
library(plotly)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore, StressScore, AlcoholUse, DASScore, AverageSleep, Drinks)
scatterplot <- sleep_data %>%
  ggplot(aes(x = AverageSleep, y = GPA,
             text = paste0("Depression Score: ", DepressionScore,
                           "\nAnxiety Score: ", AnxietyScore,
                           "\nStress Score: ", StressScore,
                           "\nAlcohol Use: ", AlcoholUse,
                           "\nAverage Sleep: ", AverageSleep))) +
  geom_point()
ggplotly(scatterplot)


