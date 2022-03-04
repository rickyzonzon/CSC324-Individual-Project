library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyWidgets)
library(tidyverse)
library(fmsb)

ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = strong("Fvntvsy Footbvll Vis")),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dvshbovrd", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Stvt Wizvrd", tabName = "wizard", icon = icon("hat-wizard")) #icon("th")
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidPage(theme = shinytheme("lumen"),
                        # dashboard
                          # examples
                            # radar chart!
                            # fact wizard
                            # image wizard
                        
                        # selectInput("dataset", label = "Dataset", choices = 1970:2019),
                        # verbatimTextOutput("summary"),
                        # tableOutput("table"),
                        # sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
                        # "then x times 5 is",
                        # textOutput("product")
              )
      ),
      
      tabItem(tabName = "wizard",
              fluidRow(
                tags$style(HTML("
                  .box.box-solid.box-primary>.box-header{
                    color:#fff;
                    background:#666666
                  }
                  
                  .box.box-solid.box-primary{
                    border:0px;
                  }
                  
                  .box.box-danger{border-top-color:#666666;}

                  .nav-tabs {background: #666666;}
                  .nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a{
                    background-color: #fff;
                    border-color: #fff;                                                      
                  }
                  .nav-tabs-custom .nav-tabs li a{color:#fff;}
                  .nav-tabs-custom .nav-tabs li.active {border-top-color:#666666;}
                                ")),
                
                box(title = span("Plot", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 8, height = "50%",
                    dropdownButton(
                      h4("Plot Options"),
                      
                      selectInput("plot_x", label = "X-Axis", 
                                  choices = colnames(select(all, -c(Player, Team, Pos, Year)))),
                      
                      selectInput("plot_y", label = "Y-Axis", 
                                  choices = colnames(select(all, -c(Player, Team, Pos, Year)))),

                      #selectInput("color", choices = colnames(all)),
                        #color picker?
                        #expression 
                      #selectInput("size"),
                        #expression
                      #switchInput("smooth_line"),
                        #expression optional
                      
                      circle = TRUE, status = "primary", size = "sm",
                      icon = icon("gear"), width = "300px",
                      
                      tooltip = tooltipOptions(title = "Click to see inputs !")
                    ),
                    plotOutput("wizard_plot")
                    # actionButton("download", label = "Download Plot")
                ),
                tabBox(title = span("Filters", style = "color:white;"), id = "filters", 
                       width = 4, selected = "Basic", side = "right",
                       tabPanel("Custom",
                                h4("Edit filters"),
                                fluidRow(
                                  column(9,
                                         textInput("custom_filter", label = NULL, 
                                                   placeholder = "Write filter...", 
                                                   width = "100%")),
                                  column(1,
                                         actionButton("remove_axes", label = NULL, 
                                                      icon = icon("minus")))),
                                actionButton("add_axes", label = NULL, icon = icon("plus"))),
                       tabPanel("Basic",
                                selectizeInput("player_filter", label = "Players", 
                                               choices = NULL, width = "100%",
                                               multiple = TRUE),
                                #################### players with same name
                                column(6, 
                                       selectInput("position_filter", label = "Positions", 
                                                   choices = c("Running Back", 
                                                               "Quarterback", 
                                                               "Wide Receiver",
                                                               "Tight End",
                                                               "Other/Multiple"),
                                                   width = "100%", multiple = TRUE)),
                                #################### players with position '0' -> interpret as multiple/ambigious
                                column(6, 
                                       selectInput("team_filter", label = "Teams",
                                                   choices = c("ARI Cardinals", "ATL Falcons" = "ATL",
                                                               "BAL Ravens", "BUF Bills",
                                                               "CAR Panthers", "CHI Bears",
                                                               "CIN Bengals", "CLE Browns",
                                                               "DAL Cowboys", "DEN Broncos",
                                                               "DET Lions", "GB Packers",
                                                               "HOU Texans", "IND Colts",
                                                               "JAX Jaguars", "KC Chiefs",
                                                               "LV Raiders", "LAR Rams",
                                                               "LAC Chargers", "MIA Dolphins",
                                                               "MIN Vikings", "NWE Patriots",
                                                               "NOL Saints", "NYG Giants",
                                                               "NYJ Jets", "PHI Eagles",
                                                               "PIT Steelers", "SF 49ers",
                                                               "STL Seahawks", "TB Buccaneers",
                                                               "TEN Titans", "WAS Commanders"),
                                                   width = "100%", multiple = TRUE)),
                                #################### teams with different acronyms over time
                                # Chargers: SDG LAC
                                # Raiders: OAK RAI
                                # Rams: RAM LAR
                                # Patriots: BOS NWE
                                # Cardinals: ARI CAR
                                # Multiple: 2TM 3TM 4TM
                                sliderInput("year_filter", label = "Years", 1970, 2019, 
                                            value = c(1970, 2019), width = "100%",
                                            animate = TRUE),
                                actionButton("apply_filter", label = "Apply"),
                                actionButton("clear_filter", label = "Clear")
                       )
                )
              ),
              
############################## Player Radar Chart
              
              fluidRow(
                box(title = span("Player", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 8, height = "50%", collapsible = TRUE,
                    selectizeInput("player_radar", label = "Player", 
                                   choices = c("Select up to three..." = ""), 
                                   multiple = TRUE, width = "100%",
                                   options = list(maxItems = 3)),
                    plotOutput("radar_plot", height = "500px")
                )
              )
      )
    )
  )
)

server <- function(input, output, session) {
  
  updateSelectizeInput(session, "player_filter", choices = unique(all[, 1, drop = TRUE]), server = TRUE)
  
############################## Player Radar Chart
  
  playerYear <- function(p, y){
    return(paste(p, y, sep = " - "))
  }
  
  uniquePlayerYear <- function(data){
    return(reduce(select(data, Player, Year), playerYear))
  }
  
  radar_choices <- set_names(1:length(radardata[, 1, drop = TRUE]), uniquePlayerYear(radardata))
  
  updateSelectizeInput(session, "player_radar", choices = radar_choices, server = TRUE)
  
  plotradar <- reactive({
    input$player_radar
  })
  
  output$radar_plot <- renderPlot({
    if(length(plotradar()) > 0){
      
      r_players <- c()
      r_positions <- c()
      r_years <- c()
      playerdata <- NULL
      radar_legend <- c()

      for (i in 1:length(plotradar())){
        selection <- plotradar()[i]
        
        r_players <- c(r_players, radardata[selection, 1, drop = TRUE])
        r_positions <- c(r_positions, radardata[selection, 2, drop = TRUE])
        r_years <- c(r_years, radardata[selection, 3, drop = TRUE])
        
        playerdata <- bind_rows(playerdata, filter(radardata, Player == r_players[i],
                                                   Pos == r_positions[i],
                                                   Year == r_years[i]))
        
        radar_legend <- c(radar_legend, names(radar_choices)[as.integer(selection)])
      }
      
      playerdata <- select(playerdata, -c(Player, Pos, Year))
      posdata <- select(filter(radardata, Pos %in% r_positions), -c(Player, Pos, Year))

      data <- rbind(c(max(posdata$PassCmp), max(posdata$CmpPct),
                      max(posdata$PassYds), max(posdata$PassTD), min(posdata$Int),
                      max(posdata$RushAtt), max(posdata$RushAvg), max(posdata$RushYds),
                      max(posdata$RushTD), min(posdata$FumblesLost), max(posdata$Rec),
                      max(posdata$RecPct), max(posdata$RecYds), max(posdata$RecTD)),
                    c(min(posdata$PassCmp), min(posdata$CmpPct),
                      min(posdata$PassYds), min(posdata$PassTD), max(posdata$Int),
                      min(posdata$RushAtt), min(posdata$RushAvg), min(posdata$RushYds),
                      min(posdata$RushTD), max(posdata$FumblesLost), min(posdata$Rec),
                      min(posdata$RecPct), min(posdata$RecYds), min(posdata$RecTD)),
                    playerdata)

      stroke <- c( rgb(0.2,0.5,0.5,0.9), rgb(0.8,0.2,0.5,0.9), rgb(0.7,0.5,0.1,0.9) )
      fill <- c( rgb(0.2,0.5,0.5,0.4), rgb(0.8,0.2,0.5,0.4), rgb(0.7,0.5,0.1,0.4) )

      radarchart(data, pcol = stroke, pfcol = fill, plwd = 3, cglcol = "grey",
                 cglty = 1, cglwd = 1, vlcex = 1)
      
      legend(x = 1.2, y = 1, legend = radar_legend, bty = "n", pch = 20,
             col = fill, text.col = "grey", cex = 1.2, pt.cex = 3)
    }
  })
  
  # observeEvent(type(), {
  #   if (type() == "Histogram"){
  #     hide("y")
  #     output$wizard_plot <- renderPlot({
  #       ggplot(all, aes_string(x())) +
  #         geom_histogram()
  #     })
  #   }
  #   else{
  #     show("y")
  #     output$wizard_plot <- renderPlot({
  #       ggplot(all, aes_string(x(), y())) +
  #         geom_jitter()
  #     })
  #   }
  # })

  # observeEvent(input$year_option,
  #              {
  #                if (year_option() == "Multiple")
  #                  updateSliderInput(session, "years", value = c(years(), years() + 1))
  #                else
  #                  updateSliderInput(session, "years", value = years())
  #              })
  # dataset <- reactive({
  #   get(input$dataset, ls(yearly))
  # })
  # 
  # output$summary <- renderPrint(summary(dataset()))
  # 
  # output$table <- renderTable({
  #   dataset()
  # })
  

  #renderPlot() res = 96
}

shinyApp(ui, server)
