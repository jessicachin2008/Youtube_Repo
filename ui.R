library(shiny)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(rlang)
library(shinythemes)
url <- a("Survey Link", href = "https://www.psytoolkit.org/cgi-bin/psy2.4.1/survey?s=A4fYA")
github_url <- a("Link", href = "https://github.com/jessicachin2008/team_won")
sleep_data <- read.csv("data/sleep_study.csv") %>%
  select(GPA, DepressionScore, AnxietyScore,
         StressScore, AlcoholUse, AverageSleep, Drinks)
combined_sleep_data <- read.csv("data/combined_sleep_gpa.csv")
DASSScore <- read.csv("data/dassscore.csv")
shinyUI(fluidPage(theme = shinytheme("darkly"),
  titlePanel(title = "Why Should We Sleep?"), #title
  navbarPage("Sections",
    tabPanel("Trend Lines", # first tab
             sidebarLayout(
               sidebarPanel(
                 selectInput("select1", label = h4("Parameter 1 (X)"),
                             choices = list("Depression Score" =
                                              "DepressionScore",
                                            "Anxiety Score" = "AnxietyScore",
                                            "Stress Score" = "StressScore",
                                            "Number of Drinks" = "Drinks",
                                            "Average Sleep" = "AverageSleep",
                                            "GPA" = "GPA"),
                             selected = "GPA"),
                 selectInput("select2", label = h4("Parameter 2 (Y)"),
                             choices = list("Depression Score" =
                                              "DepressionScore",
                                            "Anxiety Score" = "AnxietyScore",
                                            "Stress Score" = "StressScore",
                                            "Number of Drinks" = "Drinks",
                                            "Average Sleep" = "AverageSleep",
                                            "GPA" = "GPA"),
                             selected = "AverageSleep"),
                 HTML("The purpose of this information visualization is to allow the user to see the relationship between different
                        variables and see how it could influence their life. The variables that can be shown on the graph are Depression
                        Score, Anxiety Score, Stress Score, number of drinks, and average sleep.")
               ),
                 mainPanel(
                   HTML("<h1>Trend Lines with Different Parameters</h1>"),
                   plotOutput("trend")
                   ))),
    tabPanel("Slider", # second tab
             sidebarPanel(
             sliderInput(
               inputId = "sleep",
               label = "Average hours of sleep per night",
               min = 3,
               max = 11,
               value = 7
             ),
             imageOutput("img1")),
             mainPanel(
               HTML("<h1>Average GPA's for a User Determined Amount of Sleep </h1>
                  This slider allows you to adjust number of hours
                  of sleep. A graph will be created to depict the number of
                  people who received a certain grademark correlated to the
                  hours of sleep they get. <em>**Keep in mind that these data points
                  are based on collected data from one school and does not
                  represent a direct relationship between GPA and hours of sleep.</em><br>"),
               plotOutput("barChart")
             )),
    tabPanel("Sleep Simulation", # third tab
             sidebarPanel(
               sliderInput(
                 inputId = "hoursOfSleep",
                 label = "Please specify hours of sleep",
                 min = 3,
                 max = 11,
                 value = 7
               ),
               selectInput("depressionLevel",
                           label = h3("Please choose depression level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               selectInput("anxietyLevel",
                           label = h3("Please choose anxiety level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               selectInput("stressLevel",
                           label = h3("Please choose stress level"),
                           choices = list("Normal" = 1, "Moderate" = -2,
                                          "Severe" = -5),
                           selected = 1),
               sliderInput(
                 inputId = "numberOfDrinks",
                 label = "Please specify amount of drinks taken",
                 min = 0,
                 max = 24,
                 value = 0
               ),
               splitLayout(cellWidths = c("30%", "20%"),
               actionButton("simulate", label = "Simulate"),
               actionButton("reset", label = "Reset"))
             ),
             mainPanel(
               HTML("<h1>Sleep Simulation</h1>
                  In this section of our application, we are simulating
                  how the variables; hours of sleep, depression level, anxiety level,
                  stress level, and the numbers of drinks might affect your
                  overall happiness level. Everytime you press the simulate button, 
                  it simulates one day's happiness score. To convey this information,
                  we decided to use a histogram so that the user could see the spread
                  of the happiness scores and how often they would get a certain score.
                  The way we determined the
                  happiness score was by finding the line of regression
                  for each variable and compared to the happiness score
                  that was provided in the data. Using this, we formulated
                  an equation that can determine the happiness level of the
                  person (on a scale from 1-10, 10 being the happiest). Also, since
                  it isn't realistic to reset your happiness every morning, we created
                  this simulation where until you reset the simulation, it continues to
                  report your happiness score that is based on the selection and the
                  previous score that you have simulated.
                  Keep in mind that this scale is purely based on past data, so these
                  numbers are not completely accurate. FYI, the initial starting
                  point is set to 10 just to keep things standardized. <br> <br>"),
               textOutput("HappinessScore"),
               br(),
               plotOutput("happinessPlot")
             )),
    tabPanel("Do It Yourself",
             mainPanel(
             HTML("<h1>Do It Yourself</h1>
                These scores are all based on data collected through Viterbo University. The
                data was obtained from a sample of students who did skills tests to measure
                cognitive function, completed a survey asking about attitudes and habits,
                and kept a sleep diary to record time and quality of sleep over a two-week
                period in 2016. <br> <br>"),
             HTML("<em> <b>You should not self-diagnose based on these scores - these visualizations are
                purely based on data collected through one specific school. </em> </b> <br> <br>"),
             HTML("You can calculate your own DASS Score (Depression, Anxiety, Stress Scores)
                  on the link below. After taking the survey, you may compare your scores to
                  the table to the right and find whether your Scores are Normal, Mild,
                  Moderate, Severe, or Extremely Severe - plug them into our visualizations
                  and see what your happinessScore might be. <br> <br>"),
             tagList("URL Link:", url)),
             HTML("Crisis Text Line: Text HOME to 741741<br>",
                  "Suicide Prevention Life Line: 1-800-273-8255<br>"),
             tableOutput("DASSscores"),
             ),
    tabPanel("Conclusion",
             mainPanel(
               HTML("<h1>Conclusion</h1>
               We found that the correlation between sleep and GPA are not exactly linear, however it is clear that from our analysis
                    that the ideal sleeping range to increase your happiness score and GPA is around 6-9 hours of sleep. <br><br>
                    We also see that there are definitely more variable that affect our GPA than just number of hours of sleep, like mental
                    illnesses (depression, anxiety, etc.). It is important to get a good amount of sleep to lessen your depression, anxiety, and
                    stress (DASS) scores as well as finding your best study habits to reach that goal. <br><br>
                    From University of Washington students, best of luck!")
             )),
    tabPanel("About", # the about tab
             mainPanel(
               HTML("<h1>About</h1>
                  We decided to focus on sleep as our topic because, as college students, we wanted to know
                  how sleep affects college students. Stress, anxiety, and depression
                  can play a huge role on how many hours a person sleeps per day, and the opposite can also be true.
                  We wanted to observe how mental illness can affect someone's happiness and depicted 
                  happiness score as one of our visualizations. The other two information
                  visualizations we created were sliders and trend lines, both based on the data we collected through Kaggle.com.
                  We hope that our project can help other college students who suffer from sleep deprivation
                  to get an idea on what factors can effect a person's sleep cycle. We do not
                  have any specific solutions but we did include information for users to
                  analyze and think about - what changes might you implement into your lives?
                  This project was done by Samuel Kim, Jessica Chin, and Abdirihman Mohamud. <br> <br>"),
                  tagList("GitHub Repository Link:", github_url)
             )))
  )
)
