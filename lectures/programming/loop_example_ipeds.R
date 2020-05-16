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
data_dir <- file.path(".", "data")
data_dir

#CREATE SUB-FOLDER FOR DATA
dir.create(path = "data", showWarnings = FALSE) # showWarnings = FALSE omits warnings if directory already exists

## -----------------------------------------------------------------------------
## Part X - Create objects for later use
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
  
  #REMOVE LINES THAT START WITH "#"
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
## CREATE LOOP TO READ IN IPEDS DATA
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


# dowload one dataset using download.file()
  #?download.file


  # figure out url for one dataset
    url
    hd[1]
    str_c(url,hd[1],data_suffix, sep = "")
  
  # figure out file-path (including filename) where you will save data
    data_dir
    file.path(data_dir)
    file.path(data_dir,hd[1])
    file.path(data_dir,hd[1],data_suffix) # this wouldn't work
    file.path(data_dir,str_c(hd[1],data_suffix, sep = "")) # this would work
  
  # download one year of data
    download.file(url = str_c(url,hd[1],data_suffix, sep = ""), destfile = file.path(data_dir,str_c(hd[1],data_suffix, sep = "")))
  
    download.file(url = str_c(url,hd[5],data_suffix, sep = ""), destfile = file.path(data_dir,str_c(hd[5],data_suffix, sep = "")))
  
  
# dowload all datasets using loop


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
  
# unzip and read in individual year of data

  unzip(zipfile = file.path(data_dir,str_c(hd[2])), unzip = "unzip", exdir = file.path(data_dir))
  unzip(zipfile = file.path(data_dir,str_c(hd[5])), unzip = "unzip", exdir = file.path(data_dir))

#unzip in a loop
for (i in 1:length(hd)) { # this takes too long
  
  writeLines(str_c("i=",i, "; hd[",i,"]=",hd[i], sep = ""))
  #writeLines(str_c(url,hd[i], sep = ""))
  
  
  for (z in c("","Dict","_Stata")) {
  
    writeLines(str_c(z))
    unzip(zipfile = file.path(data_dir,str_c(hd[i],z)), unzip = "unzip", exdir = file.path(data_dir))  
  }
  
}

  
# read into R
  
  #one year of data
  file.path(data_dir,str_c(hd[1],".csv"))
  hd2018 <- read_csv(file = file.path(data_dir,str_c(hd[1],".csv")))
  

#loop to read in csv files and assign them to data frames
for (i in 1:length(hd)) { 
 
  dfname <- str_c(str_to_lower(hd[i]))
  #str(dfname)
  
  assign(dfname, read_csv(file = file.path(data_dir,str_c(hd[i],".csv"))))
}
  
glimpse(hd2018)


# rename variables to lowercase and keep selected variables

# this works
dfname <- str_c(str_to_lower(hd[1]))
dfname


assign(dfname, read_csv(file = file.path(data_dir,str_c(hd[1],".csv")))) %>% 
  select(UNITID,LONGITUD,LATITUDE) %>% rename_all(tolower) %>% glimpse()

# HAVING TROUBLE DOING THIS WITHIN A LOOP....

for (i in 1:length(hd)) { 
  
  dfname <- str_c(str_to_lower(hd[i]))
  writeLines(dfname)
  
  #%>% rename_all(tolower) %>% glimpse()
  
  #assign(dfname, read_csv(file = file.path(data_dir,str_c(hd[i],".csv"))))
}



for (d in c("hd2018","hd2017","hd2016")) {

  
  writeLines(str_c("new iteration. d=",d, sep = ""))
  d
  #print(typeof(d))
  #print(d[1:5,1:5])
  
    #rename_all(tolower)
  
}

hd2018 %>% rename_all(tolower) %>% glimpse()
glimpse(hd2018)
## -----------------------------------------------------------------------------
## MODIFY HD 2018 DATASET
## -----------------------------------------------------------------------------

glimpse(hd2018)

# Keep only subset of variables (including latitude and longitude, univerisity url, unitid, ) 

# and keep relatively small subset of institutions (e.g., all UCs and CSUs)

# and then create a character vector from the webaddr field and use that to create loop 
#that reads in the url using xml2/rvest functions we learned last week. and calculate something from url 
#and merge this thing back to the hd dataset

## -----------------------------------------------------------------------------
## ??? START APPLYING REGULAR EXPRESSIONS TO MODIFY HD 2018 DO FILE?
## -----------------------------------------------------------------------------

