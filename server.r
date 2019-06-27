library(shiny)

shinyServer(function(input, output) {
   
  output$name <- renderText({ 
    
#    if(input$hist == FALSE){
#            print("USER DEFINED VALUES")
#    }
#      else
    print(input$name) 
#    }
    })
  output$ti   <- renderText({ print(input$start) })
  output$tf   <- renderText({ print(input$end)   })
  
  output$distPlot <- renderPlot({
    
    if (input$seeds == TRUE) {
    set.seed(input$setseed)
          }
        
    
  if(input$hist == TRUE){
           
     acronym = input$name    #"GOOGL"  company's keyword 
       start = input$start   #"2010-01-01"
         end = input$end     #"2012-12-31"
               
      variable     = "Adjusted"
      column_name  = paste(acronym,variable,sep=".")
      print(column_name)
    
      # returns an xts object
      portfolio <- getSymbols(Symbols = acronym,from= start,to = end,auto.assign=FALSE) # xts object
      Y         <- coredata(portfolio[, column_name] ) # sumulated variable (adjusted  closed price)
      size_y    <- length(Y)
      t0      <- 1                        #  t0    = first day 
      t1      <- size_y                   #  t1    = last day 
      dt_01   <- c(t0:t1)                 #  dt_01 = [t0,t1]
      Y01     <- Y[dt_01]                 #  y01   = y(1),y(2),...y(t1)
      Y01.ret <- returns(Y01)             # historical returns = (Y(t1)-Y(t0))/Y(t0)
      (n = length(Y01.ret))
      
      # if(n<input$time){
      #   output$err   <- renderText({ print("ERROR: HISTORICAL DATA LESS THAN FORECAST DAYS. ABORT.") })
      #   stopApp(7)
      #   }
  
      #some info
      #str(portfolio)
      #head(portfolio) 
      

      # STANDARD DEVIATION/VARIANCE (VOLATILITY) 
      
      s01  <-   sd(Y01.ret, na.rm = T)           # sd   (volatility)
      m01  <- mean(Y01.ret, na.rm = T)           # mean value (drift)
      S0   <- Y01[t1]
#      v01  <- s01*s01                           # variance
      
      }else{   
          t0    <- 1
          t1    <- t0
          m01   <- input$drift/100
          s01   <- input$stdev/100
          S0    <- input$initPrice
          acronym = "User defined Brownian motion"
  }     
    
    
    total_forecast  <- input$time             #forecast time
    total_past      <- input$past
    nsim   <- input$simul
     gbm   <- matrix(ncol = nsim, nrow = total_forecast)
#     gbm_2 <- matrix(ncol = nsim, nrow = total_forecast)
     dt = 1 / total_forecast              #time-step
     
          for (simu in 1:nsim) {
            
                  gbm[1, simu]   <- S0
#                  gbm_2[1, simu] <- S0
                  ds = 0    
                  for (day in 2:total_forecast) {
                    
                          epsilon <- rnorm(total_forecast)     #N(n,0,1)
                          R = (m01 - s01*s01/2.) * dt + s01 * epsilon[day] * sqrt(dt)
                          gbm[day, simu] <- exp(R)
                                
#                           x = gbm_2[day-1,simu]
#                          dx = m01*x* dt + s01*x*rnorm(1,mean=m01,sd=sqrt(dt))                
#                          gbm_2[day,simu] = x + dx    
                  }
          }
          gbm <- apply(gbm, 2, cumprod)    #cumulative product for GBM
          
          t2p <- t1 - total_past
          t2f <- t1 + total_forecast
          t   <- 1:total_forecast
          xt  <- c(t1 + t)   
          if(input$hist == TRUE){         
          
            ts.plot( Y[ t0:t2f],       # stock values
                  type = 'l',                            # line plot
                  xlim = c(t2p, t2f),
#                  ylim = c(200, 400),
                  xlab = "Time (days)",
                  main = paste(acronym),
                  ylab = "Share Value",
                  panel.first = grid())
            
            for(simu in 1:nsim){
              lines(x = xt, y = gbm[1:total_forecast,simu], lty = 'dotted', col = sample(rainbow(10)),    lwd = 2)
            }
          
          }
          else{
          ts.plot(gbm, gpars = list(col=rainbow(10)))
#          lines(x = xt, y = gbm_2, lty = 'dotted', col = sample(rainbow(10)),    lwd = 2)
        }
          
  })
  
  
})
