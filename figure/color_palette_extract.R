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

### Image of Christopher Nolan ####

urls.CN2 <- c("https://www.denofgeek.com/wp-content/uploads/2015/02/nolan_1_0.jpg?resize=620%2C432")

filenames.m <- c("mainIMG.png")
  
download.file(urls.CN2, destfile = filenames.m)

urls.leoD <- c("https://images.squarespace-cdn.com/content/v1/52d6d1ede4b0b322e9c7a2ea/1594911690090-32LML5W6R6U3E8I0KRNR/ke17ZwdGBToddI8pDm48kFTEgwhRQcX9r3XtU0e50sUUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKcjVvFZn3_1TpSINbj1p15LLAjcj6UHNkQOuDz3gO52lBvccB2t33iJEaqs_Hdgp_g/image-asset.png?format=2500w")

filenames.l <- c("LeoDiCap.png")

download.file(urls.leoD, filenames.l)

#### Download images for Christopher Nolan ####

urls.CN <- c("https://scontent-lax3-2.xx.fbcdn.net/v/t1.6435-9/134774431_1276954752687511_6855187955520159762_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=a26aad&_nc_ohc=GhX6tKaBG28AX8YWfkJ&_nc_ht=scontent-lax3-2.xx&oh=1086633c5bc6c5b34abb5e3413d1d243&oe=60D15A21",
             "https://www.mrmovie-review.com/wp-content/uploads/2020/05/tenet-movie-trailer-2-header-image.jpg")

destinations <- c("tenet1.png", "tenet2.png")


for(i in seq_along(urls.CN)){
  download.file(urls.CN[i], destfile =  destinations[i])
} # Worked!!

#####--- Download more images for Christopher Nolan movies ---######

### InterStellar images ####
urls.IS <- c("https://i.pinimg.com/originals/e5/01/43/e50143ca5020eadbc67addf1b481c608.jpg", 
             "https://i.pinimg.com/originals/01/2e/31/012e316e75213f8c1e2ce0aeb052a293.jpg",
             "https://i.pinimg.com/originals/0e/6f/80/0e6f80594666aae10c048803deefa448.jpg")

file.names.IS <- paste0("interstellar", seq(1:3), ".png")

for(i in seq_along(urls.IS)){
  download.file(urls.IS[i], destfile =  file.names.IS[i])
} 

###- Web scrape for the Prestige ####
main.cpp <- read_html("https://indiefilming.com/films/the-prestige")

# Use xpath to obtain multiple urls for images 
main.cpp.info <-html_elements(main.cpp, xpath='//table[(((count(preceding-sibling::*) + 1) = 18) and parent::*)] | //*[contains(concat( " ", @class, " " ), concat( " ", "entry__article", " " ))]//a//img')

# Remove parts of the strings #
main.cpp.info=str_remove(main.cpp.info, "<img src=\"")

main.cpp.info=str_remove(main.cpp.info, "border=\"0\">")

main.cpp.info=str_remove(main.cpp.info, "\"")

main.cpp.info=str_remove(main.cpp.info, " ")

new.cpp.info <- url_encode(unlist(main.cpp.info))

urls.P = new.cpp.info 

### Create file names for the prestige images ####
filenames.P <- paste0("prestige", seq(1:13), ".png" )

for(i in seq_along(urls.P)){
  download.file(urls.P[i], destfile =  filenames.P[i])
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

dunkirk_colpat <- lapply(dunkirk_images, function(x) create_palette(x, number_of_colors=8, type_of_variable = "categorical"))

####-- The Dark Knight ----####
darkknight1 <- c("darkknight1.png")

dark_knight_colpat <- lapply(darkknight1, function(x) create_palette(x, number_of_colors=10, type_of_variable = "categorical"))

####-- Tenet ---####
tenet_images <- c("tenet1.png", "tenet2.png")

tenet_colpat <- lapply(tenet_images, function(x) create_palette(x, number_of_colors=8, type_of_variable = "categorical"))

####-- Interstellar --#####
interstellar_images <- c("interstellar1.png", "interstellar2.png", "interstellar3.png")

interstellar_colpat <- lapply(interstellar_images, function(x) create_palette(x, number_of_colors=8, type_of_variable = "categorical"))

####--- Prestige 1 ---####
prestige_images <- c("prestige1.png", "prestige2.png", "prestige3.png", "prestige4.png")

prestige_colpat <- lapply(prestige_images, function(x) create_palette(x, number_of_colors=6, type_of_variable="categorical"))

###--- Prestige 2 ---####
prestige2_images <- c("prestige5.png", "prestige6.png", "prestige7.png", "prestige8.png" )

prestige2_colpat <- lapply(prestige_images, function(x) create_palette(x, number_of_colors=6, type_of_variable="categorical"))

###--- Inception ---####

# Need to download more images from Inception

urls.INC <- c("https://media.hearstapps.com/hmg-prod/images/hbz-best-movies-of-the-decade-inception-everett-1577143815.jpg?crop=3000,1500,offset-x50,offset-y0,safe&width=480&auto=webp&optimize=medium",
             "https://specials-images.forbesimg.com/imageserve/5f0dba3075efdd00063f9810/960x0.jpg?fit=scale", 
             "https://s23527.pcdn.co/wp-content/uploads/2014/05/inception-334.jpg.optimal.jpg")

files.INC <- c("inception2.png", "inception3.png", "inception4.png")

for(i in seq_along(urls.INC)){
  download.file(urls.INC[i], destfile =  files.INC[i])
}

#--> Obtain color palettes -#
inception_images <- c("inception1.png", "inception2.png", "inception3.png", "inception4.png")

inception_colpat <- lapply(inception_images, function(x) create_palette(x, number_of_colors=6, type_of_variable = "categorical"))

########################################
####--- Categorize the palettes  ---####

TenetGroups <- lapply(tenet_colpat, function(x) paste(x, collapse = ","))

DarkKnightGroups <- lapply(dark_knight_colpat, function(x) c(paste(x, collapse=",")))

DunkirkGroups <- lapply(dunkirk_colpat, function(x) c(paste(x, collapse=",")))

InceptionGroups <- lapply(inception_colpat, function(x) c(paste(x, collapse=",")))

InterstellarGroup <- lapply(interstellar_colpat, function(x) c(paste(x, collapse=",")))

PrestigeGroups <- lapply(prestige_colpat, function(x) c(paste(x, collapse=",")))

### Images for the main page ####

urls.MP <- c("http://24.media.tumblr.com/tumblr_m89owjRKeZ1qlcv71o1_500.gif",
             "https://25.media.tumblr.com/tumblr_m89owjRKeZ1qlcv71o6_500.gif")

file.names.GIFs <- c("inception1.gif", "inception2.gif")

for(i in seq_along(urls.MP)){
  download.file(urls.MP[i], destfile =  file.names.GIFs[i])
}




