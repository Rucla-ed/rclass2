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
## Part I - Create objects for later use (5 pts)
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
## Part II - Creating loops (12 pts)
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

  
# create loop that prints URL for each dataset
  
url
data_suffix

for (i in 1:length(hd)) {
    
  writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
  #writeLines(str_c(url,hd[i], sep = ""))
  
  #URL for csv data
  writeLines(str_c(url,hd[i],data_suffix, sep = ""))
  
  #URL for data dictionary
  writeLines(str_c(url,hd[i],dict_suffix, sep = ""))
  
  #URL for stata do file w/ variable labels and value labels
  writeLines(str_c(url,hd[i],stata_do_suffix, sep = ""))
}
  #NOTE: try taking one of these urls created by the loop and paste it into your internet browser. should download a file

## -----------------------------------------------------------------------------
## LOOP 2: Download all HD datasets using loop
## -----------------------------------------------------------------------------

# figure out url for one dataset
url #url to data
hd[1] #grabbing first HD data (HD2018)
str_c(url,hd[1],data_suffix, sep = "") #link to HD2018 data

# figure out file-path (including filename) where you will save data
data_dir #object we created for file path to data folder
file.path(data_dir)
file.path(data_dir,hd[1]) #file path plus the first HD data (HD2018)
file.path(data_dir,hd[1],data_suffix) # this wouldn't work
file.path(data_dir,str_c(hd[1],data_suffix, sep = "")) # this would work

# download one year of data
# the url argument is a character string of the url where our data will be downloaded from
# the destfile is the file path to where we want to save our downloaded data
download.file(url = str_c(url,hd[1],data_suffix, sep = ""), destfile = file.path(data_dir,str_c(hd[1],data_suffix, sep = "")))
# check your data folder and you should have HD2018.zip downloaded

# Your loop to download all the HD data in the hd vector should go here. We want ".zip", "_Dict.zip", and "_Stata.zip" files for every HD dataset
# e.g. HD2018.zip, HD2018_Dict.zip, and HD2018_Stata.zip


for (i in 1:length(hd)) { # this takes too long

  writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
  #writeLines(str_c(url,hd[i], sep = ""))
  
  #download csv data
  download.file(url = str_c(url,hd[i],data_suffix, sep = ""), 
                destfile = file.path(data_dir,str_c(hd[i],data_suffix, sep = "")))
    
  #download xls data dictionary
  download.file(url = str_c(url,hd[i],dict_suffix, sep = ""), 
                destfile = file.path(data_dir,str_c(hd[i],dict_suffix, sep = "")))
  
  
  #download stata do file containing variable labels and value labels
  download.file(url = str_c(url,hd[i],stata_do_suffix, sep = ""), 
                destfile = file.path(data_dir,str_c(hd[i],stata_do_suffix, sep = "")))
  
  
}
  

## -----------------------------------------------------------------------------
## LOOP 3: Unzip all downloaded files
## -----------------------------------------------------------------------------

# unzip and read in individual year of data

hd[2]
file.path(data_dir,str_c(hd[2]))

  unzip(zipfile = file.path(data_dir,str_c(hd[2])), unzip = "unzip", exdir = file.path(data_dir))

hd[4]
  

unzip(zipfile = file.path(data_dir,str_c(hd[4])), unzip = "unzip", exdir = file.path(data_dir))

unzip(zipfile = file.path(str_c(hd[1],data_suffix, sep = "")), unzip = "unzip", exdir = file.path(data_dir))

#unzip in a loop
for (i in 1:length(hd)) { # this takes too long
  
  writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
  #writeLines(str_c(url,hd[i], sep = ""))
  
  
  for (z in c("","Dict","_Stata")) {
  
    writeLines(str_c(z))
    unzip(zipfile = file.path(data_dir,str_c(hd[i],z)), unzip = "unzip", exdir = file.path(data_dir))  
  }
  
}


## -----------------------------------------------------------------------------
## LOOP 4: Read in .csv data and make all column names lowercase
## -----------------------------------------------------------------------------

  # read into R
  
  # one year of data
  file.path(data_dir,str_c(hd[1],".csv")) #file path to csv file
  hd2018 <- read_csv(file = file.path(data_dir,str_c(hd[1],".csv"))) #function to read in .csv data
  
  
  # make df name lowercase
  hd[1] #name is uppercase
  dfname <- str_c(str_to_lower(hd[1])) #want to make df names to lowercase
  dfname
  
  # want to change column names to lowercase as well
  names(hd2018)
  names(hd2018) <- hd2018 %>% #change column names to lowercase
    names() %>%
    str_to_lower()
  
  names(hd2018) #what we want
  

#loop to read in csv files and assign them to data frames
for (i in 1:length(hd)) { 
 
  dfname <- str_c(str_to_lower(hd[i])) #change string to lowercase
  #str(dfname)
  
  
  df <- read_csv(file = file.path(data_dir,str_c(hd[i],".csv"))) #read in csv files
  
    
    names(df) <- df %>% #change column names to lowercase
      names() %>%
      str_to_lower()
    
    #print(names(df))
    
    assign(dfname, df) #assign the df dataframe to the dfname lowercase string 

}
  
## -----------------------------------------------------------------------------
## Part III: I got issues (2 pts)
## -----------------------------------------------------------------------------

  
## -----------------------------------------------------------------------------
## Part IV: Wrapping up (1 pt)
## -----------------------------------------------------------------------------


  
## -----------------------------------------------------------------------------
## End
## -----------------------------------------------------------------------------

