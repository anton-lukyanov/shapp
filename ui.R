library(shiny)
shinyUI(pageWithSidebar(
  
  headerPanel("MotorTrend. Quarter mile time"),
   sidebarPanel( 
     h6("Using 32 car attributes from MotorTrend magazine we build linear model
       that can estimate car quarter mile time from 3 parameters: engine horsepowers,
        car weight and transmission type"),
     h5("Change parameters below to see the result of the model:"),
     sliderInput('HP','Select horse powers',value=60,min=50,max=500,step=10,),
     sliderInput('Weight','Select weight (lb/1000)',value=1.2,min=0.8,max=5,step=0.2,),
     sliderInput('Transmission','Select transmission, 0-automatic, 1-manual',value=0,min=0,max=1,step=1,)
     ),
  mainPanel(
    h4('Quarter mile time based on linear regression model:'),
    verbatimTextOutput("prediction")
    )
  ))