library(RJSONIO)
library(reshape)

hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
hri2<-hri[,c(2,seq(13,29,2))]
hri3<-melt(hri2[1:3,],'wdpaid')

names(hri3)<-c('className','axis','value')

by(hri3[-1],hri3$className,function(x )toJSONarray(x))->data

export_max_json<-function(){
for (i in 1:length(data)){
sink(paste('data_max_',names(data[i]),sep=''))
cat("var data = [",fill=TRUE)
cat("{",fill=TRUE)
cat(paste("className: '",names(data[i]),"',",sep=''),fill=TRUE)
cat("axes: [,",fill=TRUE)
cat(data[i])
sink()
}
}


