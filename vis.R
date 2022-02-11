library(tidyverse)

raw_defense <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/defense_stats_and_projections.csv", col_names = TRUE)
raw_kicker <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/kicker_stats_and_projections.csv", col_names = TRUE)
raw_qb <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/qb_stats_and_projections.csv", col_names = TRUE)
raw_rb <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/rb_stats_and_projections.csv", col_names = TRUE)
raw_te <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/te_stats_and_projections.csv", col_names = TRUE)
raw_wr <- read_csv("~/Grinnell Classes/Junior Spring/Software Development/Individual Project/CSC324-Individual-Project/fantasy football data/wr_stats_and_projections.csv", col_names = TRUE)

ggplot(data = filter(raw_kicker, `2020 FPTS` > 0)) +
  geom_histogram(mapping = aes(x = `2020 FPTS`), fill = "red", binwidth = 3)

str(raw_kicker)
