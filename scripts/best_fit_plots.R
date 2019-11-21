library(dplyr)
library(tidyverse)
library(ggplot2)
library(plotly)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore, StressScore, AlcoholUse, DASScore, AverageSleep, Drinks, Happiness)

lm_eqn <- function(sleep_data){
  m <- lm(Happiness ~ AverageSleep, sleep_data);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(unname(coef(m)[1]), digits = 2),
                        b = format(unname(coef(m)[2]), digits = 2),
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));
}

scatterplot <- sleep_data %>%
  ggplot(aes(x = AverageSleep, y = Happiness)) +
  geom_point(shape = 1) +
  geom_smooth(method = lm, sm = FALSE) +
  geom_text(x = 10, y = 30, label = lm_eqn(sleep_data), parse = TRUE)
scatterplot


