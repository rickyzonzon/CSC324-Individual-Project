library(tidyverse)

# started tracking targets in: 1992
# started tracking fumbles lost in: 1994

clean <- function(dat, year, b92 = FALSE, b94 = FALSE){
  new_dat <- select(dat, -c(...1,
                            PassingYds, 
                            PassingAtt, 
                            RushingYds,
                            RushingAtt,
                            ReceivingYds))
  new_dat <- new_dat %>%
    relocate(PassTD = PassingTD, .after = Yds...10) %>%
    relocate(RushTD = RushingTD, .after = Yds...13) %>%
    { if (b92)
        relocate(., RecTD = ReceivingTD, .after = Yds...15) %>%
        rename(., Team = Tm,
               Games = G,
               GmStart = GS,
               PassCmp = Cmp,
               PassAtt = Att...9,
               PassYds = Yds...10,
               RushAtt = Att...12,
               RushYds = Yds...13,
               RecYds = Yds...15,
               YPR = `Y/R`,
               FPTS = FantasyPoints) %>%
        mutate(., Tgt = NA, .after = RushTD)
      else
        relocate(., RecTD = ReceivingTD, .after = Yds...16) %>%
        rename(., Team = Tm,
               Games = G,
               GmStart = GS,
               PassCmp = Cmp,
               PassAtt = Att...9,
               PassYds = Yds...10,
               RushAtt = Att...12,
               RushYds = Yds...13,
               RecYds = Yds...16,
               YPR = `Y/R`,
               FPTS = FantasyPoints) } %>%
    { if (b94)
        mutate(., FumblesLost = Fumbles, Fumbles = NULL) 
      else 
        mutate(., Fumbles = NULL)} %>%
    mutate(Year = year, .after = Age)
  
  return(new_dat)
}

clean_and_read <- function(x){
  a <- sub("\\.csv$", "", x)
  year <- parse_integer(a)
  clean(read_csv(paste0("fantasy football data/long-term data + weekly data/yearly/", x)),
                    year = year, b92 = (year < 1992), b94 = (year < 1994))
}

files <- list.files("fantasy football data/long-term data + weekly data/yearly", "*.csv")
yearly <- files %>%
  lapply(clean_and_read)

all <- yearly %>%
  reduce(add_row)
