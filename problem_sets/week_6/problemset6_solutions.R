################################################################################
##
## [ PROJ ] EDUC 263
## [ FILE ] problemset6_solutions.R
## [ AUTH ] 
## [ INIT ] 1 May 2020
##
################################################################################

## ---------------------------
## libraries
## ---------------------------
library(tidyverse)
library(rtweet)

## ---------------------------
## directory paths
## ---------------------------


data_dir <- file.path('.', 'data')

## -----------------------------------------------------------------------------
## Part I: Fetching twitter data (2 pts)
## -----------------------------------------------------------------------------

cola <- c("UCR4COLA", "uci4cola", "ucla4cola", "UCM4COLA", "payusmoreucb",
          "SpreadtheStrike", "UCSF4COLA", "ColaUcsd", "ucsb4cola", "payusmoreucsc", "ucd4cola") #twitter handles
cola

cola_df <- search_tweets(str_c("from:", cola, collapse = " OR "), n = 500)

saveRDS(object = cola_df, file = file.path(data_dir, "jaquette_twitter_cola.RDS"))

# cola_df <- readRDS(file =  file.path(data_dir, "jaquette_twitter_cola.RDS"), refhook = NULL)

#create df with subset of variables
cola_df2 <- cola_df %>% 
  select(user_id, screen_name, created_at, text)

#create character vector containing tweet text
str(cola_df2$text)
tweet_text <- cola_df2$text
tweet_text

#create character vector containing string of retweet text
# retweet_text <- cola_df2$retweet_text
# retweet_text


## -----------------------------------------------------------------------------
## Part II: Escaping special characters in plain old strings (i.e., no regular expressions yet) (3 pts)
## -----------------------------------------------------------------------------

#?"'" # help file for special characters



#newline
newline <- "before newline\nafter newline"
print(newline)
writeLines(newline)

#tab
tab <- "before tab\tafter tab"
print(tab)
writeLines(tab)

#backslash
backslash <- "insert backslash \\ into string"
print(backslash)
writeLines(backslash)

#single quote
quote1 <- "insert single quote \' into string"
print(quote1)
writeLines(quote1)

#double quote
quote2  <- "insert double quote \" into string"
print(quote2)
writeLines(quote2)


#2. With respect to the previous question, explain in general why the output created by the `print()` function differs from the output created by the `writeLines()` function.

#`writeLines()` prints the string after special characters have been parsed/evaluated, excludes the quotes at the beginning and end of the string (and also prints each element as a separate line for vecctors with more than one element. By contrast, `print()` prints the string object as it is stored, without parsing/evaluating special characters and without omitted quotes at the beginning and end of the string.

# This may be helpful:

x <- c("element 1 of \" character vector","element 2 of \\ character vector") # create simple character vector object
x # this creates same output we get from print(x)
print(x)


writeLines(x) # similar output to cat(x) except prints a separate line for each element of vector

## -----------------------------------------------------------------------------
## Part III: Regular expressions (7 pts)
## -----------------------------------------------------------------------------

################## MATCH CHARACTERS

#1. Run the following code to create the character vector `text1`. Print `text1` using the `print()` function and using the `writeLines()` function

text1 <- c("abc ABC 123\t.!?\\(){}\n","abcde","aaa","bacad",".a.aa.aaa","bacad","abbaab")
text1
print(text1)
writeLines(text1)


#2. For this question, the pattern to match is matches to the letter `"a"` (as in `pattern = regex("a")`).

# text1 character vector
str_view_all(string = text1, pattern = regex("a"))

# character vector containing tweet text
str_view(string = tweet_text[1:5], pattern = regex("a"))

# create variable has_match
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(
    has_match = str_detect(string = text, pattern = regex("a"))
  ) %>% count(has_match)



#3. Using the `typeof()`, `class()`, `str()`, and `attributes()` functions to the object `regex("a")` (no need to assign a new object)

typeof(regex("a"))
class(regex("a"))
str(regex("a"))
attributes(regex("a"))


#4. Separately for each of the following matches, repeat questions (A) (B) and (C) from the earlier question. Match to the following special characters and characters:

##### `.` (e.g., find the first literal period `"."` in each element of the character vector `tweet_txt`)

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\."))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\."))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\."))) %>% count(has_match)


##### `\`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\\\"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\\\"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\\\"))) %>% count(has_match)

##### A new line, special character `\n`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\n"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\n"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\n"))) %>% count(has_match)


##### whitespace, special character `\s`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\s"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\s"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\s"))) %>% count(has_match)


##### whitespace, using POSIX special character `[:space:]`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("[[:space:]]"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("[[:space:]]"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("[[:space:]]"))) %>% count(has_match)

#```
##### A digit (e.g., 3), special character `\d`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\d"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\d"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\d"))) %>% count(has_match)

##### A digit (e.g., 3), POSIX special character `[:digit:]`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("[:digit:]"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("[:digit:]"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("[:digit:]"))) %>% count(has_match)

##### word boundaries, special character `\b`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("\\b"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("\\b"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("\\b"))) %>% count(has_match)

##### `.` , referring to any character except newline as opposed to a literal `.`

# object = text1, character vector
str_view_all(string = text1, pattern = regex("."))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("."))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("."))) %>% count(has_match)


################## ANCHORS

#1. repeat questions (A) (B) and (C) from the earlier question, for the following matches:
  
##### String starts with a lowercase letter


# object = text1, character vector
str_view_all(string = text1, pattern = regex("^[[:lower:]]"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("^[[:lower:]]"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("^[[:lower:]]"))) %>% count(has_match)

##### String ends with punctuation

# object = text1, character vector
str_view_all(string = text1, pattern = regex("[[:punct:]]$"))

# object = tweet_text, character vector
str_view(string = tweet_text[1:5], pattern = regex("[[:punct:]]$"))

# create/count variable has_match,using data frame cola_df2
cola_df2 %>% select(screen_name,created_at,text) %>%
  mutate(has_match = str_detect(string = text, pattern = regex("[[:punct:]]$"))) %>% count(has_match)




################ QUANTIFIERS

text2 <- c(".a.aa.aaa","abbaab")
text2


#0 or 1 "a"
str_view_all(string = text2, pattern = regex("a?"))
str_count(string = text2, pattern = regex("a?"))

#0 or more
str_view_all(string = text2, pattern = regex("a*"))
str_count(string = text2, pattern = regex("a*"))

#1 or more
str_view_all(string = text2, pattern = regex("a+"))
str_count(string = text2, pattern = regex("a+"))

#exacly 2 in a row
str_view_all(string = text2, pattern = regex("a{2}"))
str_count(string = text2, pattern = regex("a{2}"))

#between 2 and 3 `"a"` in a row
str_view_all(string = text2, pattern = regex("a{2,3}"))
str_count(string = text2, pattern = regex("a{2,3}"))


############### ALTERNATES

#1. Create the character vector `text3` as below. Use `str_view_all()` to show matches to the following patterns: 

text3 <- "abcde"


#2. Use `str_view_all()` to show matches to the following patterns: 

# match to `"ab"` OR `"d`"
str_view_all(string = text3, pattern = regex("ab|d"))

# match to one of the following characters: `"abe"` 

str_view_all(string = text3, pattern = regex("[abe]"))
             
# match to anything but one of the following characters: `"abe"` 
str_view_all(string = text3, pattern = regex("[^abe]"))


#3. Using the first 10 elements of character vector `tweet_text` use `str_view_all()` to show matches to the following patterns          

#a hashtag "`#`" or a handle "`@`"
str_view_all(string = tweet_text[1:10], pattern = regex("#|@"))

#the text `"https"` OR a handle `"@"`
str_view_all(string = tweet_text[1:10], pattern = regex("https|@"))

#any character that is not a vowel
str_view_all(string = tweet_text[1:10], pattern = regex("[^AEIOUaeiou]"))

# PUTTING IT ALL TOGETHER

text4 <- c("Los Angeles, CA 90024", "New York, NY 10001", "12345 Main St", "Pier 39")

#match states
str_view(string = text4, pattern = regex("[A-Z]{2}"))

#match zip codes
str_view(string = text4, pattern = regex("\\d{5}$"))

#match at least 2 of RSTLNE in a row
str_view(string = text4, pattern = regex("[RSTLNErstlne]{2,}"))

## -----------------------------------------------------------------------------
## Part IV: Groups, backreferences, and other `stringr` functions (5 pts)
## -----------------------------------------------------------------------------

#test/create citystatezip_regex
citystatezip_regex <- regex("([^,]+), ([A-Z]{2}) (\\d{5})")
str_view(string = text4, pattern = citystatezip_regex)

#filter test4 using citystatezip_regex and save as locations
locations <- str_subset(string = text4, pattern = citystatezip_regex)

#extract city, state, and zip code
matches <- str_match(string = locations, pattern = citystatezip_regex)
cities <- matches[,2]
states <- matches[,3]
zip_codes <- matches[,4]

#backreferences using str_replace()
str_replace(string = locations, pattern = citystatezip_regex, replacement = "\\1 has a zip code \\3 and is in the state \\2")

#save, commit, merge changes to master branch
#save data and commit, push to github 
#saveRDS(cola_df2, file.path(data_dir, "<last_name>_twitter_cola.RDS"))

## -----------------------------------------------------------------------------
## Part V: I got issues (2 pts)
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Part VI: Wrapping up (1 pt)
## -----------------------------------------------------------------------------


## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------