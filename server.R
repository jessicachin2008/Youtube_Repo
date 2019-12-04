library(shiny)
library(tibble)
happinessScore <- 10
count <- c(1)
shinyServer(
  function(input, output, session) {
    
    output$trend <- renderPlot({
      sleep_data %>% # plot for first tab
        select(input$select1, input$select2) %>%
        ggplot(aes(x = sleep_data[[input$select1]],
                   y = sleep_data[[input$select2]], group = 1)) +
        stat_smooth(method = "loess") +
        labs(x = input$select1,
             y = input$select2)})
    
    output$barChart <- renderPlot({
      combined_sleep_data %>% # plot for second tab
        filter(AverageSleep < input$sleep + 1 &
                 AverageSleep > input$sleep - 1) %>%
      ggplot(aes(x = GPA)) +
      geom_histogram(binwidth = 0.5)})
   
     # start for third tab
    score <- reactiveValues(value = 10)
    
    d <- c(0)
    m <- c(10)
    
    values <- reactiveValues(df = data.frame(D=d, Score=m))
    
    observeEvent(input$simulate, {
      sleepHours <- as.numeric(input$hoursOfSleep)
      depressionLevel <- as.numeric(input$depressionLevel)
      anxietyLevel <- as.numeric(input$anxietyLevel)
      stressLevel <- as.numeric(input$stressLevel)
      numberOfDrinks <- as.numeric(input$numberOfDrinks)
      if (sleepHours >= 3 && sleepHours <= 5) {
        sleepHours <- -7
      } else if (sleepHours >= 10 && sleepHours <= 13) {
        sleepHours <- -3
      } else {
        sleepHours <- 1
      }
      happinessScore <- happinessScore + 0.37 * (depressionLevel) +
        0.5 * (anxietyLevel) + 0.25 * (stressLevel) -
        0.1 * (numberOfDrinks) + 0.59 * (sleepHours)
      if (happinessScore > 10) {
        happinessScore <- 10
      } else if (happinessScore < 1) {
        happinessScore <- 1
      }
      score$value <- round(happinessScore)
      d_new <- c(values$df$D,as.numeric(input$simulate))
      m_d_new <- c(values$df$Score,round(happinessScore))
      values$df <- data.frame(D=d_new,Score=m_d_new)
    })
    
    observeEvent(input$reset, {
      updateSliderInput(session, "hoursOfSleep", value = 7)
      updateSliderInput(session, "numberOfDrinks", value = 0)
      updateSelectInput(session, "depressionLevel", selected = 1)
      updateSelectInput(session, "anxietyLevel", selected = 1)
      updateSelectInput(session, "stressLevel", selected = 1)
      score$value <- 10
      d <- c(0)
      m <- c(10)
      values$df <- data.frame(D=d,Score=m)
    })
    
    output$HappinessScore <- renderText({
      paste("Happiness Score: ", score$value)
    })
    
    output$happinessPlot <- renderPlot({
      values$df %>%
        ggplot(aes(x=values$df$Score)) +
        geom_histogram(aes(fill = ..count..), binwidth = 1,
                       color = "black") +
        scale_x_continuous(name = "Happiness Score",
                           breaks = seq(0, 10, 1)
                           ) +
        scale_y_continuous(name = "Count", 
                           ) +
        ggtitle("Frequency histogram of Happiness Score") +
        theme_bw()
    }) 
   
    output$img1 <- renderImage({ #This is where the image is set
      if (input$sleep >= 3 && input$sleep < 5) {
        list(src = "pictures/Dead.png", height = 331, width = 300)
      }
      else if (input$sleep >= 5 && input$sleep < 7) {
        list(src = "pictures/Tired.png", height = 331, width = 300)
      }
      else if (input$sleep >= 7 && input$sleep <= 9) {
        list(src = "pictures/Healthy.png", height = 331, width = 300)
      }
      else if (input$sleep > 9 && input$sleep <= 11) {
        list(src = "pictures/Oversleep.png", height = 331, width = 300)
      }
    }, deleteFile = FALSE)
    output$DASSscores <- renderTable({
      DASSScore
    })
  }
)