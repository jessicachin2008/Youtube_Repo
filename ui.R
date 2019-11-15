library(shiny)


# Define UI for slider demo app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Amount of Sleep Per Night"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      # Input: Simple integer interval ----
      sliderInput("Hours", "Hours of Sleep:",
                  min = 0, max = 24,
                  value = 8, step = 1),
      ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Table summarizing the values entered ----
      tableOutput("values")
      
    )
  )
)

# Define server logic for slider examples ----
server <- function(input, output) {
  
  # Reactive expression to create data frame of all input values ----
  sliderValues <- reactive({
    
    data.frame(
      Name = c("Hours"),
      Benefits = "Better GPA",
      stringsAsFactors = FALSE)
    
  })
  
  # Show the values in an HTML table ----
  output$values <- renderTable({
    sliderValues()
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)