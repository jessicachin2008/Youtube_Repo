library(shiny)
shinyUI(fluidPage(
  titlePanel(title = "test"),
  sliderInput(
    inputId = "sleep",
    label = "sleep of subjects",
    min = 1,
    max = 24,
    value = 7
  )
))