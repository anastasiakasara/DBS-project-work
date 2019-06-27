#
# REQUIRES ACCOUNT IN SHINY https://www.shinyapps.io
#
install.packages('rsconnect')
rsconnect::setAccountInfo(name='nkasara',
                          token='00186E3B501690A2D046FB115DB485C8',
                          secret='sJ1Zxnfcb2Iwt4as5/cgj18/bNzH66DHk0RZRq09')
library(rsconnect)
rsconnect::deployApp('/home/natasa/project-natasa/project/project-dbs-final/gbm-shiny')
