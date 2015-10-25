
context("Language detection")

test_that("top language is detected correctly", {

  expect_equal(franc("Alle menslike wesens word vry"), "afr")
  expect_equal(franc("এটি একটি ভাষা একক IBM স্ক্রিপ্ট"), "ben")
  expect_equal(franc("Alle mennesker er født frie og"), "nno")
  expect_equal(franc(""), "und")
  expect_equal(franc("the"), "und")
  expect_equal(franc("the", min_length = 3), "sco")
})

test_that("language scores are calculated correctly", {

  scores <- franc_all('O Brasil caiu 26 posições em')

  expect_equal(
    scores[1:12,],
    data.frame(
      stringsAsFactors = FALSE,
      language = c("por", "glg", "src", "lav", "cat", "spa", "bos", "tpi",
        "hrv", "snn", "bam", "sco"),
      score = c(1, 0.7362599377808503, 0.7286553750432078,
        0.6944348427238161, 0.6802627030763913, 0.6633252678880055,
        0.6536467334946423, 0.6477704804701002, 0.6456965088143796,
        0.6374006221914967, 0.5900449360525406, 0.5893536121673004)
    )
  )

})
