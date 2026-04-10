


SampleData <- readRDS("../7036_2026/Data/7036CCJSampleData.rds")


# ============================================
# TEST: jrecode with Conservative3
# ============================================
juse(SampleData)
jfilter(NULL)
jcomplete(NULL)

# First, check what's in the variable
jfreq(, Conservative3)

# --- Correct usage ---

# Basic recode: reverse-code a 1-5 Likert item
SampleData$Conservative3R <- jrecode(, Conservative3,
                                     map = "1=5; 2=4; 3=3; 4=2; 5=1",
                                     labels = "1=Strongly Support; 2=Support; 3=Neutral; 4=Oppose; 5=Strongly Oppose")

# Check it worked
jfreq(, Conservative3R)

# Recode using juse default, no labels (should auto-transfer)
SampleData$Conservative3R2 <- jrecode(, Conservative3,
                                      map = "1=5; 2=4; 3=3; 4=2; 5=1")
jfreq(, Conservative3R2)

jfreq(, Conservative3)
jfreq(, Conservative3R2)




# Recode with else=copy
SampleData$Conservative3R3 <- jrecode(, Conservative3,
                                      map = "1=5; 5=1; else=copy")    ### This is a wrong mapping.

jfreq(, Conservative3, Conservative3R3)

jfreq(, Conservative3, Conservative3R,Conservative3R2, Conservative3R3)

# Collapse categories
SampleData$Conservative3C <- jrecode(, Conservative3,
                                     map = "1,2=1; 3=2; 4,5=3",
                                     labels = "1=Low; 2=Mid; 3=High")
jfreq(, Conservative3C)

# --- Common student mistakes ---

# Missing the leading comma (juse is set)
# Should get helpful "add a leading comma" message
jrecode(Conservative3, map = "1=5; 2=4; 3=3; 4=2; 5=1")

# Forgetting to assign the result
jrecode(, Conservative3, map = "1=5; 2=4; 3=3; 4=2; 5=1")
# (This runs silently — student wonders why nothing changed)

# Missing a value in the map (no else clause)
# Should stop and list unmapped values
SampleData$test <- jrecode(, Conservative3,
                           map = "1=5; 2=4; 3=3; 4=2")

# Typo in map — value that doesn't exist
SampleData$test <- jrecode(, Conservative3,
                           map = "1=5; 2=4; 3=3; 4=2; 5=1; 6=0")

jfreq(,test)

# Forgetting quotes around map
SampleData$test <- jrecode(, Conservative3, map = 1=5; 2=4)

# Wrong format — using commas instead of semicolons between rules
SampleData$test <- jrecode(, Conservative3, map = "1=5, 2=4, 3=3")

# ============================================
# TEST: jrelabel
# ============================================

# Add labels to the reverse-coded variable
SampleData$Conservative3R <- jrelabel(, Conservative3R,
                                      labels = "1=Strongly Support; 2=Support; 3=Neutral; 4=Oppose; 5=Strongly Oppose",
                                      var_label = "Conservatism Item 3 (reversed)")
jfreq(, Conservative3R)

# --- Student mistakes ---

# Missing leading comma
jrelabel(Conservative3R, labels = "1=Yes; 0=No")

# Variable doesn't exist
SampleData$test <- jrelabel(, NonExistentVar, labels = "1=Yes")

# ============================================
# TEST: jalpha — correct usage with reverse-coded item
# ============================================

# Make sure Conservative3R exists with proper recode
SampleData$Conservative3R <- jrecode(, Conservative3,
                                     map = "1=5; 2=4; 3=3; 4=2; 5=1",
                                     labels = "1=Strongly Support; 2=Support; 3=Neutral; 4=Oppose; 5=Strongly Oppose")

# Correct: use reverse-coded item
jalpha(, Conservative1, Conservative2, Conservative3R, Conservative4, Conservative5, Conservative6)

# ============================================
# TEST: jalpha — WRONG: using original unreversed item
# Should detect negative item-total correlation and warn
# ============================================
jalpha(, Conservative1, Conservative2, Conservative3, Conservative4, Conservative5, Conservative6)

# ============================================
# TEST: jalpha with subset and filter
# ============================================
jalpha(, Conservative1, Conservative2, Conservative3R, Conservative4, Conservative5, Conservative6,
       subset = Gender == 1)

jfilter(Gender == 2)
jalpha(, Conservative1, Conservative2, Conservative3R, Conservative4, Conservative5, Conservative6)

# Clean up
jfilter(NULL)

# ============================================
# TEST: jalpha — student mistakes
# ============================================

# Missing leading comma
jalpha(Conservative1, Conservative2, Conservative3R)

# Only one item
jalpha(, Conservative1)

# Variable doesn't exist
jalpha(, Conservative1, Conservative2, Conservative99)

?juse
?jfilter
?jcomplete
?jdummy
?jdesc
?jfreq
?jt
?jaov
?jcorr
?jlm
?jchisq
?jscreen
?jalpha
?jrelabel
?jrecode

juse(mtcars)
jcomplete(, mpg, hp, wt, am)
jdesc(, mpg)                   # Uses only complete cases on those 4 vars
jcomplete(off)                 # Deactivate
jcomplete(on)                  # Reactivate
jcomplete()                    # Check status
jcomplete(NULL)                # Clear entirely


juse(mtcars)
jdummy(, cyl)                         # Register, first category as reference
jdummy(, cyl, ref = "last")          # Last category as reference
jdummy(, cyl, ref = 6)              # Reference by numeric code
# For haven-labelled variables, use the label name:
# jdummy(, Employment, ref = "Part-Time")
jdummy(, cyl, show = TRUE)          # Show coding scheme
jdummy(, cyl, show = "all")         # Full scheme (for many categories)
jdummy()                             # Show all registrations
jdummy(, cyl, remove = TRUE)        # Remove registration
jdummy(NULL)                         # Clear all

juse(SampleData)
jdesc(,Gender)


jdesc(mtcars, mpg)
jdesc(mtcars, mpg, hp, wt)
jdesc(mtcars, mpg, by = am)

# Using juse() default
juse(mtcars)
jdesc(, mpg)
jdesc(, mpg, hp, wt)
jdesc(, mpg, by = am)


# With explicit data frame
jfreq(mtcars, cyl)
jfreq(mtcars, cyl, gear)

# Using juse() default
juse(mtcars)
jfreq(, cyl)
jfreq(, cyl, gear)

juse(mtcars)
jchisq(cyl ~ am)
jchisq(cyl ~ am, expected = TRUE)


jalpha(attitude, rating, complaints, privileges, learning, raises)

# Using juse() default
juse(attitude)
jalpha(, rating, complaints, privileges, learning, raises)


# Add value labels after a recode
df <- data.frame(Status = c(1, 2, 1, 2, 1, 2))
df$StatusR <- ifelse(df$Status == 1, 1, 0)
df$StatusR <- jrelabel(df, StatusR, labels = "1=Yes; 0=No",
                       var_label = "Status (recoded)")
jfreq(df$StatusR)


# Add just a variable label
df$StatusR <- jrelabel(df, StatusR, var_label = "Employment Status")




# Add just value labels
df$StatusR <- jrelabel(df, StatusR, labels = "1=Yes; 0=No")

# Using juse() default
juse(df)
df$StatusR <- jrelabel(, StatusR, labels = "1=Active; 0=Inactive")


# Recode with explicit labels
df <- data.frame(gear = mtcars$gear)
df$gearR <- jrecode(df, gear,
                    map    = "3=1; 4=2; 5=3",
                    labels = "1=Three; 2=Four; 3=Five")

jfreq(df, gearR )



# Collapse categories (must supply labels)
df$gearR2 <- jrecode(df, gear,
                     map    = "3=1; 4,5=2",
                     labels = "1=Three gears; 2=Four or five gears")

# Use else=copy to carry unspecified values across unchanged
df$gearR3 <- jrecode(df, gear,
                     map    = "3=1; else=copy",
                     labels = "1=Three gears")

# Use else=NA to deliberately drop unspecified values
df$gearR4 <- jrecode(df, gear,
                     map    = "3=1; 4=2; else=NA",
                     labels = "1=Three gears; 2=Four gears")

# Using juse() default
juse(df)
df$gearR5 <- jrecode(, gear, map = "3=1; 4=2; 5=3",
                     labels = "1=Three; 2=Four; 3=Five")



devtools::load_all()
juse(mtcars)
jdesc(, mpg, hp, wt)
jdesc(, mpg, by = am)
jdesc(mtcars$mpg)

jdesc(mtcars$mpg)
jfreq(mtcars$gear)
