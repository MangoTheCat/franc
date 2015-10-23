
## This is mostly after
## https://github.com/wooorm/franc/blob/master/lib/franc.js
##
## Note that this happens at build time

datafile <- system.file("data.json", package = packageName())

data <- fromJSON(datafile, simplifyVector = FALSE)

for (script in names(data)) {
  for (language in names(data[[script]])) {
    model <- strsplit(data[[script]][[language]], '|', fixed = TRUE)[[1]]
    model <- structure(seq_along(model) - 1L, names = model)
    data[[script]][[language]] <- model
  }
}

MAX_LENGTH <- 2048

MIN_LENGTH <- 10

MAX_DIFFERENCE <- 300

filter_languages <- function(languages, whitelist = NULL,
                             blacklist = NULL) {

  if (!is.null(whitelist)) languages <- intersect(languages, whitelist)
  if (!is.null(blacklist)) languages <- setdiff(languages, blacklist)

  languages
}

get_distance <- function(trigrams, model) {
  
}
