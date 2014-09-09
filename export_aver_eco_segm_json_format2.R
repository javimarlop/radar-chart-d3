export_aver_eco_segm_json2<-function(){

library(RJSONIO)
#library(reshape)
#source('toJSONarray.R')
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

pas<-unique(hri2eco$wdpa_id)

for (j in 1:length(pas)){
index2<-hri2eco$wdpa_id==pas[j]
hri2pa<-hri2eco[index2,1:10]


sink(paste('pa_segm_aver_',pas[j],sep=''))
for (i in 1:dim(hri2pa)[1]){
s1<-list(list(means=as.numeric(hri2pa[j,2:10])))
names(s1)<-hri2pa$wdpaid[1]
data<-toJSON(s1)
cat(data[i])
cat("]}")
}
cat("];",fill=TRUE)
sink()
}
}
}
