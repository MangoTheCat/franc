
speakers_file <- system.file("speakers.json", package = packageName())

#' Number of speakers for 370 languages
#'
#' This is a superset of all languages detected by franc. Numbers were
#' collected by Titus Wormer. To quote him: \emph{Painstakingly crawled by
#' hand from OHCHR, the numbers are (in some cases, very) rough estimates
#' or out-of-date.}.
#'
#' @format
#' A data frame with columns:
#' \describe{
#'   \item{language}{Three letter language code.}
#'   \item{speakers}{Number of speakers.}
#'   \item{name}{Full name of language.}
#'   \item{iso6391}{ISO 639-1 codes. See more at
#'     \url{http://en.wikipedia.org/wiki/ISO_639}.}
#'   \item{iso6392}{ISO 639-2T codes. See more at
#'     \url{http://en.wikipedia.org/wiki/ISO_639}.}
#' }
#'
#' @docType data
#' @importFrom jsonlite fromJSON
#' @export

speakers <- jsonlite::fromJSON(speakers_file, simplifyVector = FALSE)

for (i in seq_along(speakers)) {
  if (is.null(speakers[[i]][[2]])) speakers[[i]][[2]] <- NA_character_
  if (is.null(speakers[[i]][[3]])) speakers[[i]][[3]] <- NA_character_
}

speakers <- data.frame(
  stringsAsFactors = FALSE,
  row.names = NULL,
  language = names(speakers),
  speakers = as.integer(vapply(speakers, "[[", 1, "speakers")),
  name     = vapply(speakers, "[[", "", "name"),
  iso6391  = vapply(speakers, "[[", "", "iso6391"),
  iso6392  = vapply(speakers, "[[", "", "iso6392")
)

speakers <- speakers[ order(speakers$speakers, decreasing = TRUE), ]

row.names(speakers) <- seq_len(nrow(speakers))
