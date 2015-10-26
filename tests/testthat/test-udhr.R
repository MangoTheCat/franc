
context("UDHR")

test_that("All supported languages are recognized", {

  support <- jsonlite::fromJSON("support.json", )$iso6393
  fixtures <- jsonlite::fromJSON("fixtures.json")

  for (i in seq_along(fixtures)) {
    if (nchar(fixtures[[i]]) != 0) {
      lang <- franc(fixtures[[i]], min_speakers = 0)
      expect_equal(lang, support[i], info = i)
    }
  }
})
