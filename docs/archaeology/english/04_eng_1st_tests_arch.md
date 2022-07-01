# Tests!

## binomial test

This tests checks whether two nominal values, that are exclusive to each
other, follow a theoretical distribution.

Let’s imagine we’ve got a graveyard with 200 graves and we were able to
determine exactly whether they were male or female. So there are 75
women and 125 men in our dataset.

These numbers make us think and we develop a hypothesis: There were as
many women and men in the society that used the graveyard. We therefore
believe that less women were entombed in this graveyard than men. But of
course our excavation is only a sample, therefore we need to check
whether that’s statistically plausible:

From this we can develop the statistical hypothesis:

-   H0 = There is no difference between the graves of men and women in
    the population. The difference in our sample is by chance.
-   H1 = non-directed: There are differences between the number of men
    and women interred in the graveyard. directed: Men were more often
    entombed than women

Der Binomialtest ist in R base umgesetzt und sehr leicht ausführbar. The
general syntax is
`binom.test(nsuccesses, ntrials, p for successes, alternative="greater / less / two.sided")`.
To translate this in our example:

nsuccesses would be men interred, ntrials are the number of graves we
excavated, p is the statistical chance it should be a man (50%) and
alternative (hypothesis) would be “greater” if we say number of
successes is greater than expected, “less” if the number of successes
are less than expected and “two.sided” if we do a non-directed test.

``` r
binom.test(125, 200, 0.5, alternative="greater")
```

    ## 
    ##  Exact binomial test
    ## 
    ## data:  125 and 200
    ## number of successes = 125, number of trials = 200, p-value = 0.0002497
    ## alternative hypothesis: true probability of success is greater than 0.5
    ## 95 percent confidence interval:
    ##  0.5650678 1.0000000
    ## sample estimates:
    ## probability of success 
    ##                  0.625

``` r
# the other way round is just as possible:
binom.test(75, 200, 0.5, alternative = "less") # now the 75 Frauengräber are "successes" and therefore the alternative hypothesis needs to be turned around to "less"
```

    ## 
    ##  Exact binomial test
    ## 
    ## data:  75 and 200
    ## number of successes = 75, number of trials = 200, p-value = 0.0002497
    ## alternative hypothesis: true probability of success is less than 0.5
    ## 95 percent confidence interval:
    ##  0.0000000 0.4349322
    ## sample estimates:
    ## probability of success 
    ##                  0.375

``` r
# without a direction in the alternative hypothesis
binom.test(75, 200, 0.5, alternative = "two.sided")
```

    ## 
    ##  Exact binomial test
    ## 
    ## data:  75 and 200
    ## number of successes = 75, number of trials = 200, p-value = 0.0004994
    ## alternative hypothesis: true probability of success is not equal to 0.5
    ## 95 percent confidence interval:
    ##  0.3077138 0.4460514
    ## sample estimates:
    ## probability of success 
    ##                  0.375

Easy no?

Let’s do this with a real archaeological data set. Let’s just take the
same question with the burial ground Ernest Witte in Texas:

``` r
library(archdata)
data(EWBurials)
```

Maybe first have a look at what the data set consists of using
`?EWburials`.

What we are going to do is write small functions inside our
test-function. We first ask, how many burials are in the dataset
alltogether (ntrials). For this we can use `nrow`:

``` r
nrow(EWBurials)
```

    ## [1] 49

Now we need to now, how many of those are of men? So we do a subset of
`EWBurials`, where `EWBurials$Sex` equals “Male”:

``` r
nrow(EWBurials[EWBurials$Sex == "Male",])
```

    ## [1] 25

don’t forget the comma at the end: Remeber, using square brackets \[,\]
enabled us to choose certain values from a table by selecting rows and
columns. We can also add a condition. And we want to filter the rows for
where the column Sex gives “Male”, so we put this condition in the
“rows” part inside the square brackets. But the columns part must “still
be there”, even if it stays empty.

Now, we don’t want to copy and paste the values we learned from the
`nrow()` calls, that’s bad practice. We will just put the code inside
the function:

``` r
binom.test(nrow(EWBurials[EWBurials$Sex == "Male",]), 
           nrow(EWBurials), 
           0.5, alternative = "two.sided")
```

    ## 
    ##  Exact binomial test
    ## 
    ## data:  nrow(EWBurials[EWBurials$Sex == "Male", ]) and nrow(EWBurials)
    ## number of successes = 25, number of trials = 49, p-value = 1
    ## alternative hypothesis: true probability of success is not equal to 0.5
    ## 95 percent confidence interval:
    ##  0.3633783 0.6557526
    ## sample estimates:
    ## probability of success 
    ##              0.5102041

How can we interprete the result? The p-value is 1!

So there is a 100% chance that we are WRONG if we accept the alternative
hypothesis… soo… yes, here we have a 50-50 distribution of men and
women. No surprise for those who looked at the numbers before.

But that’s how easy the binomial test is!