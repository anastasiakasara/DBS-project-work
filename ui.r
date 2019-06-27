#install.packages("quantmod")
#install.packages("timeSeries")
library(timeSeries)
library(quantmod)
library(shiny)

shinyUI(
  fluidPage(
    
    titlePanel("GBM Monte Carlo Simulation: Kasara Anastasia DBS Higher Diploma in Science Data Analytics"),
    
    sidebarLayout(
      
      sidebarPanel(
        
        numericInput("initPrice", "Initial Stock Price",           min = 1, value = 100 ), #1
        numericInput("drift"    , "Drift Rate (%):",               min = 0, value = 0  ),  #2
        numericInput("stdev"    , "Annual Standard Deviation (%)", min = 0, value = 1  ),  #3
        numericInput("confint"  , "Confidence Interval (%)",       min = 1, value = 95  ), #4
        numericInput("simul"    , "Number of Simulations",         min = 1, value = 1   ), #5
        numericInput("time"     , "Forecast days:",             min = 1, value = 365 ), #6
        checkboxInput("seeds"   , "Set seed?"),
        numericInput("setseed"  , "Select number of seed",         min = 1, value = 1   ), #7
        checkboxInput("hist"    , "Use historical data?"),
        textInput("name"        , "Company's stock market identifier"),                    #8
        textInput("start"       , "Start day of historical data:"),                     #9
        textInput("end"         , "End   day of historical data:"),                     #10
        numericInput("past"     , "past days plotted",             min =0, value= 200),    #11
        submitButton("Submit")
      ),
      
      mainPanel(
        textOutput("err"),
        textOutput("name"),
        textOutput("ti"),
        textOutput("tf"),
        plotOutput("distPlot"),
        headerPanel(withMathJax("$$S(t) = S(t_0) e^{\\left(\\mu - \\frac{\\sigma^2}{2}\\right)(t-t_0) + \\sigma W_t} $$")),
        h4("Inputs:"),
        h4("1. Initial Stock Price is the current price of the stock;"),
        h4("2. Drift rate is the expected rate of return;"),
        h4("3. Annual Standard Deviation is the volatility of the stock price;"),
        h4("4. Confidence Interval for the plot output;"),
        h4("5. Number of Simulation represents how many simulation of stock price you want to display;"),
        h4("6. Forecast days"),
        h4("check box: mark to set the seed to a fixed value"),
        h4("         : unmarked the seed number takes a random value"),
        h4("7. Fix value of seed"),
        h4("check box: mark to use historical data"),
        h4("         : unmarked only user input GBM is possible"),
        h4("8.  Company's stockmarket keyword, example GOOGL, MSFT, AAPL, TYO"),
        h4("9.  start day of historical data: t0"),
        h4("10. end day of historical data: t1"),
        h4("11. plot days of historical data")
      )
    )
  )
)
