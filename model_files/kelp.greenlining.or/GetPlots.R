# general post model run exploration using r4ss  (version 1.22.1)
#6/3/2015 5:11:29 PM
#used R version 3.2.4
#AMB
#
# load libraries
library(ggplot2)
library(plyr)
library(reshape2)
library(scales)
install.packages("devtools")
devtools::install_github("r4ss/r4ss")
library(r4ss)
#
wdir <- "C:/Users/Aaron.Berger/Documents/AMB/Hake/2016.2017/Runs/30_SenAddAge1Index"
setwd(wdir)
myreplist <- SS_output(dir=wdir)
myplots <- SS_plots(replist = myreplist)
