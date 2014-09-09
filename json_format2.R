#Categories: {“Tree_cover","EPR", #"Precipitation","Biotemperature","Slope","NDWI","NDVI_MAX","NDVI_MIN","GRASSLAND_cover"},
#
#123:{means: [1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2]},
#
#64782:{means: [1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2]}


s1<-list(list(means=as.numeric(hri2eco2[1,2:10])))
names(s1)<-hri2eco2$wdpaid[1]
toJSON(s1)
