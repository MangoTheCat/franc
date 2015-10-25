
context("Trigrams")


test_that("trigrams works", {

  expect_equal(trigrams("abcdef")[[1]], c("abc", "bcd", "cde", "def"))
  expect_equal(trigrams("abc")[[1]], "abc")
  expect_equal(trigrams("ab")[[1]], character(0))
  expect_equal(trigrams(c("ab", "abc", "abcd")),
               list(character(0), "abc", c("abc", "bcd")))
  expect_equal(trigrams(character(0)), list())
})


test_that("clean_trigrams works", {

  expect_equal(clean_trigrams("abcdef")[[1]],
               c(" ab", "abc", "bcd", "cde", "def", "ef "))
  expect_equal(clean_trigrams("abc")[[1]], c(" ab", "abc", "bc "))
  expect_equal(clean_trigrams("ab")[[1]], c(" ab", "ab "))
  expect_equal(clean_trigrams("a")[[1]], c(" a "))
  expect_equal(clean_trigrams(c("abcd", "xyzz")),
               list(c(" ab", "abc", "bcd", "cd "),
                    c(" xy", "xyz", "yzz", "zz ")))
  expect_equal(clean_trigrams(character(0)), list())
})


test_that("clean_trigrams removes non-letters", {

  expect_equal(clean_trigrams("a2345!+b<=>?c")[[1]],
               c(" a ", "a b", " b ", "b c", " c "))
  expect_equal(clean_trigrams("a-!\"#$%&'()*+,\\./0123456789:;<=>?@")[[1]],
               c(" a "))
})


test_that("clean_trigrams is case insensitive", {

  expect_equal(clean_trigrams("ABCDEF"), clean_trigrams("abcdef"))
  expect_equal(clean_trigrams("ABCDEF"), clean_trigrams("abCdEf"))
})


test_that("clean_trigrams keeps UniCode letters", {

  expect_equal(clean_trigrams("এটি একটি ভাষা একক IBM স্ক্রিপ্ট")[[1]],
               c(" এট", "এটি", "টি ", "ি এ", " এক", "একট",
                 "কটি", "টি ", "ি ভ", " ভা", "ভাষ", "াষা",
                 "ষা ", "া এ", " এক", "একক", "কক ", "ক i",
                 " ib", "ibm", "bm ", "m স", " স্", "স্ক", "্ক্",
                 "ক্র", "্রি", "রিপ", "িপ্", "প্ট",
                 "্ট "))
})


test_that("clean_trigrams removed excesive whitespace", {

  expect_equal(clean_trigrams("    a     ")[[1]], c(" a "))
  expect_equal(clean_trigrams("a   a")[[1]], c(" a ", "a a", " a "))
})


test_that("clean_trigrams_table works", {

  tab1 <- structure(
    c(1L, 3L, 1L, 2L, 2L),
    dim = 5L,
    dimnames = structure(
      list(c(" ab", "abc", "bc ", "bca", "cab")),
      names = ""
    ),
    class = "table"
  )

  expect_equal(clean_trigrams_table(c("abcabcabc")), tab1)

  tab2 <- structure(
    integer(0),
    dim = 0L,
    dimnames = structure(list(NULL), names = ""),
    class = "table"
  )

  expect_equal(clean_trigrams_table(""), tab2)
})
