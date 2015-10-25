
context("Scripts")

test_that("script detection works", {

  expect_equal(get_top_script(""), NULL)
  expect_equal(get_top_script("this is in English"), "Latin")
  expect_equal(get_top_script("এটি একটি ভাষা একক IBM স্ক্রিপ্ট"), "ben")
})
