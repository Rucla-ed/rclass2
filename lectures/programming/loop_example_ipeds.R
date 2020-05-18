################################################################################
##
## [ PROJ ] < Problem set # >
## [ FILE ] < Name of this particular file >
## [ AUTH ] < Your name / GitHub handle >
## [ INIT ] < Date you started the file >
##
################################################################################

## ---------------------------
## libraries
## ---------------------------

library(tidyverse)

## ---------------------------
## directory paths
## ---------------------------
data_dir <- file.path(".", "data_lastname")
data_dir

#Create a sub-folder for data inside your group repository
dir.create(path = "data_lastname", showWarnings = FALSE) # showWarnings = FALSE omits warnings if directory already exists

## -----------------------------------------------------------------------------
## Part I - Create objects for later use
## -----------------------------------------------------------------------------

url <- "https://nces.ed.gov/ipeds/datacenter/data/"
url

# suffix of file names
data_suffix <- ".zip" # suffix for csv data files [not stata data]
dict_suffix <- "_Dict.zip" # data dictionary
stata_do_suffix <- "_Stata.zip" # Stata do file w/ variable labels and value labels


# Read in string that has names of IPEDS files
ipeds <- readLines('./ipeds_file_list.txt')
#str(ipeds)
writeLines(ipeds[1:30])

# Use regular expressions to remove blank lines and lines that start with #

#Blank lines
str_view_all(string = ipeds[18:60], pattern ="^\\s*$") # blank lines
str_detect(string = ipeds[18:30], pattern ="^\\s*$") # blank lines

str_view_all(string = ipeds[18:60], pattern ="^[^(\\s*$)]") # NOT blank lines
str_detect(string = ipeds[18:30], pattern ="^[^(\\s*$)]") # NOT blank lines

length(str_subset(string = ipeds, pattern ="^[^(\\s*$)]"))
length(ipeds)

#remove blank lines
ipeds <- str_subset(string = ipeds, pattern ="^[^(\\s*$)]") # overwrite object to remove blanks
length(ipeds)

# lines that start with # (or do not start with #)

str_view_all(string = ipeds[1:60], pattern ="^#") # starts with "#"
str_detect(string = ipeds[1:60], pattern ="^#") # starts with "#"


str_view_all(string = ipeds[1:60], pattern ="^[^#]") # starts with anything but #
str_detect(string = ipeds[1:60], pattern ="^[^#]") # does not start with "#"

str_subset(string = ipeds, pattern ="^[^#]") # does not start with "#"
length(str_subset(string = ipeds, pattern ="^[^#]")) # does not start with "#"

#Remove lines that start with a "#"
ipeds <- str_subset(string = ipeds, pattern ="^[^#]") # does not start with "#"

ipeds[1:50]

# Create new character vector "hd" that contains names of all "HD" files
str_subset(string = ipeds, pattern = "^HD")
hd <- str_subset(string = ipeds, pattern = "^HD")

hd
hd[2]
hd[1:5]

length(hd)
seq(from = 1, to = length(hd))

## -----------------------------------------------------------------------------
## Part 2 - Creating loops
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## LOOP 1: Create loop that prints URL for each dataset
## -----------------------------------------------------------------------------

# First, just work on creating loop without body and showing the value of object i and hd[i]
for (i in 1:length(hd)) {
  
  writeLines(str_c(i))
  #writeLines(str_c("object i=",i, "; hd[i]=",hd[i], sep = ""))
  #writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
}

