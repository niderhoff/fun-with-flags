library(ggplot2)
library(ggthemes)
library(maps)
world = map_data("legacy_world")

# TODO: überprüfen warum das ersetzen der Länder auf einmal nicht
#       mehr notwendig sein soll..
# Namen in Cluster-Dataframe ersetzen bei Ländern deren Namen im
# Worldmap-Dataframe anders sind
# newnames <- c(
#     "American Samoa", "Antigua", "Argentine", "Bermuda",
#     "Virgin Islands", "Burkina Faso", "Myanmar", "Cape Verde",
#     "Cayman Islands", "Central African Republic", "Comoros",
#     "Cook Islands", "Costa Rica", "Dominican Republic", "El Salvador",
#     "Equatorial Guinea", "Faeroes", "Falkland Islands",
#     "French Guiana", "French Polynesia", "Germany DDR", "Germany",
#     "Gibraltar", "Guam", "Hong Kong", "Ivory Coast", "Kampuchea",
#     "Madagascar", "Maldives", "Marianas", "Netherlands Antilles",
#     "New Zealand", "Niue", "North Korea", "Yemen",
#     "Papua New Guinea", "Paraguay", "Puerto Rico", "San Marino",
#     "Sao Tome and Principe", "Saudi Arabia", "Sierra Leone", "Singapore",
#     "Solomon Islands", "South Africa", "South Korea", "South Yemen",
#     "Sri Lanka", "Saint Helena", "Saint Kitts", "Saint Lucia",
#     "Saint Vincent", "Suriname", "Taiwan", "Trinidad", "Turks and Caicos",
#     "United Arab Emirates", "Virgin Islands", "Vatican-City", "Samoa")
#
# jaccard_clust$name = as.character(jaccard_clust$name)
# jaccard_clust$name[
#     which(!is.element(as.character(jaccard_clust$name),
#                       sort(unique(world$region))))
#     ] = newnames
# # Ende Ersetzen

# TODO: den code hier schöner machen
clustered_fin = jaccard_clust
# Cluster-Dataframe Zeile kopieren für Länder, die damals noch nicht vorhanden
# waren, aber schon auf der Weltkarte existieren.

Namibia = clustered_fin[154,]
Namibia$name = "Namibia"

WestSahara = clustered_fin[118,]
WestSahara$name = "Western Sahara"

Sicily = clustered_fin[88,]
Sicily$name = "Sicily"

Sardinia = clustered_fin[88,]
Sardinia$name = "Sardinia"
# Ende Zeilen kopieren

clustered_fin = rbind(clustered_fin,Namibia,WestSahara,
                       Sicily,Sardinia)

mergedata = merge(world, clustered_fin, by.x = "region", by.y = "name")
choropleth = mergedata[order(mergedata$order),]
# TODO: print to pdf :-)
print(ggplot(choropleth, aes(long,lat,group=group)) +
  geom_polygon(aes(fill = factor(cluster)), size = 0.2) +
    scale_fill_brewer(palette = "Paired",name="Cluster") +
#    scale_x_discrete(name="Longitutde", breaks=c(-100,0,100)) +
  geom_polygon(data=world, colour="black", fill=NA) +
  theme_tufte(base_size=25))