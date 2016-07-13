# TODO: header, change this all to dplyr code
library(ggplot2)
library(ggthemes)
library(maps)
world = map_data("legacy_world")

print(paste(
    "Generating worldmap for", capwords(current_measure), "measure", sep = " ")
)

# Bermuda, Faeroes, Germany DDR, Gibraltar, Guam, Hong Kong, Kampuchea,
# Marianas, Netherlands Antilles, Niue, Singapore, South Yemen, Saint Helena,
# Vatican City are missing in world_map and their vectors are unused.
# These countries either seized to exist at some point or are simply not mapped
# (too small). For those countries that seized to exist but have a modern
# equivalent, we used that instead. An example would be North and South Yemen
# where we used the cluster data for North Yemen as the data for today's Yemen
# since North Yemen's closer resembles the flag of Yemen.
newnames = c(
        "Antigua", "Argentina",
        "Bermuda", "Virgin Islands", "Burkina Faso",
        "Myanmar", "Cape Verde", "Comoros", "Faeroes",
        "Falkland Islands", "Germany DDR", "Germany",
        "Gibraltar", "Guam", "Hong Kong", "Kampuchea",
        "Madagascar", "Maldives", "Marianas", "Netherlands Antilles", "Niue",
        "Yemen", "Paraguay", "Sao Tome and Principe", "Singapore",
        "Solomon Islands", "South Yemen", "Saint Helena",
        "Saint Kitts", "Saint Lucia", "Saint Vincent", "Suriname",
        "Trinidad", "Turks and Caicos", "United Arab Emirates",
        "Virgin Islands", "Vatican City", "Samoa"
)

# convert names from factor to character since we are done with analysis
# TODO: this could be solved better, but using levels() screws everthing up.
cluster_table$name = as.character(cluster_table$name)
changed_names = cluster_table$name[!is.element(
    cluster_table$name,
    sort(unique(world$region))
)]
# We can actually fix a lot of the country mapping mistakes by replacing
# hyphens with a space as in "American-Samoa" -> "American Samoa"
changed_names = gsub("-", " ", changed_names)

# The remaining ones will be replaced manually with above defined values
changed_names[!is.element(
    changed_names,
    sort(unique(world$region))
)] = newnames

cluster_table$name[!is.element(
    cluster_table$name,
    sort(unique(world$region))
)] = changed_names

# Now we have to match clusters data with countries that are different in the
# flag data set than in the world map file. Sicily is there considered part of
# italy in the cluster data, same goes for Sardinia. Namibia did belong to
# South Africa when the data set was created. Western Sahara is considered part
# of Morocco.

cluster_table = rbind(cluster_table,
    replace(cluster_table[154,], 1, "Namibia"),
    replace(cluster_table[118,], 1, "Western Sahara"),
    replace(cluster_table[88,], 1, "Sicily"),
    replace(cluster_table[88,], 1, "Sardinia")
)
# FIXME: wrong rownames for new duplicate rows

# Cluster auf Länder der Weltkarte mappen und plotten
mergedata = merge(world, cluster_table, by.x = "region", by.y = "name")
mergedata = mergedata[order(mergedata$order),]

path = paste("figures/", current_measure, "_worldmap.pdf", sep="")
pdf(path, width=44, paper="a4r")
print(ggplot(mergedata, aes(long,lat,group=group)) +
  geom_polygon(aes(fill = factor(cluster)), size = 0.2) +
    scale_fill_brewer(palette = "Paired",name="Cluster") +
#   scale_x_discrete(name="Longitutde", breaks=c(-100,0,100)) +
  geom_polygon(data=world, colour="black", fill=NA) +
  theme_tufte(base_size=25))
dev.off()

print("Done.")