

### I started by creating this package project using this code from a different R Project ###
#usethis::create_package("E:/00 R Projects/JeffsStatTools")

### STEP 1 ###
### These three packages need installed ###
#install.packages(c("devtools", "roxygen2", "usethis"))

###You do not have to run library(devtools) every session — you can call functions with devtools::###
# Example: devtools::document()  - this is cleaner in package development

### STEP 2 ###
# Add the desired custom functions to the R/ Folder
# Copy/Paste all functions into a single R script file with this format:
# Note - the hash tags with the single quote after them, below are part of what needs to be copied
# to the top of each function #

### NOTE That I've changed the code below based upon what Chat told me ###
### Also chat was used to specifically/explicitly mention the necessary packages before each
### function was copied.



  #' Brief title of function
  #'
  #' Longer description of what it does.
  #'
  #' @param x Description of x
  #' @param y Description of y
  #' @return What the function returns
  #' @export
  my_function <- function(x, y) {
    x + y
  }

### STEP 3 ###
#  Run the following in the console to tell the project what other packages these functions rely upon.

#  These are necessary for the jdesc

  usethis::use_package("rlang")
  usethis::use_package("purrr")
  usethis::use_package("dplyr")
  usethis::use_package("knitr")

### STEP 4 ###
# Create License file by running this in the console
  usethis::use_mit_license("Jeff Ackerman")
# that will create a license and license.md file in the directory

### STEP 5 ###
#  Run this in the console
  devtools::document()

### STEP 6 ###
# Run this to check everything
  devtools::check()



#To have my own notes about this build, create a dev folder
dir.create("dev")

#Then tell R to Ignore it when building
usethis::use_build_ignore("dev")


### STEP 6 ###
#install the gitHub to connect the local package to the GitHub website
usethis::use_git()




