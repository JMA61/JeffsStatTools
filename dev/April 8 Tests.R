

juse(SampleData)
jfilter(Gender == 1)
jt(Friends ~ Gender)       # Should give clear pipeline-aware error
jaov(Friends ~ Gender)     # Same
jchisq(Computer ~ Gender)  # Same
jfilter(NULL)              # Clean up




# ============================================
# TEST 1: Basic functions still work (no filters)
# ============================================
juse(SampleData)
jdesc(, Friends)
jfreq(, Computer)
jt(Friends ~ Gender)
jaov(Friends ~ Employment)

# ============================================
# TEST 2: jfilter
# ============================================
jfilter(Gender == 1)           # Set filter to males
jdesc(, Friends)               # Should show filter line, reduced N
jfreq(, Computer)              # Same
jt(Friends ~ Computer)         # Same

jfilter()                      # Check status
jfilter(off)                   # Turn off
jdesc(, Friends)               # Should show "set but inactive", full N
jfilter(on)                    # Turn back on
jdesc(, Friends)               # Filtered again

# Explicit dataset bypasses filter
jfreq(PopulationData, Computer)  # Should show "not applied" note

jfilter(NULL)                  # Clear

# ============================================
# TEST 3: jcomplete
# ============================================
jcomplete(, Friends, OnsetAge, Education)   # Should show summary table
jdesc(, Friends)               # Should show jcomplete line
jt(Friends ~ Gender)           # Same

jcomplete()                    # Check status
jcomplete(off)                 # Turn off
jdesc(, Friends)               # Should show "set but inactive"
jcomplete(on)                  # Turn back on
jcomplete(NULL)                # Clear

# ============================================
# TEST 4: jcomplete + jfilter stacked
# ============================================
jcomplete(, Friends, OnsetAge, Education)
jfilter(Gender == 1)
jdesc(, Friends)               # Should show both lines, cascading Ns
jt(Friends ~ Computer)         # Same
jlm(Friends ~ OnsetAge)        # Same + missing data line if any

# Clean up
jfilter(NULL)
jcomplete(NULL)

# ============================================
# TEST 5: Missing data line (jt, jaov, jchisq, jlm)
# ============================================
jt(OnsetAge ~ Gender)          # OnsetAge has NAs — should show exclusion line
jaov(OnsetAge ~ Employment)    # Same
jchisq(CrimeType ~ Gender)     # CrimeType has NAs
jlm(OnsetAge ~ Friends + Education)  # Both have NAs





# ============================================
# TEST: subset argument
# ============================================
juse(SampleData)
jfilter(NULL)      # Make sure filter is clear
jcomplete(NULL)    # Make sure jcomplete is clear

# Subset alone
jdesc(, Friends, subset = Gender == 1)        # Males only — should show subset line
jfreq(, Computer, subset = Gender == 1)       # Same
jt(Friends ~ Computer, subset = Gender == 1)  # Same
jaov(Friends ~ Employment, subset = Gender == 1)
jcorr(, Friends, Tattoos, subset = Gender == 1)
jlm(Friends ~ Tattoos, subset = Gender == 1)
jchisq(Computer ~ Employment, subset = Gender == 1)

# Screen specific variables — clean syntax
jscreen(, Friends, Tattoos, OnsetAge)


# Screen with subset — Gender auto-included in output
jscreen(, Friends, Tattoos, OnsetAge, subset = Gender == 1)

# Screen all variables (existing behavior)
jscreen()

# Old explicit syntax still works
jscreen(SampleData[, c("Friends","Tattoos","OnsetAge")])





jalpha(, Conservative1, Conservative2, Conservative3, subset = Gender == 1)

# Subset stacked with jfilter
jfilter(Age >= 20)
jdesc(, Friends, subset = Gender == 1)   # Should show filter line AND subset line
jt(Friends ~ Computer, subset = Gender == 1)

# Subset stacked with jcomplete + jfilter
jcomplete(, Friends, OnsetAge)
jdesc(, Friends, subset = Gender == 1)   # All three lines

# Clean up
jfilter(NULL)
jcomplete(NULL)


jdummy(, Employment)


juse(SampleData)
jfilter(NULL)
jcomplete(NULL)

# ============================================
# TEST: jdummy registration
# ============================================

?jdummy

# Register with default (first category as reference)
jdummy(, Employment)

jfreq(,Employment)

# Show coding scheme
jdummy(, Employment, show = TRUE)

jdummy(, Employment, show = "all")

jdummy(, Employment, ref = 1)
jdummy(, Employment, ref = "Occasional")   # By label name

jdummy(, show = TRUE)
jdummy(, show = "all")

# Change reference to last category
jdummy(, Employment, ref = "last")

jdummy(, Employment, ref = "last", show = TRUE)

# Show updated scheme
jdummy(, Employment, show = TRUE)


jdummy(, Employment, ref = "first", show = TRUE)


# Check status — show all registrations
jdummy()

# Register a second variable
jdummy(, Religion)
jdummy()                    # Should show both

jdummy(, Religion, show = TRUE)      # Should show 5×5 grid
jdummy(, Religion, show = "all")     # Should show full 7×7 grid

jdummy(, Religion, show = TRUE, ref = 3)


jfreq(,Religion)

jdummy(show=TRUE)

# Remove one
jdummy(, Religion, remove = TRUE)
jdummy()                    # Should show only Employment

# Clear all
jdummy(NULL)
jdummy()                    # Should say none registered

# ============================================
# TEST: jlm with registered dummies
# ============================================

# Register Employment for dummy coding
jdummy(, Employment)

# Run regression — Employment should auto-expand
jlm(Friends ~ Employment + Tattoos)

# Register with different reference
jdummy(, Employment, ref = "last")
jlm(Friends ~ Employment + Tattoos)

# Multiple registered variables
jdummy(, Religion)
jlm(Friends ~ Employment + Religion + Tattoos)

# Clean up
jdummy(NULL)

# Regression without dummies — should work as before
jlm(Friends ~ Tattoos + ReadingScore)



juse(SampleData)
jdummy(NULL)                          # Clear any old registrations
jdummy(, Employment)                  # Register fresh
jlm(Friends ~ Employment + Tattoos)  # Should show reference categories line

jfreq(,Employment)

jdummy(, Employment, ref = 3, show="all")

jlm(Friends ~ Employment + Tattoos)


