
<!-- README.md is generated from README.Rmd. Please edit that file -->
HRHRpal
=======

The goal of HRHRpal is to ...

Installation
------------

You can install HRHRpal from the Folkehelseinstituttet repository via:

``` r
r <- getOption("repos")
r["fhi"] = "https://folkehelseinstituttet.github.io/drat/"
options(repos = r)

install.packages("HRHRpal")
```

ProtectIdentifier
-----------------

This function takes a data.table (`data`) with a numerical identifier (`id`).

``` r
print(data)
#>      id weight
#> 1: 1001     41
#> 2: 1001     42
#> 3: 1002     43
#> 4: 1001     44
#> 5: 1003     45
#> 6: 1003     46
```

We can then apply the `ProtectIdentifier` function to `data`.

``` r
key <- ProtectIdentifier(data=data,identifier = "id", seed=4)
```

`ProtectIdentifier` works by obtaining a list of all unique values of the identifier

    #>     old
    #> 1: 1001
    #> 2: 1002
    #> 3: 1003

The rows are then sorted randomly:

    #>     old
    #> 1: 1002
    #> 2: 1003
    #> 3: 1001

The rows are then numbered:

    #>     old new variableName
    #> 1: 1002   1           id
    #> 2: 1003   2           id
    #> 3: 1001   3           id

The new values are then assigned to the original dataset:

    #>    id weight
    #> 1:  3     41
    #> 2:  3     42
    #> 3:  1     43
    #> 4:  3     44
    #> 5:  2     45
    #> 6:  2     46
