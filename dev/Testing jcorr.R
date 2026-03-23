

## Test Stuff ##

SampleData <- readRDS("../7036_2026/Data/7036CCJSampleData.rds")

#Built In Data
jcorr(mtcars, mpg, hp, wt)


# 3 Interval variables
jcorr(SampleData, JuvenileDelinquency, ReadingScore, OnsetAge)

#2 Interval variables
jcorr(SampleData, JuvenileDelinquency, OnsetAge)

#1 Interval variable
jcorr(SampleData, JuvenileDelinquency)

#1 Categorical variable
jcorr(SampleData, Gender)

# 1 Interval and one 2 category
jcorr(SampleData, JuvenileDelinquency, Gender)

# 1 Interval and one 3 category
jcorr(SampleData, JuvenileDelinquency, RlshpStatus)


