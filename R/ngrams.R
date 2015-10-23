
ngrams <- function(text, n) {

  stopifnot(
    is.numeric(n),
    length(n) == 1,
    !is.na(n),
    n >= 1,
    is.finite(n)
  )
  
  if (is.null(text) || length(text) == 0) return(character())
  
  text <- as.character(text)

  lapply(text, function(x) {
    if (nchar(x) < n) return(character())
    num <- nchar(x) - n + 1
    substring(x, 1:num, 1:num + n - 1)
  })
}
