#' Complete list of palettes
#'
#' Use \code{\link{nolan_palletes}} to construct palettes of desired length.
#'
#' @export
colorpaletttes <- list(
  DarkKnight1 = c("#2F3133", "#1E2529", "#171D20", "#C49921", "#44BDE6",
                  "#2573A8", "#003367","#00224E","#001A38"),
  DarkKnight2 = c("#6E27B5","#4C0099", "#FF0000", "#FFE5CC",
                  "#CCD1D4", "#000200", "#318E2E", "#0AEE03"),
  Inception1 = c("#A22303", "#A86656", "#DCB8A8", "#7D4026", "#4D3F35", "#9C7650",
                 "#92806B", "#769F68", "#495644", "#5D9C92", "#3C4749", "#83969E"),
  Inception2 = c("#8F826F" , "#7B715F", "#635E48", "#4F4F42","#4C4F3B","#307998"),
  Inception3 = c("#814523","#BFA182","#9F8465","#D5B48F","#CBB193","#7F613C"),
  Inception4 = c("#4A473B","#B7BEB1","#A6AEA2","#555D69","#383B41","#33373E"),
  Tenet1     = c("#012949","#1E105A","#4A0768","#330438","#6F0269", "#FF33FF","#72144C","#390416","#500101"),
  Tenet2     = c("#723E13","#83542B","#705B3A","#6C6450","#485E58","#47625C","#4E6E68","#2E625E"),
  Interstellar1 = c("#39342B","#6C8988","#323E3E","#A1B4B8","#0F4151","#194B5D","#283439","#1F3D49","#2E5363","#454F57"),
  Interstellar2 = c("#C47C6E","#A55238","#9B5C45","#6E5243","#BA977B","#755B42","#58442B","#36494A","#1E454C","#3C4D53"),
  Interstellar3 = c("#003300", "#0E6B6B", "#EACAB3", "#7D9B9B", "#F9E0C6","#D8C8B4",
                    "#375359", "#6E0101", "#925E62"),
  Dunkirk1 = c("#765D56","#614136","#614D43","#87614E","#41332C","#5B4539","#443B30","#5D4E37"),
  Dunkirk2 = c("#813C2C","#95482D","#AD5839","#B06141","#988473","#B89575","#3C7679","#315458"),
  Dunkirk3 = c("#B78252","#9D8D6D","#C6B998","#5C593F","#E4D234","#8A8A0F","#8B916C","#476C4E"),
  Dunkirk4 = c("#93806C","#D0D3AF","#C2CCAC","#768F80","#90AF9E","#799A8D","#576E66","#5D8D7C"),
  Dunkirk5 = c("#C5A893","#C69B70","#DDB389","#AC855A","#E2B983","#A78F6C","#EBDDB4","#90886D"),
  Dunkirk6 = c("#672D1E","#A9552F","#834D30","#B26438","#5F3E29","#68432C","#D27B3B","#F0C868"),
  Prestige1 = c("#660000","#4E453C","#66625B","#A0B6C1","#91A2AC",
                "#A0ADB7","#A7B9C8","#BCCDDD","#9CA5B2","#142C6F"),
  Prestige2 = c("#583129","#947168","#694034", "#652A0C","#876A56","#BD8E8E",
                "#AC8558","#804141","#A9A083","#C3B878"),
  Prestige3 = c("#7D0000, #723F2C","#866554",
                  "#685449","#955E33","#5A7C38",
                  "#9B9B6F","#544637","#BB8252","#33200A"),
  Prestige4 = c("#553A2D","#D0BAAF",
                "#9F5318","#986642","#815433","#654226","#FFCC98",
                "#BB8252","#977654","#756350","#83745E")
)

#' A Christopher Nolan palette generator
#'
#' These are a handful of color palettes from Christopher Nolan movies. Currently, I only have a hanful of movies, but hope to include his entire filmography
#'
#' @param n Number of colors desired. Color schemes come from the website
#'   \href{https://indiefilming.com/people/christopher-nolan/}{Indie Film} and others are from from the instagram page
#' \href{https://www.instagram.com/colorpalette.cinema/}{colorpalette.cinema}.
#'   If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   \code{DarkKnight}, \code{Inception1}, \code{Inception2},  \code{Inception3},
#'   \code{Inception4}, \code{Tenet1},  \code{Tenet2},  \code{Interstellar1},
#'   \code{Interstellar2}, \code{Interstellar3}, \code{Dunkirk1}, \code{Dunkirk2},
#'   \code{Dunkirk3}, \code{Dunkirk4}, \code{Dunkirk5}, \code{Dunkirk6}, \code{Prestige1},
#'   \code{Prestige2}, \code{Prestige3}, \code{Prestige4}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' chrisnolan_palette("Tenet1")
#' chrisnolan_palette("Tenet2")
#' chrisnolan_palette("Interstellar1")
#' chrisnolan_palette("Interstellar2")
#' chrisnolan_palette("DarkKnight")
#'
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- nolan_palette(21, name = "Tenet1", type = "continuous")
#' image(volcano, col = pal)
nolan_palettes <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- colorpaletttes[[name]]
  if (is.null(pal))
    stop("Palette not found.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
    continuous = grDevices::colorRampPalette(pal)(n),
    discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = x,
    ylab = "", xaxt = "n", yaxt = "n", bty = "n")

  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}

#' heatmap
#'
#' A heatmap example
"heatmap"

