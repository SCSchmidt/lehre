# Tests!

## chi squared test as goodness of fit

This example for the chi square test is similar to the binomial test.
It’s a goodness of fit test and we take only two values in “on what kind
of slope” do the graves lie (slope or flat). But this is just to keep
the example small. Here, there could be many more categories!

So, we have 40,4% of the area being a slope and 59,6% being flat areas
and there are 10 graves on sloped areas and 50 graves on flat areas. Is
this a siginifcant distribution or a random one over the “offered”
areas?

``` r
# number of Neolithic graves
nl_G <- c(10,50)
# the probability they should follow (area percentage in the working area 
Vert_fl <- c(0.404,0.596)
# test is run by:
chisq.test(nl_G, p = Vert_fl)
```

    ## 
    ##  Chi-squared test for given probabilities
    ## 
    ## data:  nl_G
    ## X-squared = 14.036, df = 1, p-value = 0.0001794

``` r
# don't forget the "p =" as I did first! ;-)
```

We can see: The p-value is small enough for us to accept the H1
hypothesis: The graves are not distributed in the same way as the flat
and sloped areas.

As I explained, we should check, whether there are not more than 20% of
the expected values below 5.

Therefore we give *the whole test* to a variable. This will save a list
of different values and tables related to the calculation of the chi
square test.

``` r
# I'll just call the variable chi
chi <- chisq.test(nl_G, p = Vert_fl)
chi$expected
```

    ## [1] 24.24 35.76

``` r
chi$p.value
```

    ## [1] 0.000179351

With `chi$expected` I can check whether that rule of the chi square test
is followed. Secondly this is really nice, because I can write inside my
Rmd-document in the text part \` r chi$p.value \` to get the p-value
printed: 1.7935097^{-4}.

## Chi square to check for dependance of two variables / group differences

We can use the chi square test to check whether grave goods and sex in
the EWBurial dataset correlate.

``` r
library(archdata)
data("EWBurials")
```

For this we need to give the chi square test a `table` object. Tables
are cross-tables created by the `table()` function. With this we can
see, how often the variables co-occur in one row of information in our
EWBurials table:

``` r
#  let's look at the table
table(EWBurials$Sex, EWBurials$Goods)
```

    ##         
    ##          Absent Present
    ##   Female     13      11
    ##   Male       10      15

``` r
# and then we feed it in the algorithm (chisq.test)
chisq.test(table(EWBurials$Sex, EWBurials$Goods))
```

    ## 
    ##  Pearson's Chi-squared test with Yates' continuity correction
    ## 
    ## data:  table(EWBurials$Sex, EWBurials$Goods)
    ## X-squared = 0.49987, df = 1, p-value = 0.4796

Now, there is a p value of almost 0.5 . What does this mean?

A chance of 50% that we are wrong, when we accept the alternative
hypothesis.

This **DOES NOT** mean, that there is a 50% chance that H0 is true. With
an hypothesis test like this we always check whether we may accept the
H1 hypothesis. We always assume everything is random (H0), because we
take *random samples* from our populations. There may be random
differences as a consequence! Therefore we only check the chance of
error if we accept H1. And we accept H1 **only** if this possibility of
error is very very small. Otherways we always assume H0 is true in the
population as well.

In the case of this example the difference between the values of the
male and female graves are quite small, so it is not surprising that
there this is no statistical significant difference. We can see this
also, if we compare this to the expected values:

``` r
chi2 <- chisq.test(table(EWBurials$Sex,
                         EWBurials$Goods))
chi2$expected
```

    ##         
    ##            Absent  Present
    ##   Female 11.26531 12.73469
    ##   Male   11.73469 13.26531

Let’s check now, as another example, whether age group has anything to
do with appearance of grave goods. There, in the column “Age”, there are
several groups: “Child”, “Adolescent”, “young Adult”…

``` r
tab_A_G <- table(EWBurials$Age, EWBurials$Goods)
chi_tab_A_G <- chisq.test(tab_A_G)
```

    ## Warning in chisq.test(tab_A_G): Chi-squared approximation may be incorrect

How can we interprete this result?

Yeah - no significance of difference, therefore: all difference is by
chance.

But let’s check whether we were “allowed” to do this test:

``` r
chi_tab_A_G$expected
```

    ##               
    ##                   Absent   Present
    ##   Child        0.9387755  1.061224
    ##   Adolescent   1.4081633  1.591837
    ##   Young Adult  8.9183673 10.081633
    ##   Adult        1.4081633  1.591837
    ##   Middle Adult 4.6938776  5.306122
    ##   Old Adult    5.6326531  6.367347

Okay, so, there were too many values below 5 in the expected values
table.

One way to deal with this is to combine groups, so that together their
expected value is \>5.

But these “mergings” of groups should of course be only done if they are
archaeologically sensible!

# Are my data normally distributed?

## Q-Q-plot

The q-q-plot is a “Quantile-Quantile-Plot” in which the sample
distribution and a theoretical normally distributed distribution are
compared. If these pairs of values follow the 45° line that’s being
drawn in this plot they are normally distributed. “How much” they may
deviate is determined by a confidence interval drawn in grey.

The package we need for this is called `ggpubr`, let’s install it:

``` r
install.packages("ggpubr")
```

We will have a look whether the rim diameter in the `BACups` dataset is
normally distributed.

``` r
library(ggplot2)
library(ggpubr)

data("BACups")
ggqqplot(BACups$RD)
```

![](04_eng_2nd_tests_arch_files/figure-markdown_github/Q-Q-Plot-1.png)

There is some deviation from the confidence interval and the 45° line,
therefore we assume it’s not normally distributed.

We could assume, that is because there are two phases in our dataset.
Always check whether your dataset is actually consisting of several
subgroups. These will quite often “destroy” any “normality” in the
distribution that you may have in the subgroups themselves.

So let’s test this with the subgroups of Phases:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(magrittr)

BACups %>%
  filter(Phase == "Protoapennine") %>% # take only the protoapennine data
  use_series(RD)%>% # take the RD column
  ggqqplot() #draw the qqplot.
```

![](04_eng_2nd_tests_arch_files/figure-markdown_github/unnamed-chunk-3-1.png)

This looks much more “normal”

Let’s check the second phase:

``` r
BACups %>%
  filter(Phase == "Subapennine") %>%
  use_series(RD)%>%
  ggqqplot()
```

![](04_eng_2nd_tests_arch_files/figure-markdown_github/unnamed-chunk-4-1.png)

Well, I’m not so sure about that one, it looks more not normal. So let’s
test this!

## Shapiro-Wilk-Test

``` r
BACups %>%
  filter(Phase == "Subapennine") %>%
  use_series(RD)%>%
  shapiro.test()
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  .
    ## W = 0.89719, p-value = 0.001585

This p-value means there is a difference between the normal distribution
and the sample. We don’t have a normal distribution.

Now, if we don’t have a normal distribution we need to turn to
non-parametric test to check for differences between two groups.

# parametric tests

## U test

Let’s start with the U / Wilcoxon test.

``` r
wilcox.test(BACups$RD[BACups$Phase == "Subapennine"],
            BACups$RD[BACups$Phase == "Protoapennine"],
            alternative = "two.sided")
```

    ## Warning in wilcox.test.default(BACups$RD[BACups$Phase == "Subapennine"], :
    ## cannot compute exact p-value with ties

    ## 
    ##  Wilcoxon rank sum test with continuity correction
    ## 
    ## data:  BACups$RD[BACups$Phase == "Subapennine"] and BACups$RD[BACups$Phase == "Protoapennine"]
    ## W = 573.5, p-value = 0.006633
    ## alternative hypothesis: true location shift is not equal to 0

The small p value suggests, there is a significant difference between
the subapennie and protoapennine cups.

We usually can see this in a visualisation of our data. So let’s just
check with a fast boxplot:

``` r
ggplot()+
  geom_boxplot(data = BACups, aes(x = Phase, y = RD))
```

![](04_eng_2nd_tests_arch_files/figure-markdown_github/unnamed-chunk-6-1.png)

Yeah, the median values are quite different. Looks good to me.

Let’s talk about a different test:

# KS- test

We can try the same datasets again

``` r
ks.test(BACups$RD[BACups$Phase == "Subapennine"],
            BACups$RD[BACups$Phase == "Protoapennine"],)
```

    ## Warning in ks.test(BACups$RD[BACups$Phase == "Subapennine"],
    ## BACups$RD[BACups$Phase == : cannot compute exact p-value with ties

    ## 
    ##  Two-sample Kolmogorov-Smirnov test
    ## 
    ## data:  BACups$RD[BACups$Phase == "Subapennine"] and BACups$RD[BACups$Phase == "Protoapennine"]
    ## D = 0.35, p-value = 0.07626
    ## alternative hypothesis: two-sided

Noooow, why is this p-value above 0.05? Does this mean there is no
difference between the two groups? But the wilcox.test said there was!

Each test has a different focus. KS test is sensitive for any difference
between the two samples. U-test is more sensitive if the median is
different. U- test works better with „ties“ and therefore better for
ordinal data. KS is better used only for metric data. So try to think
about what fits best to your data and your archaeological question. Or
stick to the choice of test someone else used for this question. ;-)

Now, if we have normally distributed data, we can do:

# Parametric tests

We’re going to take a totally arbitrary example from the Fibulae dataset
of archdata:

``` r
data("Fibulae")

# randomly make two groups out of them:
Fib_6c <- subset(Fibulae, Fibulae$Coils < 7)
Fib_7c <- subset(Fibulae, Fibulae$Coils > 6)

# shapiro test both groups
shapiro.test(Fib_6c$BT)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  Fib_6c$BT
    ## W = 0.96166, p-value = 0.4252

``` r
shapiro.test(Fib_7c$BT)
```

    ## 
    ##  Shapiro-Wilk normality test
    ## 
    ## data:  Fib_7c$BT
    ## W = 0.90969, p-value = 0.4808

Both groups are normally distributed. :-)

## F test

This first test is a simple analysis of variance (ANOVA). The test
statistic is the variance of one sample divided of the variance of the
second sample.

-   H0: the two variances do not differ significantly from each other
    therefore they are from the same distribution

-   H1: the true ratio variance is not equal to 1, so we have two
    populations.

``` r
var.test(Fib_6c$BT,
         Fib_7c$BT)
```

    ## 
    ##  F test to compare two variances
    ## 
    ## data:  Fib_6c$BT and Fib_7c$BT
    ## F = 1.0233, num df = 25, denom df = 3, p-value = 0.8384
    ## alternative hypothesis: true ratio of variances is not equal to 1
    ## 95 percent confidence interval:
    ##  0.07249421 3.78030773
    ## sample estimates:
    ## ratio of variances 
    ##           1.023289

The p-value suggests lets us reject the alternative hypothesis.

So let’s turn to the next test:

## t-test

The t test looks for the difference between the mean of the two samples:

``` r
t.test(Fib_6c$BT,
         Fib_7c$BT)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  Fib_6c$BT and Fib_7c$BT
    ## t = 0.6811, df = 4.007, p-value = 0.5331
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  -1.761425  2.907578
    ## sample estimates:
    ## mean of x mean of y 
    ##  4.073077  3.500000

The interpretation of the p-value: Because the chance of error of 53% if
we accept H1, we reject H1.

Yeah, not suprising, thinking about how randomly we divided our dataset
in the beginning.
