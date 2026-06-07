# JeffsStatTools

**Simplified, SPSS-style statistical analysis tools for R.**

JeffsStatTools provides clean, consistent, plain-language functions for the
analyses social scientists use most often. It is designed for researchers,
students, and instructors — including those moving to R from SPSS, Stata, or
SAS — who want to get standard analyses done without first learning a new set
of programming conventions. Output is styled after familiar SPSS conventions,
defaults follow traditional practice, and every function works directly with
`haven`-imported data, including value labels, variable labels, and
user-defined missing values.

## Installation

```r
# install.packages("remotes")
remotes::install_github("JMA61/JeffsStatTools")
```

Requires R (>= 4.2.0).

## Design

- **Consistent, memorable syntax.** Every user-facing function is prefixed with
  `j` (`jdesc`, `jfreq`, `jt`, `jlm`, ...), so the toolkit is easy to discover
  and recall.
- **Sensible defaults.** Traditional choices are the defaults (e.g. Student's
  *t*, standard ANOVA), with options available when you need them.
- **Works with labelled data as-is.** Functions accept `haven`-labelled or
  plain numeric variables directly — no manual conversion to factors required —
  and handle SPSS-, Stata-, and SAS-style missing values.
- **Close to base R.** The syntax stays near base-R conventions so skills
  remain transferable, rather than teaching a private dialect.

## What it does

**Describing and screening data**
- `jdesc` — descriptive statistics
- `jfreq` — frequency tables
- `jscreen` — variable screening / overview
- `jcorr` — correlation matrices
- `jalpha` — scale reliability (Cronbach's alpha)

**Comparing groups and fitting models**
- `jt` — t-tests
- `jaov` — analysis of variance
- `jcrosstab` — cross-tabulation with chi-square
- `jlm` — linear regression
- `jlogistic` — logistic regression
- `jplot` — plots for the analyses above

**Preparing data**
- `jrecode` — recode values
- `jrelabel` — set or change value labels
- `jdummy` — dummy-code categorical variables
- `jnumeric` / `jcount` / `jlikert` — declare a variable's measurement role
- `jsubset` — subset cases by a logical condition

**Reading, writing, and converting**
- `jload` / `jsave` — read and write data, preserving labels and missing-value
  metadata across SPSS, Stata, SAS, Excel, CSV, and R formats
- `jconvert` — convert missing-value representations between formats
- `jdeclare_udm` — declare user-defined missing values

## Example

```r
library(JeffsStatTools)

# Descriptive statistics for several variables
jdesc(mydata, Age, Income, ReadingScore)

# Group comparison with a formula interface
jt(ReadingScore ~ Gender, mydata)

# Linear regression
jlm(ReadingScore ~ Age + Income, mydata)
```

## Status

JeffsStatTools is in active development and is updated frequently. It originated
as teaching infrastructure for a university statistics course and is being
generalized for broader use by social-science researchers.

## Author and license

Developed and maintained by Jeff Ackerman. Released under the MIT License.
