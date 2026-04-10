


SampleData <- readRDS("../7036_2026/Data/7036CCJSampleData.rds")

SampleData$TotalCrime <- SampleData$Drugs + SampleData$Graffiti + SampleData$Smoking #Remember, you need 6 variables for the Assessments

jdesc(SampleData,TotalCrime) # run descriptives on the new variable.


jdesc(SampleData,TotalCrime, by = Gender)
jt(TotalCrime ~ Gender, data = SampleData)

juse(SampleData)
SampleData$Conservative3R <- jrecode(,Conservative3,map = "5=1; 4=2; 3=3; 2=4; 1=5")
jfreq(,Conservative3, Conservative3R)



jdesc(TotalCrime)


jdesc(,Gender)

?juse
