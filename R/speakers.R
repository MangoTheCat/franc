
#' @importFrom jsonlite fromJSON

speakers_file <- system.file("speakers.json", package = packageName())

speakers <- jsonlite::fromJSON(speakers_file, simplifyVector = FALSE)

for (i in seq_along(speakers)) {
  if (is.null(speakers[[i]][[2]])) speakers[[i]][[2]] <- NA_character_
  if (is.null(speakers[[i]][[3]])) speakers[[i]][[3]] <- NA_character_
}

speakers <- data.frame(
  stringsAsFactors = FALSE,
  row.names = NULL,
  language = names(speakers),
  speakers = vapply(speakers, "[[", 1, "speakers"),
  name     = vapply(speakers, "[[", "", "name"),
  iso6391  = vapply(speakers, "[[", "", "iso6391"),
  iso6392  = vapply(speakers, "[[", "", "iso6392")
)

speakers <- speakers[ order(speakers$speakers, decreasing = TRUE), ]

row.names(speakers) <- seq_len(nrow(speakers))
