
context("Model distances")

test_that("get_distance works", {

  tri_eng <- clean_trigrams_table("This is apparently in English")
  eng <- get_distance(tri_eng, data[["Latin"]][["eng"]])
  hun <- get_distance(tri_eng, data[["Latin"]][["hun"]])
  deu <- get_distance(tri_eng, data[["Latin"]][["deu"]])

  expect_true(eng < hun)
  expect_true(eng < deu)

  expect_equal(eng, 5453)
  expect_equal(hun, 7791)
  expect_equal(deu, 7293)
})


test_that("filter_langages works", {

  expect_equal(data$Latin, filter_languages(data$Latin))
  expect_equal(data$Latin[c("eng", "deu")],
               filter_languages(data$Latin, whitelist = c("eng", "deu")))
  expect_equal(data$Latin[setdiff(names(data$Latin), c("eng", "deu"))],
               filter_languages(data$Latin, blacklist = c("eng", "deu")))
})
