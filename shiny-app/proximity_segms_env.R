# Based on variables average for each segment
library(randomForest)
hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
hri[c(1:2,30:38)]->means
randomForest(means[,3:11])->rfmeans
MDSplot(rfmeans,factor(means$wdpaid)) # add site wdpaid and use it as colour
plot(rfmeans$proximity)
as.data.frame(rfmeans$proximity)->prox_env
as.data.frame(apply(prox_env,2,mean))->prox_means
plot(prox_means[,1])

# we can then use mantel test with distance matrices based on averages of env vars or with proximities to assess overall fit (from vegan R library)
mantel(prox_env,prox_bio)
