

SampleData <- readRDS("../7036_2026/Data/7036CCJSampleData.rds")




## Different ways to run jfreq() ##
jfreq(SampleData$Conservative3)   #   Similar to the way Base R specifies the dataset name and variable name


jfreq(SampleData, Conservative3)  #   The normal way that jfreq() uses.

juse(SampleData)  # the new juse() function to set a default dataset for the session
jfreq(,Conservative3) # The quicker way that relies upon the default dataset being specified earlier with juse()
