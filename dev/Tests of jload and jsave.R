# ============================================================
# jload() TESTS
# ============================================================

# --- Basic load from Data/ folder ---
jload("New7036CCJSampleData.rds")

# --- Load with use = TRUE ---
jload("New7036CCJSampleData.rds", use = TRUE, overwrite = TRUE)
juse()   # Should show New7036CCJSampleData as default

# --- Load with custom name ---
jload("New7036CCJSampleData.rds", name = "MyData", overwrite = TRUE)
ls()     # Should show MyData in environment

# --- No extension (should find the .rds automatically) ---
jload("New7036CCJSampleData", overwrite = TRUE)

# --- Overwrite prompt (run twice without overwrite = TRUE) ---
jload("New7036CCJSampleData.rds")
jload("New7036CCJSampleData.rds")   # Should prompt y/n

# --- Overwrite bypass ---
jload("New7036CCJSampleData.rds", overwrite = TRUE)   # No prompt

# --- Leading digit filename ---
# (Only works if you have a file starting with a number)
jload("7036CCJSampleData.sav")   # Should error with name= suggestion

jload("7036CCJSampleData.sav", name = "CCJSampleData")

# --- File not found ---
jload("nonexistent_file.sav")   # Should error with search locations

# --- Bad extension ---
jload("mydata.xlsx")   # Should error with supported formats list

# --- .RData redirect ---
jload("something.RData")   # Should error with load() suggestion

# --- No extension, no match ---
jload("totallyFakeFile")   # Should error

# --- Case insensitive extension ---
# (Rename your file to .RDS temporarily to test, or skip)

# --- Empty/missing argument ---
jload("")          # Should error
jload()            # Should error


# ============================================================
# jsave() TESTS
# ============================================================

# --- Make sure we have data loaded ---
jload("New7036CCJSampleData.rds", name = "TestData", overwrite = TRUE)

# --- Save to each format ---
jsave(TestData, "test_output.sav", overwrite = TRUE)
jsave(TestData, "test_output.dta", overwrite = TRUE)
jsave(TestData, "test_output.xpt", overwrite = TRUE)
jsave(TestData, "test_output.rds", overwrite = TRUE)
jsave(TestData, "test_output.csv", overwrite = TRUE)   # Should show CSV label note

# --- Verify files were created ---
list.files("Data", pattern = "test_output")

# --- Save using juse() default ---
juse(TestData)
jsave(, "test_default.sav", overwrite = TRUE)   # Should use TestData

# --- Overwrite prompt (save same file twice without overwrite) ---
jsave(TestData, "test_overwrite.rds", overwrite = TRUE)   # First time
jsave(TestData, "test_overwrite.rds")                      # Should prompt y/n

# --- No extension ---
jsave(TestData, "test_no_ext")   # Should error with format list

# --- Bad extension ---
jsave(TestData, "test.xlsx")   # Should error with supported formats

# --- Not a data frame ---
myVector <- c(1, 2, 3)
jsave(myVector, "test.sav")   # Should error

# --- Missing file argument ---
jsave(TestData)   # Should error


# ============================================================
# ROUND-TRIP TESTS (save then reload)
# ============================================================

# --- .sav round-trip ---
jsave(TestData, "roundtrip.sav", overwrite = TRUE)
jload("roundtrip.sav", name = "RT_sav", overwrite = TRUE)
cat("SAV round-trip rows match:", nrow(TestData) == nrow(RT_sav), "\n")
cat("SAV round-trip cols match:", ncol(TestData) == ncol(RT_sav), "\n")

# --- .rds round-trip ---
jsave(TestData, "roundtrip.rds", overwrite = TRUE)
jload("roundtrip.rds", name = "RT_rds", overwrite = TRUE)
cat("RDS round-trip identical:", identical(TestData, RT_rds), "\n")

# --- .csv round-trip ---
jsave(TestData, "roundtrip.csv", overwrite = TRUE)
jload("roundtrip.csv", name = "RT_csv", overwrite = TRUE)
cat("CSV round-trip rows match:", nrow(TestData) == nrow(RT_csv), "\n")
cat("CSV round-trip cols match:", ncol(TestData) == ncol(RT_csv), "\n")
# Note: CSV won't be identical due to lost labels and type changes

# --- .dta round-trip ---
jsave(TestData, "roundtrip.dta", overwrite = TRUE)
jload("roundtrip.dta", name = "RT_dta", overwrite = TRUE)
cat("DTA round-trip rows match:", nrow(TestData) == nrow(RT_dta), "\n")
cat("DTA round-trip cols match:", ncol(TestData) == ncol(RT_dta), "\n")


# ============================================================
# CLEANUP (optional — remove test files)
# ============================================================
# file.remove(list.files("Data", pattern = "^test_|^roundtrip", full.names = TRUE))

?juse

juse(mtcars)           # Set mtcars as the default
juse()                 # Display current default
jdesc(, mpg, hp)       # Uses mtcars automatically
juse(NULL)             # Clear the default

?jdummy

juse(mtcars)
jfreq(,cyl)
jfreq(mtcars,cyl)

jdummy(, cyl)                         # Register, first category as reference
jdummy(, cyl, ref = "last")          # Last category as reference
jdummy(, cyl, ref = 6)              # Reference by numeric code
# For haven-labelled variables, use the label name:
# jdummy(, Employment, ref = "Part-Time")
jdummy(, cyl, show = TRUE)          # Show coding scheme
jdummy(, cyl, show = "all")         # Full scheme (for many categories)
jdummy(show = TRUE)

jdummy() # Show all registrations
jdummy(, cyl, remove = TRUE)        # Remove registration
jdummy(NULL)                         # Clear all
