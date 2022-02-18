library(tidyverse)

raw_defense <- read_csv("fantasy football data/defense_stats_and_projections.csv")
raw_kicker <- read_csv("fantasy football data/kicker_stats_and_projections.csv")
raw_qb <- read_csv("fantasy football data/qb_stats_and_projections.csv")
raw_rb <- read_csv("fantasy football data/rb_stats_and_projections.csv")
raw_te <- read_csv("fantasy football data/te_stats_and_projections.csv")
raw_wr <- read_csv("fantasy football data/wr_stats_and_projections.csv")


#ggplot(data = filter(raw_kicker, `2020 FPTS` > 0)) +
#  geom_histogram(mapping = aes(x = `2020 FPTS`), fill = "red", binwidth = 3)

# mutating datasets
rb_2019 <- mutate(select(raw_rb, `PLAYER NAME`, `2019 CAR`, `2019 RUSH YDS`, 
                         `2019 RUSH AVG`, `2019 RUSH TD`, `2019 REC`, 
                         `2019 REC YDS`, `2019 REC TDS`, `2019 FPTS`),
                  `2019 ALL YDS` = `2019 RUSH YDS` + `2019 REC YDS`,
                  `2019 ALL TCH` = `2019 REC` + `2019 CAR`,
                  `2019 CAR %` = `2019 CAR` / `2019 REC`,
                  `2019 REC %` = 1 / `2019 CAR %`)

  # fix the long term datasets (repetitive data + bad variable naming)

# plot stuff

# ggplot(rb_2019, aes(x = `2019 FPTS`, y = `2019 REC`)) +
#   geom_jitter(aes(size = `2019 CAR`, color = `PLAYER NAME`), show.legend = FALSE) +
#   geom_smooth(data = filter(rb_2019, `2019 ALL YDS` > 600), se = FALSE)

# ggplot(rb_2019, aes(x = `2019 FPTS`, y = `2019 REC`)) +
#   geom_jitter(aes(size = `2019 CAR`, color = (`2019 REC %` > 0.35)), show.legend = TRUE) +
#   geom_smooth(data = filter(rb_2019, `2019 REC %` >= 0.35), color = "dark cyan", se = FALSE) +
#   geom_smooth(data = filter(rb_2019, `2019 REC %` < 0.35), color = "dark red", se = FALSE) +
#   scale_color_discrete(name = "2019 R:C ratio", labels = c("< 0.35", ">= 0.35", "NA")) +
#   scale_size_continuous(name = "2019 Carries") +
#   xlab("2019 Fantasy Points") +
#   ylab("2019 Receptions")
  
# ggplot(rb_2019, aes(x = `2019 CAR`, y = `2019 REC`)) +
#   geom_jitter(aes(size = `2019 FPTS`, color = (`2019 REC %` > 0.35)), show.legend = TRUE) +
#   geom_smooth(data = filter(rb_2019, `2019 REC %` >= 0.35), color = "dark cyan", se = FALSE) +
#   geom_smooth(data = filter(rb_2019, `2019 REC %` < 0.35), color = "dark red", se = FALSE)
#   scale_color_discrete(name = "2019 R:C ratio", labels = c("< 0.35", ">= 0.35", "NA")) +
#   scale_size_continuous(name = "2019 Carries") +
#   xlab("2019 Fantasy Points") +
#   ylab("2019 Receptions")

  # plotting relationship between rb fantasy points vs receiving vs rushing over time

  
