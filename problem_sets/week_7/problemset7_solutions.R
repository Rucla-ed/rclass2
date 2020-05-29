library(tidyverse)
library(stringr)
library(rvest)

## -----------------------------------------------------------------------------
## Part I: Scraping and parsing Coronavirus data (8 pts)
## -----------------------------------------------------------------------------

# Use `read_html()` to scrape the HTML from `https://corona.help/` and save it to a variable called `corona`
corona <- read_html("https://corona.help/")

# Use `html_nodes()` to select all rows in the "Total by country" table and save them in a variable called `corona_rows`
corona_rows <- corona %>% html_node('table') %>% html_nodes('tr')
corona_rows <- corona %>% html_nodes('table tr')

# Use `as.character()` to convert `corona_rows` to raw HTML. Save all but the header row to a variable called `rows`.
rows <- as.character(corona_rows)[-c(1)]

# Use `writeLines()` and `head()` to preview the first few rows of the data
writeLines(head(rows))

# Write a regular expression that will match the first two columns of the table (country name & number infected)
# Use capturing groups to be able to isolate these 2 pieces of info from between the HTML tags
# Use `str_match()` to find the matches and store the result in a variable called `corona_data`
corona_data <- str_match(string = rows, pattern = '<div .+>([^<]+)</div>[\\s\\S]+?<td class="text-warning">([\\d,]+)</td>')

# The 1st col of `corona_data` should be the full match, the 2nd is the country name, and the 3rd is the number infected
# Create 2 objects -- `country_name` and `num_infected` -- that will be character vectors containing the country name and number infected, respectively
# (hint: assign the respective column of the `corona_data` matrix to each object)
country_name <- corona_data[,2]
num_infected <- corona_data[,3]

# Use `str_replace_all()` to replace all the `,` in `num_infected` with an empty string
# Use `as.numeric()` to convert the vector to numeric
# Then save the result back to `num_infected`
num_infected <- as.numeric(str_replace_all(string = num_infected, pattern = ',', replacement = ''))

# Use `data.frame()` to create a dataframe from the 2 vectors
corona_df <- data.frame(
  country_name = country_name,
  num_infected = num_infected,
  stringsAsFactors = FALSE
)

## -----------------------------------------------------------------------------
## Part II: Plotting Coronavirus data (10 pts)
## -----------------------------------------------------------------------------

# Use `head()` to filter for the first 5 rows of `corona_df` 
# Use `geom_col()` from ggplot to create a barplot with `country_name` on the x-axis and `num_infected` on the y-axis
# Save plot as `corona_top5.png` in the `plots/` directory

# png('plots/corona_top5.png')
corona_df %>%
  head(5) %>%
  ggplot(aes(x = country_name, y = num_infected)) +
  geom_col() +
  xlab('Country') + ylab('Number Infected')
# dev.off()

# Create the same barplot, but this time keep only countries whose name either starts with a `v` or ends with a `i` (not case-sensitive)
# Use `filter()` and `str_detect()` to help subset your dataframe
# Save plot as `corona_subset.png` in the `plots/` directory

# png('plots/corona_subset.png')
corona_df %>%
  filter(str_detect(string = country_name, pattern = '^[Vv]|[Ii]$')) %>%
  ggplot(aes(x = country_name, y = num_infected)) +
  geom_col() +
  xlab('Country') + ylab('Number Infected')
# dev.off()

## -----------------------------------------------------------------------------
## Part III: Wrapping up (2 pts)
## -----------------------------------------------------------------------------
