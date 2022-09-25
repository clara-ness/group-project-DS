library(sf)
library(tidyverse)
library(geojsonsf)

Neighborhoods<- geojsonsf::geojson_sf('MapApp/geojson_manipulation/map_test.geojson')

myData <- read.csv('MapApp/geojson_manipulation/final.csv',sep=";",header=TRUE, check.names=TRUE,stringsAsFactors = FALSE)

#all_data <- data.frame(Neighborhoods, myData)
all_data = merge(Neighborhoods, myData, by.x = "commune", by.y = "Name.of.commune")

view(all_data)

st_write(all_data, "MapApp/geojson_manipulation/main.geojson")