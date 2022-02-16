library(xml2)
library(rvest)
library(dplyr)

superflex_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=OFF&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
kicker_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=K&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
#defense_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=DST&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
defense_page <- "fantasy football data/defense.html"

#pos=***&yr=2021&wk=***&key=b6406b7aea3872d5bb677f064673c57f

#superflex <- read_html(superflex_page)
#kicker <- read_html(kicker_page)
defense <- read_html(defense_page)

team <- defense %>%
  html_nodes("body") %>%
  xml_find_all("//span[contains(@class, 'hidden-xs')]") %>%
  html_text()

table <- defense %>%
  html_nodes("body") %>%
  xml_find_all("//tbody[@aria-live = 'polite']")

size_rows <- length(html_children(table))
size_values <- length(html_children(html_children(table)))

teams <- c()
points <- c()
sacks <- c()
ints <- c()
safeties <- c()
fumble_recoveries <- c()
blocks <- c()
TDs <- c()
PAs <- c()
pass_yds_per_game <- c()
russ_yds_per_game <- c()
tot_yds_per_game <- c()

for (values in 1:size_values){
  if ((values %% (size_values / size_rows)) + 1 == 1){
    append()
  }
  
}




