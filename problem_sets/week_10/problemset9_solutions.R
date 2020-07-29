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
data_lastname_dir <- file.path(".", "problem_sets", "ps9", "data_lastname")
# data_dir <- file.path(".", "data_lastname")
data_lastname_dir

#Create a sub-folder for data inside your group repository
dir.create(path = data_lastname_dir, showWarnings = FALSE) # showWarnings = FALSE omits warnings if directory already exists

# Data sub-directories
data_dir <- file.path(data_lastname_dir, "data")
data_dir

dict_dir <- file.path(data_lastname_dir, "dictionary")
dict_dir

stata_prog_dir <- file.path(data_lastname_dir, "stata_prog")
stata_prog_dir

## -----------------------------------------------------------------------------
## Part I - Setting up (3 pts)
## -----------------------------------------------------------------------------

url <- "https://nces.ed.gov/ipeds/datacenter/data/"
url

# suffix of file names
data_suffix <- ".zip" # suffix for csv data files [not stata data]
dict_suffix <- "_Dict.zip" # data dictionary
stata_prog_suffix <- "_Stata.zip" # Stata do file w/ variable labels and value labels


# Read in string that has names of IPEDS files
ipeds <- readLines('./problem_sets/ps9/ipeds_file_list.txt')
# ipeds <- readLines('./ipeds_file_list.txt')

#Remove lines that start with a "#"
ipeds <- str_subset(string = ipeds, pattern ="^[^#]") # does not start with "#"

# Create new character vector "hd" that contains names of all "HD" files
str_subset(string = ipeds, pattern = "^HD")
hd <- str_subset(string = ipeds, pattern = "^HD")


## -----------------------------------------------------------------------------
## Part II - Writing function to create directory (7 pts)
## -----------------------------------------------------------------------------

## Step 1: Run given code

# Verify that you've created the `data_lastname_dir` directory
getwd()
list.files()
dir.exists(data_lastname_dir)

# These sub-directories have yet to be created
dir.exists(data_dir)
dir.exists(dict_dir)
dir.exists(stata_prog_dir)

# Note that `dir.exists()` returns a logical, which can be used as a condition
str(dir.exists(data_lastname_dir))


## Step 2: Write if-else statement for creating `data_lastname_dir`
if (dir.exists(data_lastname_dir)) {
  writeLines(str_c("Already have directory: ", data_lastname_dir, sep =""))
} else if (!dir.exists(data_lastname_dir)) {
  writeLines(str_c("Creating new directory: ", data_lastname_dir, sep =""))
  dir.create(data_lastname_dir)
}


## Step 3: Write function that creates directory
make_dir <- function(dir_name) {
  if (dir.exists(dir_name)) {
    writeLines(str_c("Already have directory: ", dir_name, sep =""))
  } else if (!dir.exists(dir_name)) {
    writeLines(str_c("Creating new directory: ", dir_name, sep =""))
    dir.create(dir_name)
  }
}


## Steps 4 & 5: Call function
make_dir(data_lastname_dir)

make_dir(data_dir)
make_dir(dict_dir)
make_dir(stata_prog_dir)


## -----------------------------------------------------------------------------
## Part III - Writing function to download data (9 pts)
## -----------------------------------------------------------------------------

## Step 1: Run given code to download `HD2018.zip`

# Figure out url for one dataset (`HD2018.zip`)
url #url to data
hd[1] #grabbing first HD data (HD2018)
str_c(url, hd[1], data_suffix, sep = "") #link to HD2018 data

data_url <- str_c(url, hd[1], data_suffix, sep = "")  # store in `data_url`

# Figure out file-path (including filename) where you will save data (inside your `data_dir`)
data_dir #object we created for file path to data folder
file.path(data_dir)
file.path(data_dir, hd[1]) #file path plus the first HD data (HD2018)
file.path(data_dir, hd[1], data_suffix) # this wouldn't work
file.path(data_dir, str_c(hd[1], data_suffix, sep = "")) # this would work

data_destfile <- file.path(data_dir, str_c(hd[1], data_suffix, sep = ""))  # store in `data_destfile`

# Use `download.file()` to download the dataset (will download `HD2018.zip` into your `data_dir`)
  # the `url` argument is a character string of the url where our data will be downloaded from
  # the `destfile` is the file path to where we want to save our downloaded data
download.file(url = data_url, destfile = data_destfile)


## Step 2: Download `HD2018_Dict.zip` and `HD2018_Stata.zip`

# Use `download.file()` to download `HD2018_Dict.zip` into `dict_dir`
data_url <- str_c(url, hd[1], dict_suffix, sep = "")
data_destfile <- file.path(dict_dir, str_c(hd[1], dict_suffix, sep = ""))
download.file(url = data_url, destfile = data_destfile)

# Use `download.file()` to download `HD2018_Stata.zip` into `stata_prog_dir`
data_url <- str_c(url, hd[1], stata_prog_suffix, sep = "")
data_destfile <- file.path(stata_prog_dir, str_c(hd[1], stata_prog_suffix, sep = ""))
download.file(url = data_url, destfile = data_destfile)


## Step 3: Write if-else statement for downloading `data_url` into `data_destfile`
if (file.exists(data_destfile)) {
  writeLines(str_c('Already have file: ', data_destfile))
} else {
  writeLines(str_c('Downloading file: ', data_destfile))
  download.file(url = data_url, destfile = data_destfile)
}


## Step 4: Write function that downloads file
download_file <- function(dir_name, file_name, file_suffix) {
  
  data_url <- str_c(url, file_name, file_suffix, sep = "")
  data_destfile <- file.path(dir_name, str_c(file_name, file_suffix, sep = ""))
  
  if (file.exists(data_destfile)) {
    writeLines(str_c('Already have file: ', data_destfile))
  } else {
    writeLines(str_c('Downloading file: ', data_destfile))
    download.file(url = data_url, destfile = data_destfile)
  }
  
}


## Step 5: Test function

# Test function (your function should print that you've already have these 2018 HD files downloaded)
download_file(dir_name = data_dir, file_name = hd[1], file_suffix = data_suffix)  # `HD2018.zip`
download_file(dir_name = dict_dir, file_name = hd[1], file_suffix = dict_suffix)  # `HD2018_Dict.zip`
download_file(dir_name = stata_prog_dir, file_name = hd[1], file_suffix = stata_prog_suffix)  # `HD2018_Stata.zip`

# Call function to download the three 2017 HD files
hd[2]  # HD2017
download_file(dir_name = data_dir, file_name = hd[2], file_suffix = data_suffix)  # `HD2017.zip`
download_file(dir_name = dict_dir, file_name = hd[2], file_suffix = dict_suffix)  # `HD2017_Dict.zip`
download_file(dir_name = stata_prog_dir, file_name = hd[2], file_suffix = stata_prog_suffix)  # `HD2017_Stata.zip`


## Step 6: Write loop and call function inside loop to download rest of the HD data
for (i in 1:length(hd)) {
  print(i)
  
  #download data
  download_file(dir_name = data_dir, file_name = hd[i], file_suffix = data_suffix)
  
  #download data dictionary
  download_file(dir_name = dict_dir, file_name = hd[i], file_suffix = dict_suffix)
  
  #download stata do-file
  download_file(dir_name = stata_prog_dir, file_name = hd[i], file_suffix = stata_prog_suffix)
}


## -----------------------------------------------------------------------------
## Part IV - Labelling dataframe variables and values (10 pts)
## -----------------------------------------------------------------------------

library(labelled)

## Step 1: Unzip all downloaded files
file_suffixes <- c("", "_Dict", "_Stata")
file_dirs <- c(data_dir, dict_dir, stata_prog_dir)

for (i in 1:length(hd)) {
  
  writeLines(str_c("i=", i, "; hd[", i, "]=", hd[i], sep = ""))
  
  for (j in 1:length(file_suffixes)) {
    unzip(zipfile = file.path(file_dirs[j], str_c(hd[i], file_suffixes[j])), unzip = "unzip", exdir = file.path(file_dirs[j]))  
  }
  
}


## Step 2: Write `csv_to_df()` function
csv_to_df <- function(file_name) {
  df <- read_csv(file = file.path(data_dir, str_c(file_name, ".csv"))) # read in csv file
  
  names(df) <- df %>% # change column names to lowercase
    names() %>%
    str_to_lower()
  
  df
}


## Step 3: Write `get_stata_labels()` function
get_stata_labels <- function(file_name) {
  stata <- readLines(file.path(stata_prog_dir, str_c(file_name, ".do")), encoding = 'latin1')
  stata_vars <- str_subset(stata, "^label variable")
  stata_vals <- str_subset(stata, "^\\*?label define")
  
  var_labels <- str_match(stata_vars, 'label variable (\\S+)\\s+"([^"]+)"')
  val_labels <- str_match(stata_vals, '(\\*)?label define label_(\\S+) (\\S+) "([^"]+)"')
  
  # return var_labels and val_labels as a named list (R can't return multiple objects, so need to combine in a list)
  list(var_labels = var_labels, val_labels = val_labels)
}


## Step 4: Write `add_var_labels()` function
add_var_labels <- function(df, var_labels) {
  for (i in 1:nrow(var_labels)) {
    n <- var_labels[[i, 2]]  # col name
    l <- var_labels[[i, 3]]  # col label
    
    var_label(df[[n]]) <- l  # add var label
  }
  
  df
}


## Step 5: Write `add_val_labels()` function
add_val_labels <- function(df, val_labels) {
  for (i in 1:nrow(val_labels)) {
    n <- val_labels[[i, 3]]  # col name
    v <- val_labels[[i, 4]]  # val name
    l <- val_labels[[i, 5]]  # val label
    
    if (is.na(val_labels[[i, 2]])) {
      v <- as.numeric(v)
    }
    
    val_label(df[[n]], v) <- l  # add val label
  }
  
  df
}


## Step 6: Putting it all together
for (i in 1:length(hd)) { 
  file_name <- str_to_lower(hd[i])  # change HD name to lowercase and store in `file_name`
  
  # Read in CSV file data
  df <- csv_to_df(file_name)
  
  # Read in stata file labels
  stata_labels <- get_stata_labels(file_name)
  
  # Add labels
  df <- add_var_labels(df, stata_labels$var_labels)
  df <- add_val_labels(df, stata_labels$val_labels)
  
  assign(file_name, df)  # assign the `df` dataframe to the name stored in `file_name`
}

## -----------------------------------------------------------------------------
## Part V - Wrapping up (1 pt)
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## End
## -----------------------------------------------------------------------------

