calculateHappiness <- function(happinessScore, maxScore, minScore, input$simulate, input$reset, 
                               input$hoursOfSleep, input$depressionLevel, input$anxietyLevel,
                               input$stressLevel, input$numberOfDrinks)
  ObjReact <- reactive({
    hoursOfSleep <- as.numeric(input$hoursOfSleep)
    depressionLevel <- as.numeric(input$depressionLevel)
    anxietyLevel <- as.numeric(input$anxietyLevel)
    stressLevel <- as.numeric(input$stressLevel)
    numberOfDrinks <- as.numeric(input$numberOfDrinks)
    happinessScore <- happinessScore + 0.37 * (depressionLevel) + 0.5 * (anxietyLevel) + 
                      0.25 * (stressLevel) - 0.1 * (numberOfDrinks)
    return(happinessScore)
  )}