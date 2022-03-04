library(tidyverse)
library(fmsb)

is.nan.df <- function(x)
  do.call(cbind, lapply(x, is.nan))

is.infinite.df <- function(x)
  do.call(cbind, lapply(x, is.infinite))

radardata <- all %>%
  select(Player, Pos, Year, PassCmp, PassAtt, PassYds, PassTD, Int, RushAtt, RushYds, 
         RushTD, Tgt, Rec, RecYds, RecTD, FumblesLost) %>%
  mutate(CmpPct = PassCmp / PassAtt,
         .after = PassAtt) %>%
  mutate(RushAvg = ifelse(RushAtt == 0, RushYds, RushYds / RushAtt),
         .after = RushAtt) %>%
  mutate(RecPct = ifelse(Tgt == 0 | is.na(Tgt), 0, Rec / Tgt),
         .after = Rec) %>%
  mutate(PassAtt = NULL,
         Tgt = NULL) %>%
  relocate(FumblesLost, .after = RushTD) %>%
  replace(is.nan.df(.), 0)

# Pass%, PassCmp, PassYds, PassTD, Int
# RushAtt, RushYds, YPA, RushTD, FumblesLost
# Rec%, Rec, RecYds, RecTD 
# 
# playerdata <- select(filter(radardata, Player == "Cam Newton", Year == 2011), -c(Player, Pos, Year))
# 
# posdata <- select(filter(radardata, Pos == "QB"), -c(Player, Pos, Year))
# 
# data <- rbind(c(max(posdata$PassCmp), max(posdata$CmpPct),
#                 max(posdata$PassYds), max(posdata$PassTD), min(posdata$Int),
#                 max(posdata$RushAtt), max(posdata$RushAvg), max(posdata$RushYds),
#                 max(posdata$RushTD), min(posdata$FumblesLost), max(posdata$Rec),
#                 max(posdata$RecPct), max(posdata$RecYds), max(posdata$RecTD)),
#               c(min(posdata$PassCmp), min(posdata$CmpPct),
#                 min(posdata$PassYds), min(posdata$PassTD), max(posdata$Int),
#                 min(posdata$RushAtt), min(posdata$RushAvg), min(posdata$RushYds),
#                 min(posdata$RushTD), max(posdata$FumblesLost), min(posdata$Rec),
#                 min(posdata$RecPct), min(posdata$RecYds), min(posdata$RecTD)),
#               playerdata)
# 
# radarchart(data, pcol = rgb(0.2,0.5,0.5,0.8), pfcol = rgb(0.2,0.5,0.5,0.8),
#            plwd = 3.5, cglcol = "grey", cglty = 1, cglwd = 0.8, vlcex = 0.8)


