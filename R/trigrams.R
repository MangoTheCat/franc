
## This is mostly after
## https://github.com/wooorm/trigram-utils/blob/master/index.js

trigrams <- function(text) ngrams(text, 3)

expression_symbols <- "[-!\"#$%&'()*+,\\./0123456789:;<=>?@]"

trim <- function(x) sub("\\s$", "", sub("^\\s*", "", x))

clean <- function(value) {
  value <- as.character(value)
  value <- gsub(pattern = expression_symbols, replacement = " ", value)
  value <- gsub(pattern = "\\s+", replacement = " ", value)
  value <- trim(value)
  tolower(value)
}

clean_trigrams <- function(value) {
  if (length(value) == 0) return(list())
  trigrams(paste0(' ', clean(value), ' '))
}

clean_trigrams_table <- function(value) {
  stopifnot(is.character(value), length(value) == 1)
  table(clean_trigrams(value))
}
