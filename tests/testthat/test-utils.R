
context("Utility functions")

test_that("match_length works", {

  expect_equal(match_length("[a-z]", "abcz"), 4)
  expect_equal(match_length("[a-z]", "x"), 1)
  expect_equal(match_length("[a-z]", ""), 0)
  expect_equal(match_length("[a-z]", "123"), 0)

  expect_equal(match_length(expressions$ben, "এটি একটি ভাষা একক IBM স্ক্রিপ্ট"), 23)
})
