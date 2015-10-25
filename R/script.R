
match_length <- function(pattern, text) {
  mat <- gregexpr(pattern, text)[[1]]
  if (mat[1] == -1) 0 else sum(attr(mat, "match.length"))
}

#' @include expressions.R

get_top_script <- function(text) {
  num_letters <- vapply(expressions, match_length, 1, text = text)
  if (any(num_letters > 0)) {
    names(which.max(num_letters))
  } else {
    NULL
  }
}
