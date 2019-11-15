library(shiny)
shinyServer(
  function(input, output) {
    output$value <- renderPrint({ input$sleep })
  }
)