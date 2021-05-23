# R-script for obtaining color palettes from images inspired by my favorite directors and movies
# Use RImagePackage

library(devtools)
library(dplyr)
library(tidyverse)
library(paletter)
library(jpeg)
library(png)

#### Download images for Christopher Nolan ####

urls.CN <- c("https://pbs.twimg.com/media/CTMerjXUAAA6UaF?format=jpg&name=900x900", 
             "https://pbs.twimg.com/media/ETrm3X_UEAA1cLt?format=jpg&name=medium",
             "https://pbs.twimg.com/media/D75EtPSV4AAKINm?format=jpg&name=medium",
             "https://i.pinimg.com/originals/77/be/c0/77bec0de563f5cc7a32dcf0ce1508394.jpg",
             "https://pbs.twimg.com/media/ET0oJ6lWAAQeXdZ?format=jpg&name=medium",
             "https://scontent-lax3-2.xx.fbcdn.net/v/t1.6435-9/134774431_1276954752687511_6855187955520159762_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=a26aad&_nc_ohc=GhX6tKaBG28AX8YWfkJ&_nc_ht=scontent-lax3-2.xx&oh=1086633c5bc6c5b34abb5e3413d1d243&oe=60D15A21",
             "https://www.mrmovie-review.com/wp-content/uploads/2020/05/tenet-movie-trailer-2-header-image.jpg")

destinations <- c("darkknight1.png", "dunkirk1.png", "dunkirk2.png", "inception1.png", "dunkirk3.png",
                  "tenet1.png", "tenet2.png")
  
#
for(i in seq_along(urls.CN)){
  download.file(urls.CN[i], destfile =  destinations[i])
} # Worked!!

####--- Color palette for Interstellar (2018) ---####




