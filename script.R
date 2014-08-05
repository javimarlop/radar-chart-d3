library(RJSONIO)
library(reshape)

hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
hri2<-hri[,c(2,seq(13,29,2))]
hri3<-melt(hri2[1:3,],'wdpaid')

names(hri3)<-c('className','axis','value')

by(hri3[-1],hri3$className,function(x )toJSONarray(x))->data

names(data[1])
cat(data[1])
