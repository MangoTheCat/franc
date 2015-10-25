
get_distance <- function(trigrams, model) {

  diff <- abs(trigrams - model[names(trigrams)])
  diff[is.na(diff)] <- MAX_DIFFERENCE
  sum(diff)
}

get_distances <- function(trigrams, languages, whitelist = NULL,
                          blacklist = NULL) {

  languages <- filter_languages(languages, whitelist, blacklist)
  sort(vapply(languages, get_distance, 1, trigrams = trigrams))
}
