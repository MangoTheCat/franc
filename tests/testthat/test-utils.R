
context("Utility functions")

test_that("match_length works", {

  expect_equal(match_length("[a-z]", "abcz"), 4)
  expect_equal(match_length("[a-z]", "x"), 1)
  expect_equal(match_length("[a-z]", ""), 0)
  expect_equal(match_length("[a-z]", "123"), 0)

  ben <- paste0(
    "\u098F\u099F\u09BF \u098F\u0995\u099F\u09BF ",
    "\u09AD\u09BE\u09B7\u09BE \u098F\u0995\u0995 IBM ",
    "\u09B8\u09CD\u0995\u09CD\u09B0\u09BF\u09AA\u09CD\u099F"
  )
  expect_equal(match_length(expressions$ben, ben), 23)
})
