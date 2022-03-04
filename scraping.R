####################### SCRAPPED #########################

# library(xml2)
# library(rvest)
# library(dplyr)
# 
# #superflex_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=OFF&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
# #kicker_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=K&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
# #defense_page <- "https://www.footballdb.com/fantasy-football/index.html?pos=DST&yr=2021&wk=all&key=b6406b7aea3872d5bb677f064673c57f"
# defense_page <- "fantasy football data/defense.html"
# 
# #pos=***&yr=2021&wk=***&key=b6406b7aea3872d5bb677f064673c57f
# 
# #superflex <- read_html(superflex_page)
# #kicker <- read_html(kicker_page)
# defense <- read_html(defense_page)
# 
# table <- function(html){
#   html %>%
#     html_nodes("body") %>%
#     xml_find_all("//tbody[@aria-live = 'polite']") %>%
#     return()
# }
# 
# rows <- html_children(table(defense))
# 
# values <- function(row){
#   return(html_children(row))
# }
# 
# def_data <- tibble(
#   teams = c("a"),
#   points = c(1),
#   sacks = c(1),
#   ints = c(1),
#   safeties = c(1),
#   fumble_recoveries = c(1),
#   blocks = c(1),
#   TDs = c(1),
#   PA = c(1),
#   pass_yds_per_game = c(1),
#   russ_yds_per_game = c(1),
#   tot_yds_per_game = c(1)
# )
# 
# for (row in 1:length(rows)){
#   
#   team <- html_text(html_element(html_children(rows), xpath = "//span[@class = 'hidden-xs']")[row])
#   new_row <- c()
#   
#   for (value in 3:length(values(rows[row]))){
#     new_row <- c(new_row, readr::parse_double(html_text(html_children(rows[row])[value])))
#   }
#   
#   def_data <- add_row(def_data, 
#                       teams = team, 
#                       points = new_row[1],
#                       sacks = new_row[2],
#                       ints = new_row[3],
#                       safeties = new_row[4],
#                       fumble_recoveries = new_row[5],
#                       blocks = new_row[6],
#                       TDs = new_row[7],
#                       PA = new_row[8],
#                       pass_yds_per_game = new_row[9],
#                       russ_yds_per_game = new_row[10],
#                       tot_yds_per_game = new_row[11])
# }
# 
