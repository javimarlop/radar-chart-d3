export_max_json<-function(){

library(RJSONIO)
library(reshape)
source('toJSONarray.R')
###

hri<-read.table('hri_results.csv',sep=' ',header=T,dec='.')
# Export segments shapefile table to csv (QGIS) as db.csv and import it in R
db<-read.table('db.csv',sep=',',header=T)
# merge with segmentation output shapefile table
names(db)<-c('cat','label','wdpa_id','wdpaid')
duplicated(db$wdpaid)->dupl_index
db0<-db[!dupl_index,]

# normalize values by PA/ECO/variable
hri0<-merge(hri,db0,by='wdpaid')

###
pas<-unique(hri0$wdpa_id)

for (j in 1:length(pas)){
index<-hri0$wdpa_id==pas[j]

hri2<-hri0[index,c(1,seq(13,29,2))]
hri3<-melt(hri2,'wdpaid')
names(hri3)<-c('className','axis','value')
hri3l<-hri3
hri3l$value<-log(hri3$value+1)

by(hri3l[-1],hri3l$className,function(x )toJSONarray(x))->data

sink(paste('data_max_',pas[j],sep=''))
cat("var data = [",fill=TRUE)
for (i in 1:length(data)){
if (i == 1){
cat("{",fill=TRUE)
}
if (i > 1){
cat(",{",fill=TRUE)
}
cat(paste("className: '",names(data[i]),"',",sep=''),fill=TRUE)
cat("axes: [",fill=TRUE)
cat(data[i])
cat("]}")
}
cat("];",fill=TRUE)
sink()
}

}
