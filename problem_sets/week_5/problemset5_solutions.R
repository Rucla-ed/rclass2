################################################################################
##
## [ PROJ ] EDUC 263
## [ FILE ] problemset5_solutions.R
## [ AUTH ] 
## [ INIT ] 27 April 2020
##
################################################################################

## -----------------------------------------------------------------------------
## Part I - Command Line & Organizating Project/Script (2 pts)
## -----------------------------------------------------------------------------

## ---------------------------
## libraries
## ---------------------------
library(tidyverse)
library(rtweet)
library(lubridate)

## ---------------------------
## directory paths
## ---------------------------

data_dir <- file.path('.', 'data')

## -----------------------------------------------------------------------------
## Part II - Working with strings (7 pts)
## -----------------------------------------------------------------------------
news <- c("CNN", "FoxNews", "UniNoticias") #twitter handles
#news

news_df <- search_tweets(paste0("from:", news, collapse = " OR "), n=1000)

#news_df %>%
#  count(screen_name)

#glimpse(news_df)


#Keep certain variables
news_df2 <- news_df %>%
  select(user_id, status_id, created_at, screen_name,
         text, followers_count, friends_count, profile_expanded_url)


# Question about str_length (e.g. length of text) 
news_df2 <- news_df2 %>% unique() %>% 
  mutate(text_len = str_length(text)) 

#typeof(news_df2$text_len)
#class(news_df2$text_len)

# Question about str_c
#news_df2 %>%
#  select(user_id, screen_name, followers_count) %>%
#  count(followers_count)

news_df2 <- news_df2 %>%
  mutate(handle_followers = str_c(" @", screen_name, " has ", followers_count, " followers."),
         handle_friends = str_c(" @", screen_name, " has ", friends_count, " twitter friends."))

#typeof(news_df2$handle_followers)
#class(news_df2$handle_followers)

#typeof(news_df2$handle_friends)
#class(news_df2$handle_friends)


# Question about str_sub  
news_df2 <- news_df2 %>%
  mutate(short_web = str_sub(profile_expanded_url, start = 12)) 

#news_df2 %>%
#  count(short_website)


#save data and commit
#saveRDS(news_df2, file.path(data_dir, "<last_name>_twitter_news.RDS"))

## -----------------------------------------------------------------------------
## Part III - Working with dates (8 pts)
## -----------------------------------------------------------------------------

cola <- c("UCR4COLA", "uci4cola", "ucla4cola", "UCM4COLA", "payusmoreucb",
          "SpreadtheStrike", "UCSF4COLA", "ColaUcsd", "ucsb4cola", "payusmoreucsc", "ucd4cola") #twitter handles
#cola

cola_df <- search_tweets(paste0("from:", cola, collapse = " OR "), n=1000)

#cola_df %>%
#  count(screen_name)


cola_df2 <- cola_df %>%
  select(user_id, status_id, created_at, screen_name,
         text, followers_count, friends_count)

#glimpse(cola_df2)

#typeof(cola_df2$created_at)
#class(cola_df2$created_at)
  

# Question about coverting time vector to character using as.character function
cola_df2 <- cola_df2 %>%
  mutate(dt_chr = as.character(created_at))

#typeof(cola_df2$dt_chr)

# Question about using str_length and str_sub to work with date vars
cola_df2 <- cola_df2 %>%
  mutate(dt_len = str_length(dt_chr),
         date_chr = str_sub(dt_chr, 1,10),
         yr_chr = str_sub(dt_chr, 1,4),
         mth_chr = str_sub(dt_chr, 6,-13),
         day_chr = str_sub(dt_chr, 9,10),
         time_chr = str_sub(dt_chr, 12)
         ) 


#cola_df2 %>%
#  select(dt_chr, dt_len, date_chr,yr_chr, mth_chr, day_chr, time_chr)

# Question about using str_length and str_sub to work with time vars using stringr
cola_df2 <- cola_df2 %>%
  mutate(hr_chr = str_sub(time_chr,1,-7),
         min_chr = str_sub(time_chr,4,-4),
         sec_chr = str_sub(time_chr,-2,-1)) 


#cola_df2 %>%
#  select(time_chr, hr_chr, min_chr, sec_chr)


# Question about using lubridate to get year, month, day, hour, minute
cola_df2 <- cola_df2 %>%
  mutate(yr_num = year(date_chr),
         mth_num = month(date_chr),
         day_num = day(date_chr),
         hr_num = hour(created_at),
         min_num = minute(created_at),
         sec_num = second(created_at))

# Reconstruct date and datetime columns
cola_df2 <- cola_df2 %>%
  mutate(my_date = make_date(yr_num, mth_num, day_num),
         my_datetime = make_datetime(yr_num, mth_num, day_num, hr_num, min_num, sec_num))

class(cola_df2$my_date)
class(cola_df2$my_datetime)

#cola_df2 %>%
#  select(yr_num, mth_num, day_num, hr_num, min_num,sec_num)


#save, commit, merge changes to master branch
#save data and commit, push to github 
#saveRDS(cola_df2, file.path(data_dir, "<last_name>_twitter_cola.RDS"))


## -----------------------------------------------------------------------------
## Part IV: I got issues (2 pts)
## -----------------------------------------------------------------------------
## -----------------------------------------------------------------------------
## Part V: Wrapping up (1 pt)
## -----------------------------------------------------------------------------
## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------