library(shiny)
shinyServer(
  function(input, output) {
    
    output$img1 <- renderImage({   #This is where the image is set 
      if(input$sleep >= 1 && input$sleep <= 4){            
        list(src = "noSleep.png", height = 331, width = 200)
      }                                        
      else if(input$sleep >= 5 && input$sleep <= 6){
        list(src = "Tired.png", height = 331, width = 200)
      }
      else if(input$sleep >= 7 && input$sleep <= 9){
        list(src = "Healthy.png", height = 331, width = 200)
      }
      else if(input$sleep >= 10 && input$sleep <= 13){
        list(src = "Oversleep.png", height = 331, width = 200)
      }
      else if(input$sleep >= 14 && input$sleep <= 24){
        list(src = "Dead.png", height = 331, width = 200)
      }
    }, deleteFile = FALSE)
  }
)    
