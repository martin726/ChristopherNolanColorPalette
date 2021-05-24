# R-script for obtaining color palettes from images inspired by Christopher Nolan

library(devtools)
library(dplyr)
library(tidyverse)
library(paletter)
library(jpeg)
library(png)
library(rvest) # Parsing of HTML/XML files
library(stringr) # String manipulation
library(rebus)  # Verbose regular expressions
library(lubridate) # Eases DateTime manipulation
library(stringi)
library(urltools)



#### Download images for Christopher Nolan ####

urls.CN <- c("https://scontent-lax3-2.xx.fbcdn.net/v/t1.6435-9/134774431_1276954752687511_6855187955520159762_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=a26aad&_nc_ohc=GhX6tKaBG28AX8YWfkJ&_nc_ht=scontent-lax3-2.xx&oh=1086633c5bc6c5b34abb5e3413d1d243&oe=60D15A21",
             "https://www.mrmovie-review.com/wp-content/uploads/2020/05/tenet-movie-trailer-2-header-image.jpg")

destinations <- c("tenet1.png", "tenet2.png")
  
#
for(i in seq_along(urls.CN)){
  download.file(urls.CN[i], destfile =  destinations[i])
} # Worked!!

### Download more images for Christopher Nolan movies ####


### Web scrape for the Prestige ###

main.cpp <- read_html("https://indiefilming.com/films/the-prestige")

main.cpp.info <-html_elements(main.cpp, xpath='//table[(((count(preceding-sibling::*) + 1) = 18) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "entry__article", " " ))]//a//img')

# Remove parts of the strings #

main.cpp.info=str_remove(main.cpp.info, "<img src=\"")

main.cpp.info=str_remove(main.cpp.info, "border=\"0\">")

main.cpp.info=str_remove(main.cpp.info, "\"")

main.cpp.info=str_remove(main.cpp.info, " ")

new.cpp.info <- url_encode(unlist(main.cpp.info))

urls.PRESTIGE = new.cpp.info 

### Create file names for the prestige images ####

filenames.P <- paste0("prestige", seq(1:13), ".png" )

for(i in seq_along(urls.PRESTIGE)){
  download.file(urls.PRESTIGE[i], destfile =  filenames.P[i])
} # Worked!!

####---- New images from Dunkirk ----####

dunkirk.url <- read_html("https://indiefilming.com/films/dunkirk")

dunkirk.nodes <- html_elements(dunkirk.url, xpath='//table[(((count(preceding-sibling::*) + 1) = 18) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "entry__article", " " ))]//a//img')

# Remove parts of the strings #

dunkirk.nodes=str_remove(dunkirk.nodes, "<img src=\"")

dunkirk.nodes=str_remove(dunkirk.nodes, "border=\"0\">")

dunkirk.nodes=str_remove(dunkirk.nodes, "\"")

dunkirk.nodes=str_remove(dunkirk.nodes, " ")

dunkirkIMG.info <- url_encode(unlist(dunkirk.nodes))

urls.DUNKIRK = dunkirkIMG.info 

### Create file names for the new Dunkirk images ####

filenames.P2 <- paste0("dunkirk", seq(4,6), ".png" )

for(i in seq_along(urls.DUNKIRK)){
  download.file(urls.DUNKIRK[i], destfile =  filenames.P2[i])
} # Dunkirk image

######################################################
#### Let's get color palette codes for each image ####

##-- Dunkirk --##
dunkirk_images <- c("dunkirk1.png", "dunkirk2.png", "dunkirk3.png", "dunkirk4.png", 
                    "dunkirk5.png", "dunkirk6.png")

dunkirk_colpat <- lapply(dunkirk_images, function(x) create_palette(x, number_of_colors=10, type_of_variable = "categorical"))

##-- The Dark Knight --##
darkknight1 <- c("darkknight1.png")

dark_knight_colpat <- lapply(darkknight1, function(x) create_palette(x, number_of_colors=10, type_of_variable = "categorical"))

###-- Tenet --###

tenet_images <- c("tenet1.png", "tenet2.png")

tenet_colpat <- lapply(tenet_images, function(x) create_palette(x, number_of_colors=10, type_of_variable = "categorical"))


