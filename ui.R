library(shiny)
shinyUI(fluidPage(
  titlePanel(title = "test"),
  sliderInput(
    inputId = "sleep",
    label = "Average hours of sleep per night",
    min = 1,
    max = 24,
    value = 7
  ),
  fluidRow(
    imageOutput("img1")
  )
))