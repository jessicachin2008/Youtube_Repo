library(shiny)
shinyServer(
  function(input, output) {
    output$trend <- renderPlot({ sleep_data %>%
        select(input$select1, input$select2) %>% 
        ggplot(aes(x = sleep_data[[input$select1]] , y = sleep_data[[input$select2]], group = 1)) +
        stat_smooth(method = "loess") +
        labs(x = input$select1,
             y = input$select2)
    })
    output$scatterplot <- renderPlot({ combined_sleep_data %>%
        filter(AverageSleep < input$sleep + 1 & AverageSleep > input$sleep - 1) %>%
      ggplot(aes(x = GPA)) +
      geom_bar()})
    output$img1 <- renderImage({   #This is where the image is set 
      if(input$sleep >= 3 && input$sleep < 5){            
        list(src = "dead.png", height = 331, width = 300)
      }                                        
      else if(input$sleep >= 5 && input$sleep < 7){
        list(src = "Tired.png", height = 331, width = 300)
      }
      else if(input$sleep >= 7 && input$sleep <= 9){
        list(src = "Healthy.png", height = 331, width = 300)
      }
      else if(input$sleep > 9 && input$sleep <= 11){
        list(src = "Oversleep.png", height = 331, width = 300)
      }
    }, deleteFile = FALSE)
  }
)
