
## This is mostly after
## https://github.com/wooorm/franc/blob/master/lib/franc.js
##
## Note that this happens at build time

datafile <- system.file("data.json", package = packageName())

#' @importFrom jsonlite fromJSON

data <- jsonlite::fromJSON(datafile, simplifyVector = FALSE)

for (script in names(data)) {
  for (language in names(data[[script]])) {
    model <- strsplit(data[[script]][[language]], '|', fixed = TRUE)[[1]]
    model <- structure(seq_along(model) - 1L, names = model)
    data[[script]][[language]] <- model
  }
}

MAX_DIFFERENCE <- 300

filter_languages <- function(languages, whitelist = NULL,
                             blacklist = NULL) {

  l3 <- names(languages)

  if (!is.null(whitelist)) l3 <- intersect(l3, whitelist)
  if (!is.null(blacklist)) l3 <- setdiff(l3, blacklist)

  languages[l3]
}

lang <- function(x, score = 1) {
  data.frame(
    stringsAsFactors = FALSE,
    language = unname(x),
    score = unname(score)
  )
}

und <- function() lang("und")

#' List of probably languages for a text
#'
#' Returns the scores for all languages that use the same script
#' as the input text, in decreasing order of probability. The score
#' is calculated from the distances of the trigram distributions
#' in the input text and in the language model. The closer the languages,
#' the higher the score. Scores are scaled, so that the closest language
#' will have a score of 1.
#'
#' @param text A string constant. Should be at least \code{min_length}
#'    characters long, this is 10 chracters by default.
#'    Only the first \code{max_length} characters are used (2048 by
#'    default), to make the detection reasonably fast.
#' @param min_speakers Languages with at least this many speakers are
#'   checked. By default this is one million. Set it to zero to
#'   include all languages known by franc. See also \code{\link{speakers}}.
#' @param whitelist List of three letter language codes to check against.
#' @param blacklist List of three letter language codes not to check
#'   againts.
#' @param min_length Minimum number of characters required in the text.
#' @param max_length Maximum number of characters used from the text.
#'   By default only the first 2048 characters are used.
#' @return A data frame with columns \code{language} and \code{score}.
#'   The \code{language} column contains the three letter ISO-639-3
#'   language codes. The \code{score} column contains the scores.
#'
#' @encoding utf8
#' @seealso \code{\link{franc}} if you only want the top result,
#'   \code{\link{speakers}}.
#' @export
#' @examples
#' head(franc_all("O Brasil caiu 26 posições em"))
#'
#' ## Provide a whitelist:
#' franc_all("O Brasil caiu 26 posições em",
#'   whitelist = c("por", "src", "glg", "spa"))
#'
#' ## Provide a blacklist:
#' head(franc_all("O Brasil caiu 26 posições em",
#'   blacklist = c("src", "glg", "lav")))

franc_all <- function(text, min_speakers = 1000000, whitelist = NULL,
                      blacklist = NULL, min_length = 10,
                      max_length = 2048) {

  text <- as.character(text)
  stopifnot(length(text) == 1, !is.na(text))

  if (nchar(text) < min_length) return(und())
  text <- substr(text, 1, max_length)

  script <- get_top_script(text)

  ## Returns NULL is script is unknown
  if (is.null(script)) return(und())

  ## Return the language if script is a single language
  if (! script %in% names(data)) return(lang(script))

  ## Candidate languages
  if (min_speakers != 0) {
    enough_speakers <- speakers$language[speakers$speakers >= min_speakers]
    if (is.null(whitelist)) {
      whitelist <- enough_speakers
    } else {
      whitelist <- intersect(whitelist, enough_speakers)
    }
  }

  languages <- filter_languages(
    data[[script]],
    whitelist = whitelist,
    blacklist = blacklist
  )

  trigrams <- clean_trigrams_table(text)
  dist <- get_distances(trigrams, languages)

  lang(names(dist), normalize(text, dist))
}

#' Detect the language of a string
#'
#' @param text A string constant. Should be at least \code{min_length}
#'    characters long, this is 10 characters by default.
#'    Only the first \code{max_length} characters are used (2048 by
#'    default), to make the detection reasonably fast.
#' @param min_speakers Languages with at least this many speakers are
#'   checked. By default this is one million. Set it to zero to
#'   include all languages known by franc. See also \code{\link{speakers}}.
#' @param whitelist List of three letter language codes to check against.
#' @param blacklist List of three letter language codes not to check
#'   againts.
#' @param min_length Minimum number of characters required in the text.
#' @param max_length Maximum number of characters used from the text.
#'   By default only the first 2048 characters are used.
#' @return A three letter ISO-639-3 language code, the detected
#'   language of the text. \code{"und"} is returned for too short input.
#'
#' @encoding utf8
#' @seealso \code{\link{franc_all}} for scores against many languages,
#'   \code{\link{speakers}}.
#' @export
#' @examples
#' ## afr
#' franc("Alle menslike wesens word vry")
#'
#' ## nno
#' franc("Alle mennesker er født frie og")
#'
#' ## Too short, und
#' franc("the")
#'
#' ## You can change what’s too short (default: 10), sco
#' franc("the", min_length = 3)

franc <- function(text, min_speakers = 1000000, whitelist = NULL,
                  blacklist = NULL, min_length = 10, max_length = 2048) {

  franc_all(text, min_speakers = min_speakers, whitelist = whitelist,
            blacklist = blacklist, min_length = min_length,
            max_length = max_length)$language[[1]]
}
