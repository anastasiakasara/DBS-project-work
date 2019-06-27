#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Sep 23 13:23:02 2018

@author: natasa
"""
import os
print(os.getcwd())
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
from datetime import datetime
from scipy import stats
#tickers = ['AAPL', 'MSFT', '^GSPC']
#
from iexfinance.stocks import Stock
from iexfinance.stocks import get_historical_data



start = datetime(2017, 1, 1)
end = datetime(2018, 1, 1)

df = get_historical_data("AAPL", start=start, end=end, output_format='pandas')
df.head()
df.shape
x=df['close']  # Share price
#x.drop(x.index[0], inplace=True)
# x=df.loc[:,['close']] keeps the index
#x.drop(x.index[:1], inplace=True)
x.shape
x.head(20)
x.tail()
plt.plot(x)
plt.show()

x[28]
(len(x))
t1=len(x)
dx=x.diff()
dx.head()
dx.drop(x.index[0], inplace=True)
(len(dx))

dx.head()
Y=np.zeros(len(dx))
(len(Y))
for i in range(1,len(x)):   
#    dx[i-1] = x[i]-x[i-1]
     Y[i-1]=dx[i-1]/x[i-1]
#    print(i)


Y[0]
(x[0])   
(dx[0]) 
  
n=len(Y)
print(n)
Y[n-1] 
########################################################

s01= np.std(Y)
m01= np.mean(Y)
v01=s01*s01

print('s01 =', s01)
print('m01 =' , m01)
print('v01 =',v01)

#########################################
#confidence interval for the mean 95% 
from scipy.stats import sem, t
from scipy import mean
from scipy import sqrt
from scipy.stats import chi2
import math
confidence = 0.95

std_err = sem(Y) #  sd = s01/sqrt(n)
h = std_err * t.ppf((1 + confidence) / 2, n - 1)

start = m01 - h
end =m01 + h
print('start' ,start, 'm01', m01 ,'end', end)


###############################################

#  standard deviation
crit_u=stats.chi2.ppf((1-confidence)/2,n-1)
crit_l=stats.chi2.ppf((1+confidence)/2,n-1)
s_l=sqrt((n-1)*s01**2/crit_l)
s_u=sqrt((n-1)*s01**2/crit_u)
((s_l,s01,s_u))  #confidence interval


##########################################
 ##### plot the future share price 
##t1=251
x[t1-1]  # x[251]=2017-12-29    166.0148

logx0 = np.log(x[t1-1])
t=np.arange(0,20)
print(t)
                # relative future from the end datetime (2018, 12, 31)
y_t= logx0 + m01 * t       # mean value for ln(S(t))=G(t)
st=np.exp(y_t)                     # mean of stock price 
st_l=np.exp(y_t-1.96*s01*sqrt(t))
st_u=np.exp(y_t+1.96*s01*sqrt(t))
st[0]
st_l[0]
st_u[0]

tt =t+t1
t_1=np.arange(0,t1)    
plt.plot(t_1,x)
plt.plot(tt,st_l,tt,st,tt,st_u)
#plt.plot(t,st,'b')
#plt.plot(t,st_u,'g')
plt.show()


#
print(t1)
print(st)




 
