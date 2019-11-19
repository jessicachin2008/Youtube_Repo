library(shiny)
shinyServer(
  function(input, output) {
    output$boxplot <- renderPlot({ sleep_data %>%
        select(GPA, AverageSleep) %>%
        mutate(amount_of_sleep = case_when(AverageSleep < 7 ~ "Too Little",
                                           AverageSleep >= 7 &
                                             AverageSleep <= 9 ~ "Healthy Sleep",
                                           AverageSleep > 9 ~ "Too Much")) %>%
      ggplot(aes(x = amount_of_sleep, y = GPA)) +
      geom_boxplot() })
    output$scatterplot <- renderPlot({ combined_sleep_data %>%
        filter(AverageSleep < input$sleep + 1 & AverageSleep > input$sleep - 1) %>%
      ggplot(aes(x = GPA)) +
      geom_bar()})
    output$img1 <- renderImage({   #This is where the image is set 
      if(input$sleep >= 1 && input$sleep < 5){            
        list(src = "noSleep.png", height = 331, width = 200)
      }                                        
      else if(input$sleep >= 5 && input$sleep < 7){
        list(src = "Tired.png", height = 331, width = 200)
      }
      else if(input$sleep >= 7 && input$sleep <= 9){
        list(src = "Healthy.png", height = 331, width = 200)
      }
      else if(input$sleep > 9 && input$sleep <= 13){
        list(src = "Oversleep.png", height = 331, width = 200)
      }
      else if(input$sleep >= 14 && input$sleep <= 24){
        list(src = "Dead.png", height = 331, width = 200)
      }
    }, deleteFile = FALSE)
  }
)
