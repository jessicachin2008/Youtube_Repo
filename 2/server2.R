library(shiny)
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
server <- shinyServer(
  function(input, output) {
    output$scatterplot <- renderPlot({ scatterplot <- sleep_data %>%
      ggplot(aes(x = AverageSleep, y = GPA,
                 text = paste0("Depression Score: ", DepressionScore,
                               "\nAnxiety Score: ", AnxietyScore,
                               "\nStress Score: ", StressScore,
                               "\nAlcohol Use: ", AlcoholUse,
                               "\nAverage Sleep: ", AverageSleep))) +
      geom_point() %>%
    ggplotly()})
    output$value <- renderPrint({ input$sleep })
  #  output$value <- renderPrint({ input$checkGroup })
  }
)