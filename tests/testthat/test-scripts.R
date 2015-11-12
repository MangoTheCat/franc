
context("Scripts")

test_that("script detection works", {

  expect_equal(get_top_script(""), NULL)
  expect_equal(get_top_script("this is in English"), "Latin")

  ben <- paste0(
    "\u098F\u099F\u09BF \u098F\u0995\u099F\u09BF ",
    "\u09AD\u09BE\u09B7\u09BE \u098F\u0995\u0995 IBM ",
    "\u09B8\u09CD\u0995\u09CD\u09B0\u09BF\u09AA\u09CD\u099F"
  )
  expect_equal(get_top_script(ben), "ben")
})
