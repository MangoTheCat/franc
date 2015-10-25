


# franc

> Detect the Language of Text

[![Linux Build Status](https://travis-ci.org/gaborcsardi/franc.svg?branch=master)](https://travis-ci.org/gaborcsardi/franc)
[![Windows Build status](https://ci.appveyor.com/api/projects/status/github/gaborcsardi/franc?svg=true)](https://ci.appveyor.com/project/gaborcsardi/franc)
[![](http://www.r-pkg.org/badges/version/franc)](http://www.r-pkg.org/pkg/franc)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/franc)](http://www.r-pkg.org/pkg/franc)

Franc has no external dependencies and supports 310 languages; all
languages spoken by more than one million speakers. Franc is a port
of the JavaScript project of the same name, see
https://github.com/wooorm/franc.

## Installation


```r
devtools::install_github("gaborcsardi/franc")
```

## Usage


```r
library(franc)
```

Simply supply the text, and franc detects its language:


```r
franc("Alle menslike wesens word vry")
```

```
#> [1] "afr"
```

```r
franc("এটি একটি ভাষা একক IBM স্ক্রিপ্ট")
```

```
#> [1] "ben"
```

```r
franc("Alle mennesker er født frie og")
```

```
#> [1] "nno"
```

```r
head(franc_all("O Brasil caiu 26 posições em"))
```

```
#>   language     score
#> 1      por 1.0000000
#> 2      glg 0.7362599
#> 3      src 0.7286554
#> 4      lav 0.6944348
#> 5      cat 0.6802627
#> 6      spa 0.6633253
```

`und` is the `undefined` language, this is returned if the input is
too short (shorter than 10 characters by default).


```r
franc("the")
```

```
#> [1] "und"
```

```r
franc("the", min_length = 3)
```

```
#> [1] "sco"
```

You can provide a whitelist or a blacklist:


```r
franc_all("O Brasil caiu 26 posições em",
    whitelist = c("por", "src", "glg", "spa"))
```

```
#>   language     score
#> 1      por 1.0000000
#> 2      glg 0.7362599
#> 3      src 0.7286554
#> 4      spa 0.6633253
```

```r
head(franc_all("O Brasil caiu 26 posições em",
    blacklist = c("src", "glg", "lav")))
```

```
#>   language     score
#> 1      por 1.0000000
#> 2      cat 0.6802627
#> 3      spa 0.6633253
#> 4      bos 0.6536467
#> 5      tpi 0.6477705
#> 6      hrv 0.6456965
```

## Supported languages

The R version of franc supports 310 languages. By default only the
languages with more than 1 million speakers are used, this is 175
languages. The \code{min_speakers} argument can relax this, and allows
using more languages:


```r
head(franc_all("O Brasil caiu 26 posições em"))
```

```
#>   language     score
#> 1      por 1.0000000
#> 2      glg 0.7362599
#> 3      src 0.7286554
#> 4      lav 0.6944348
#> 5      cat 0.6802627
#> 6      spa 0.6633253
```

```r
head(franc_all("O Brasil caiu 26 posições em", min_speakers = 0))
```

```
#>   language     score
#> 1      por 1.0000000
#> 2      lad 0.8475631
#> 3      roh 0.7452471
#> 4      ast 0.7400622
#> 5      glg 0.7362599
#> 6      src 0.7286554
```

## License

MIT © Gábor Csárdi, Titus Wormer, Maciej Ceglowski, Jacob R. Rideout
and Kent S. Johnson.
