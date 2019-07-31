setwd("C:/Users/Niccolo.C.Dejito/Documents/My files/Experimental/Network of thrones")

episode = data.frame()
for (e in 1:12) {
  #e = 1
  episode <- rbind(episode, read.csv(paste0(e, ".csv"), header = F, stringsAsFactors = F))
  episode <- rbind(episode, data.frame(V1 = "", V2 = "", V3 = 1))
}

change_scene <- c(1)
change_scene <- append(change_scene, grep(pattern = 1, episode$V3))
change_scene <- append(change_scene, nrow(episode))

unique_names <- as.character(
  unique(
    gsub("﻿", "", episode$V1))
)
unique_names <- unique_names[unique_names!=""]

pairs <- data.frame(t(combn(unique_names, 2)))
pairs$pair <- paste(pairs$X1, pairs$X2)
pairs$count <- 0

for (s in 497:(length(change_scene) - 1)) {
  #s <- 1
  scene <- as.character(episode$V1[change_scene[s]:change_scene[s+1]])
  scene <- scene[scene!=""]
  if (length(scene) > 0) {
    for(l in 1:(length(scene) - 1)) {
      # l <- 1
      exists <- sum(grepl(paste(scene[l], scene[l+1]), pairs$pair))
      if (exists == 1) {
        pairs$count[pairs$pair == paste(scene[l], scene[l+1])] = pairs$count[pairs$pair == paste(scene[l], scene[l+1])] + 1
      }
      else {
        pairs$count[pairs$pair == paste(scene[l+1], scene[l])] = pairs$count[pairs$pair == paste(scene[l+1], scene[l])] + 1
      }
    }
  }
}

pairs <- pairs[pairs$count != 0, ]
names(pairs)[1] = "Source"
names(pairs)[2] = "Target"
names(pairs)[4] = "Weight"
write.csv(pairs, "pairs counted.csv")
