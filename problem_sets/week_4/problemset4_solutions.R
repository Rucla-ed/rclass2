################################################################################
##
## [ PROJ ] EDUC 263
## [ FILE ] problemset4_solutions.R
## [ AUTH ] 
## [ INIT ] 19 April 2020
##
################################################################################

# Part I (2 pts)
## ---------------------------
## libraries
## ---------------------------
library(tidyverse)
library(rscorecard)

## ---------------------------
## directory paths
## ---------------------------

data_dir <- file.path('.', 'data')
plot_dir <- file.path('.', 'plots', 'lastname_plots')

## -----------------------------------------------------------------------------
## Part II - College Scorecard API (5 pts)
## -----------------------------------------------------------------------------
sc_key('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')



# Request data

sc_dict('earn', search_col = 'varname')
sc_dict('degree', search_col = 'description')

full_df <- sc_init() %>% 
  sc_filter(preddeg == 3, region == 1:8) %>% 
  sc_select(instnm, control, stabbr, region, tuitionfee_in, tuitionfee_out, md_earn_wne_p10) %>% 
  sc_get()


# Data manipulations

df <- full_df %>% mutate(
  school_type = ifelse(control == 1, 1, 2),
  tuitionfee_diff = tuitionfee_out - tuitionfee_in,
  tuitionfee_diff_pct = (tuitionfee_diff) / tuitionfee_in
)

#saveRDS(df, file.path(data_dir, "<last_name>_rscorecard.RDS"))
## -----------------------------------------------------------------------------
## Part III - ggplot (6 pts)
## -----------------------------------------------------------------------------


# Create scatterplot

# Notes:
# Does graduating from more expensive schools correlate with higher earnings?
# Similar trend between public/private institutions when looking at out-of-state tuition
# But if you can attend in-state public, it is a "better deal" than privates

#png(file.path(plot_dir, 'out_of_state_tuition_earnings.png'))
ggplot(data = df, aes(x = tuitionfee_out, y = md_earn_wne_p10, color = as.factor(school_type))) +
  geom_point() +
  geom_smooth() +
  scale_color_discrete(name = 'School Type', labels = c('Public', 'Private')) +
  xlab('Tuition (Out-of-State)') + ylab('Earnings 10 years after completion')
#dev.off()

#png(file.path(plot_dir,'in_state_tuition_earnings.png'))
ggplot(data = df, aes(x = tuitionfee_in, y = md_earn_wne_p10, color = as.factor(school_type))) +
  geom_point() +
  geom_smooth() +
  scale_color_discrete(name = 'School Type', labels = c('Public', 'Private')) +
  xlab('Tuition (In-State)') + ylab('Earnings 10 years after completion')
#dev.off()

# Create bar plot

# Notes:
# Which states have the greatest percent increase in out-of-state tuition compared to in-state?
# FL, ID, MT, NV, VT, WY, etc. have much more expensive out-of-state tuition
# IL, MN, SD, etc. have pretty similar in-state and out-of-state tuition

#png(file.path(plot_dir,'diff_in_tuition_by_state.png'))
df %>%
  filter(school_type == 1) %>%
  group_by(stabbr) %>%
  summarise(m = mean(tuitionfee_diff_pct, na.rm = TRUE)) %>%
  ggplot(aes(x = stabbr, y = m)) +
  geom_col() +
  xlab('State') + ylab('Percent increase for out-of-state vs. in-state tuition') +
  scale_y_continuous(labels = scales::percent)
#dev.off()

## -----------------------------------------------------------------------------
## Part IV - Pull request (4 pts)
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Part V - I got issues (2 pts)
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## Part VI - Wrapping up (1 pt)
## -----------------------------------------------------------------------------

## -----------------------------------------------------------------------------
## END SCRIPT
## -----------------------------------------------------------------------------
