library(tidyverse)

# started tracking targets in: 1992
# started tracking fumbles lost in: 1994

clean <- function(dat, b92 = FALSE){
  new_dat <- select(dat, -c(...1,
                            PassingYds, 
                            PassingAtt, 
                            RushingYds,
                            RushingAtt,
                            ReceivingYds))
  new_dat <- new_dat %>%
    relocate(PassTD = PassingTD, .after = Yds...10) %>%
    relocate(RushTD = RushingTD, .after = Yds...13) %>%
    { if(b92) 
        relocate(., RecTD = ReceivingTD, .after = Yds...15) 
      else 
        relocate(., RecTD = ReceivingTD, .after = Yds...16) } %>%
    { if(b92)
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
                FPTS = FantasyPoints)
      else
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
                FPTS = FantasyPoints) 
    }
  
  return(new_dat)
}

clean_and_read <- function(x){
  a <- sub("\\.csv$", "", x)
  clean(read_csv(paste0("fantasy football data/long-term data + weekly data/yearly/", x)),
                    b92 = (parse_integer(a) < 1992))
}

files <- list.files("fantasy football data/long-term data + weekly data/yearly", "*.csv")
yearly <- lapply(files, clean_and_read)

