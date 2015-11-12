
context("Language detection")

test_that("top language is detected correctly", {

  expect_equal(franc("Alle menslike wesens word vry"), "afr")
  expect_equal(franc(""), "und")
  expect_equal(franc("the"), "und")
  expect_equal(franc("the", min_length = 3), "sco")
})

test_that("language scores are calculated correctly", {

  scores <- franc_all('O Brasil caiu 26 posi\u00c7\u00f5es')

  expect_equal(
    scores[1:12,],
    data.frame(
      stringsAsFactors = FALSE,
      language = c("por", "src", "glg", "snn", "bos", "hrv", "lav", "cat",
        "spa", "bam", "sco", "rmy"),
      score = c(1, 0.880093676814988, 0.870257611241218, 0.863700234192037,
        0.816861826697892, 0.810304449648712, 0.809836065573771,
        0.80655737704918, 0.799531615925059, 0.799531615925059,
        0.779859484777518, 0.753629976580796)
    )
  )

})
