#' Complete list of palettes
#'
#' Use \code{\link{ChrisNolan_palette}} to construct palettes of desired length.
#'
#' @export
chrisnolan_palette <- list(
### Still need to add color palette
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
#'   \code{Tenet1}, \code{Tenet2}, \code{Interstellar},  \code{DarkKnight},
#'   \code{Inception}, \code{Dunkirk},  \code{Prestige1},  \code{Prestige2}, 
#'   \code{Prestige3}
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
#' pal <- chrisnolan_palette(21, name = "Tenet1", type = "continuous")
#' image(volcano, col = pal)
chrisnolan_palettes <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  pal <- chrisnolan_palettes[[name]]
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
