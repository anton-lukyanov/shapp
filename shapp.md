Quarter mile time estimation from Motor Trend Car Road Tests
========================================================
author: Anton Lukyanov
date: 25 Jan 2015

App description
========================================================

Application site: [SHAPP](http://anton-lukyanov.shinyapps.io/shapp/)

Based on Motor Trend dataset this application will help the user to estimate the quarter mile time by selecting three attributes
- Horse power
- Weight in lb/1000
- Transmission type

The linear regression model used for estimation

Prediction model
========================================================

`mtcars` dataset saved from R as *.csv and put into shanyapp site.


```r
cf<-read.csv(file="./data/mtcars.csv",sep=";")
```
Running regression:

```r
fitAll <- lm(qsec ~ hp+wt+am, data = cf)
```

,where `cf` is `mtcars` dataset, `qsec` - outcome and  `hp`, `wt`, `am` are parameters.

server.R - Server part
========================================================


```r
cf<-read.csv(file="./data/mtcars.csv",sep=";")
lf<-function(a1,a2,a3,a4,x1,x2,x3) a1+a2*x1+a3*x2+a4*x3
shinyServer(
  function(input,output) {
    fitAll <- lm(qsec ~ hp+wt+am, data = cf)
    output$prediction<-
      renderPrint({lf(summary(fitAll)$coef[1],
                      summary(fitAll)$coef[2],
                      summary(fitAll)$coef[3],
                      summary(fitAll)$coef[4],
                      input$HP,
                      input$Weight,
                      input$Transmission)})
    
  }
)
```

ui.R - User interface part
========================================================
<small style="font-size:.7em">

```r
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
```
