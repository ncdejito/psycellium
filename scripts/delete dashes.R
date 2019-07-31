setwd("C:/Users/Niccolo/Documents/Work life/Deliberate practice/Network of thrones/txt files")
z <- readLines("Sense8 - 1x12 - I Can't Leave Her.WebRip.SNEAkY.en.txt")

v = c()
for(i in 1:length(z)) {
  #i = 2
  v[i] = gsub("^- ", "", z[i])
}

setwd("C:/Users/Niccolo/Documents/Work life/Deliberate practice/Network of thrones")
write.csv(v, "12.csv")
