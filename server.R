library(shiny)
#data(mtcars)
cf<-read.csv(file="./data/mtcars.csv",sep=";")
lf<-function(a1,a2,a3,a4,x1,x2,x3) a1+a2*x1+a3*x2+a4*x3
shinyServer(
  function(input,output) {
    fitAll <- lm(qsec ~ hp+wt+am, data = cf)
    output$prediction<-renderPrint({lf(summary(fitAll)$coef[1],
                                       summary(fitAll)$coef[2],
                                       summary(fitAll)$coef[3],
                                       summary(fitAll)$coef[4],
                                       input$HP,
                                       input$Weight,
                                       input$Transmission)})
    
  }
)