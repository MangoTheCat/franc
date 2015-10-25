
normalize <- function(text, distances) {
  min <- min(distances)
  max <- nchar(text) * MAX_DIFFERENCE - min
  1 - ((distances - min) / max)
}
