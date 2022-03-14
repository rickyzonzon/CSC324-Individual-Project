# Project Documentation
## Purpose
To provide an interactive data visualization tool for analyzing relationships between the seasonal fantasy statistics of NFL players. I chose a scatterplots and radar charts to visualize my data. I chose these graphs because they were the best to represent several continous variables at once, and most of the variables in this dataset are continous. This visualization tool is both a source for discovery and for fun. As I describe in more depth in the Audience section, the tool can be used to find interesting patterns/relationships in NFL player data, which is fun for fans of the NFL who want to learn more and informative/helpful for avid fantasy football players. A user can search for specific relationships as well as browse or explore the data. The radar chart is more helpful to search for and identify or compare specific players, while the scatterplot is more useful for browsing/exploring to find outliers or summarize patterns for larger groups. The scatterplot visualization can be customized, manipulated, and reduced. The data can be mapped by the x, y, color, size, and alpha axes. A smoothing line can be added as well, with custom "wiggliness" (span) and an optional confidence interval. Data can be selected by brushing (clicking and dragging to create an area) to view more information about the points within the brush. The data can also be filtered by player(s), position(s), team(s), year(s), or a custom filter that the user can write themselves (<stat> + <stat> >= ?, etc.). The radar chart is less customizable, as it is simply encoded by color (the user can select between one and three players to show display once).
## Data
### Description
Each observation/value represents the stats/stat of a single player in a single season.<br/>
Player: The player's name.<br/>
Team: The team the player played on, or the number of teams the player played on that season (if > 1).<br/>
Pos: The position of the player.<br/>
Age: The age of the player.<br/>
Year: The year of that season.<br/>
Games: The number of games the player played in.<br/>
GmStart: The number of games the player started in.<br/>
PassCmp: The number of passes completed by the player.<br/>
PassAtt: The number of passes thrown by the player.<br/>
CmpPct: The percentage of completed passes out of total passes thrown.<br/>
PassYds: The number of passing yards gained by the player.<br/>
PassTD: The number of passing touchdowns scored by the player.<br/>
Int: The number of interceptions thrown by the player.<br/>
RushAtt: The number of rushing attempts by the player.<br/>
RushYds: The number of rushing yards gained by the player.<br/>
RushAvg: The average number of rushing yards gained per rushing attempt.<br/>
RushTD: The number of rushing touchdowns scored by the player.<br/>
Tgt: The number of targets (balls thrown to) the player had. [Note: the NFL only began tracking targets in 1992]<br/>
Rec: The number of receptions (balls caught) the player had.<br/>
RecPct: The percentages of receptions out of total targets.<br/>
RecYds: The number of receiving yards gained by the player.<br/>
RecTD: The number of receiving touchdowns scored by the player.<br/>
YPR: The number of receiving yards gained per reception by the player.<br/>
FumblesLost: The number of fumbles lost by the player.<br/>
FPTS: The number of fantasy points earned by the player.<br/>
### Tidying
I had a significant amount of tidying to do to combine and clean up the data (using longterm-data-cleaning.R). First, there were multiple sets of reduntant columns, so I removed removed the repetitive variables. Second, multiple sets of columns were named identically, so I had to figure out what each column was and rename them appropriately. I also renamed some other variables so they were shorter and easier to manage. I realized that a certain stat, Tgt (targets), only starting being tracked in 1992 and Fumbles (total) only started being tracked in 1994. I had to add Tgt to all the data before 1992, and I decided to remove the Fumbles stat and keep the FumblesLost stat. Next, I cleaned up all the NaN, Inf, and -Inf values from the data, as well as some confusing values in the Team column. Finally, I reordered the columns in a way that made more logical sense (grouping related statistics together). As noted in the Future Improvements section, I also transformed the data and added a few columns like CmpPct, RushAvg, and RecPct. The data was separated by year into .csv files (from 1970 to 2019), so I had to combine these into a single data frame by making a column for the year.
### Source
This data was sourced from [Fantasy Football Data Pros](https://www.fantasyfootballdatapros.com/csv_files).
## Audience
Anyone with at least a rudimentary understanding of the American football and the NFL should be able to use this application and understand the visualizations. Fantasy football players in particular stand to benefit from the use of this tool. If they are looking to improve their performance in fantasy leagues, they can use this tool to find statistical relationships and apply that knowledge in their fantasy-related decisions.
## Questions and Insights
This tool was designed to be used to answer almost any question about statistical relations in fantasy football. However, in its current stage, it lacks the ability to separate or group plots by categorical variables, which is what faceting would provide. For example, the question, "Is a quarterback's success inversely related to a running back's success?" would require the ability to plot a graph with teams on one axis, fantasy points on another axis, faceted by positions. Though, one might answer this question by manually creating multiple graphs with filters. Also, questions relating to team statistics (like win/loss record) and defensive statistics cannot be answered simply because the data is not included. Otherwise, if you know what variables to plot (which can be difficult sometimes), it is an effective tool to answer questions. For example, the question, "Do quarterbacks who can run perform better in fantasy?". I found that quarterbacks who also run can be very successful if they run at high volumes, but being able to pass well is still much more important. Another question, "Do running backs who can catch perform better in fantasy?" can yield some interesting results. I found that, generally, running backs who have that extra element to their game will be better in fantasy; however, the most important factor for a running back is volume (between both targets and rushing attempts). Other interesting questions include, "Are wide receivers who run deeper routes more successful?" and "Are wide receivers who catch more efficiently more successful?" I found that, according to the models, the best receiviers earn around 9-11 yards per target (however, this does not subtract yards after catch) -- too high and that likely means they don't get enough volume, too low and they don't have enough scoring potential. In terms of the second question, I found that the ideal catch rate is around 60-70%, for reasons similar to the previous answer.
## Future Improvements
### Data
The data could be significantly improved by adding deeper statistics. At the moment, most of the variables are basic, surface-level player stats. Using data transformations, I created some other interesting stats like completion percentage, average rush yards per attempt, and receiving percentage. However, there are some stats, like average depth of target, that cannot be derived from the existing dataset, which may provide a deeper level of analysis. It should also be noted that the data does not track defensive statistics or kicker statistics (both of which are fantasy-football-relevant position groups). Also, I didn't have the time to incorporate the weekly data (from 1999 to 2019), which could have led to even more interesting time-related analysis.
### Application
The application is mostly complete in my eyes, but there are a few minor improvements I would like to make. First, I would like to finish the custom-axis functionality for all avaiable axes. Second, I would like to be able to allow the user to facet the scatterplot and edit the smoothing line/add more smoothing lines. I would also like to create a dynamic UI for the custom filters, rather than having only 5 at a time.
## Sources
https://www.fantasyfootballdatapros.com/csv_files<br/>
https://www.mastering-shiny.org/<br/>
https://shiny.rstudio.com/<br/>
https://www.rdocumentation.org/<br/>
https://www.r-lang.com/<br/>
http://shinyapps.dreamrs.fr/shinyWidgets/<br/>
Rahul - https://stackoverflow.com/questions/12193779/how-to-write-trycatch-in-r<br/>
Harlan - https://stackoverflow.com/questions/1743698/evaluate-expression-given-as-a-string<br/>
spotnag - https://stackoverflow.com/questions/41241107/span-argument-not-work-working-with-loess-fit-in-ggplot2<br/>
Charlotte Sirot - https://stackoverflow.com/questions/36080529/r-shinydashboard-customize-box-status-color<br/>
Benjamin - https://stackoverflow.com/questions/35025145/background-color-of-tabs-in-shiny-tabpanel<br/>
Bambs - https://stackoverflow.com/questions/41061679/hide-and-show-widget-in-r-shiny<br/>
Hong Ooi - https://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame<br/>
Yihui Xie - https://stackoverflow.com/questions/24175997/force-no-default-selection-in-selectinput<br/>
takje - https://stackoverflow.com/questions/59320025/what-is-the-difference-between-textoutput-and-verbatimtextoutput-in-r-shiny
