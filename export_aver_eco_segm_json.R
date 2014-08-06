export_aver_eco_segm_json<-function(){

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

# normalized values by ECO/variable
hri0<-merge(hri,db0,by='wdpaid')
names(hri0)[30:38]<-c("Tree_cover","EPR", "Precipitation","Biotemperature","Slope","NDWI","NDVI_MAX","NDVI_MIN","GRASSLAND_cover")
ecos<-unique(hri0$ecoregion)

for (k in 1:length(ecos)){

index<-hri0$ecoregion==ecos[k]
hri2<-hri0[index,c(1,30:38,41)]
hri2eco<-hri2

for (h in 2:10){
hri2eco[,h]<-hri2[,h]/max(hri2[,h])
}

###
pas<-unique(hri2eco$wdpa_id)

for (j in 1:length(pas)){
index2<-hri2eco$wdpa_id==pas[j]
hri2pa<-hri2eco[index2,1:10]

hri3<-melt(hri2pa,'wdpaid')
names(hri3)<-c('className','axis','value')
#hri3l<-hri3
#hri3l$value<-log(hri3$value+1)

by(hri3[-1],hri3$className,function(x )toJSONarray(x))->data

sink(paste('eco_aver_',pas[j],sep=''))
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
}
