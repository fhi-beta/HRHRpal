
<!-- README.md is generated from README.Rmd. Please edit that file -->
    ## Loading HRHRpal

HRHRpal
=======

The goal of HRHRpal is to ...

Installation
------------

You can install HRHRpal from the Folkehelseinstituttet repository via:

``` r
install.packages("HRHRpal", repos="https://folkehelseinstituttet.github.io/drat/")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
print(data)
#>     id weight
#> 1 1001     41
#> 2 1001     42
#> 3 1002     43
#> 4 1001     44
#> 5 1003     45
#> 6 1003     46
ProtectIdentifier(data=data,identifier = "id", seed=4)
#> [1] "id"     "weight"
```
