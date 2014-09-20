library(shiny)

shinyServer(function(input, output) {
  output$histPlot <- renderPlot({
    set.seed(4444)
    num_simln <- input$num_samples
    n <- input$num_mean
    lambda<- input$lam
    
    g<-matrix(rexp(num_simln*n, lambda),nrow = 40, ncol = num_simln)
    mn_exp <- (apply(g, 2, mean))
    sd_exp<- sd(mn_exp)/sqrt(length(mn_exp))
    low_ci <- mean(mn_exp)-1.96*sd_exp
    high_ci <- mean(mn_exp)+1.96*sd_exp
    mean_est <- 1/lambda
    a<-hist(mn_exp,40,
            xlab = "mean of 1/lambda" ,
            ylab = "Frequency",
            main = "Histogram of distribution of mean of 1/lambda")
    
    lines(c(mean(mn_exp),mean(mn_exp)),
          c(0, max(a$counts)),col = "red")
    sh_mn <- shapiro.test(mn_exp)
    norm_test<- shapiro.test(mn_exp)
    p_value <-norm_test$p.value
    
    
    output$aa<-renderText({ 
      
      if (p_value>0.05){      
      paste("You have chosen lambda = ", input$lam, " for this lambda, theoretical mean is ", round(1/input$lam,4),
            ". Estimating mean",input$num_samples, "from ",input$num_mean , " values gave a confidence interval of [",
            round(low_ci,5) , ",", round(high_ci,5) ,
            "]. Normality shapiro test resulted in a p-value = ", round(p_value,4) ,
            " (>0.05) indicating a non-normal distribution.")
      } else {
        paste("You have chosen lambda = ", input$lam, " for this lambda, theoretical mean is ", round(1/input$lam,4),
              ". Estimating mean",input$num_samples, "from ",input$num_mean , " values gave a confidence interval of [",
              round(low_ci,5) , ",", round(high_ci,5) ,
              "]. Normality shapiro test resulted in a p-value = ", round(p_value,4) ,
              " (< 0.05) indicating a normal distribution.")
        
      }
      
      
      
    })
    
  })
})