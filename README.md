
<!-- README.md is generated from README.Rmd. Please edit that file -->

# democombine

<!-- badges: start -->
<!-- badges: end -->

The goal of democombine is to demonstrate an issue with using
`dplyr::combine()` when you have your own `combine` function method.

## Installation

You can install the development version of democombine from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("njtierney/democombine")
```

## Example of issue

``` r
library(democombine)

x <- my_class(1:10)
y <- my_class(20:10)

x
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> attr(,"class")
#> [1] "my_class" "integer"
y
#>  [1] 20 19 18 17 16 15 14 13 12 11 10
#> attr(,"class")
#> [1] "my_class" "integer"

combine(x, y)
#> combining x and y
#>  [1]  1  2  3  4  5  6  7  8  9 10 20 19 18 17 16 15 14 13 12 11 10
```

So that works fine, but then if you load dplyr, you get a namespace
conflict, which overwrites the S3 method:

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following object is masked from 'package:democombine':
#> 
#>     combine
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

combine(x, y)
#> Warning: `combine()` was deprecated in dplyr 1.0.0.
#> ℹ Please use `vctrs::vec_c()` instead.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
#>  [1]  1  2  3  4  5  6  7  8  9 10 20 19 18 17 16 15 14 13 12 11 10
#> attr(,"class")
#> [1] "my_class" "integer"
```

You can resolve this with `conflicted`. But I’m wondering if there’s a
way to force `dplyr::combine` to be turned into an S3 method so we can
use our own `combine` method?
