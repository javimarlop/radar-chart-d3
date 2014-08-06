
hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
# merge with segmentation output shapefile table
# dbfdump


export_max_json<-function(){
library(RJSONIO)
library(reshape)

pas<-unique(hri$wdpa_id)

for (j in 1:length(pas)){
index<-hri$wdpa_id==pas[j]

hri2<-hri[j,c(2,seq(13,29,2))]
hri3<-melt(hri2,'wdpaid')
names(hri3)<-c('className','axis','value')
hri3l<-hri3
hri3l$value<-log(hri3$value+1))

by(hri3l[-1],hri3l$className,function(x )toJSONarray(x))->data

sink(paste('data_max_',names(data[i]),sep=''))
cat("var data = [",fill=TRUE)
for (i in 1:length(data)){
cat("{",fill=TRUE)
cat(paste("className: '",names(data[i]),"',",sep=''),fill=TRUE)
cat("axes: [,",fill=TRUE)
cat(data[i])
sink()
}
}

}


