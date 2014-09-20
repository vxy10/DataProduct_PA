library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Testing normality of distribution of mean of an exponential distribution"),
  sidebarPanel(
    sliderInput("lam", "Decimal:", 
                min = 0.1, max = 1, value = 0.5, step= 0.1),
    
    sliderInput("num_mean", 
                "Number of points to calculate mean", 
                min = 10,
                max = 100, 
                value = 50),
    
    sliderInput("num_samples", 
                "Number of estimates of mean", 
                min = 100,
                max = 4000, 
                value = 500)
    
    
  ),

  # Show a plot of the generated distribution
  mainPanel(
    p(paste("An exponential(lambda)s distributions is one whose mean is 1/lambda and the standard deviation is also also 1/lambda." ,
      "This app lets you set lambda and do simulations. You can investigate the distribution of averages of a fixed number of exponential(lambda)s.")),
    p("Means are calculated for the estimates, and their standard errors are reported. Normality is assessed using Shapiro tests."),
    plotOutput("histPlot"),
    
    textOutput("aa")
    
  )
))