library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(shinyBS)
library(tidyverse)
library(fmsb)

ui <- dashboardPage(skin = "blue",
  dashboardHeader(title = strong("Fvntvsy Footbvll Vis")),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("th")),
      menuItem("Stat Wizard", tabName = "wizard", icon = icon("hat-wizard")),
      menuItem("Player Wizard", tabName = "player", icon = icon("football-ball"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidPage(theme = shinytheme("lumen")),
              fluidRow(
                h3(textOutput("dashboard_text"))
              ),
              fluidRow(
                imageOutput("dashboard1", inline = TRUE),
                imageOutput("dashboard2", inline = TRUE)
              ),
              fluidRow(
                imageOutput("dashboard3", inline = TRUE),
                imageOutput("dashboard4", inline = TRUE)
              )
      ),
      tabItem(tabName = "wizard",
              useShinyjs(),
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
                
                .col-sm-2 {padding-right:5px;}
                .col-sm-3 {padding-right:5px;}
                .col-sm-4 {padding-right:5px;}
              ")),
              fluidRow(
                box(id = "plot", title = span("Plot", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 7, height = "100%",
                    tags$div(title = "Click to see plot options",
                             dropdownButton(
                               h4("Plot Options"),
                               
                               selectInput("plot_x", label = "X-Axis", 
                                           choices = c("CUSTOM", colnames(select(all, -c(Player, Team)))),
                                           selected = "Pos"),
                               textInput("x_expression", label = "X Expression", width = "100%"),
                               
                               selectInput("plot_y", label = "Y-Axis", 
                                           choices = c("CUSTOM", colnames(select(all, -c(Player, Team)))),
                                           selected = "Pos"),
                               textInput("y_expression", label = "Y Expression", width = "100%"),
                               
                               selectInput("plot_color", label = "Color",
                                           choices = c("NONE", "CUSTOM", 
                                                       colnames(select(all, -c(Player, Team))))),
                               textInput("color_expression", label = "Color Expression", width = "100%"),
                               
                               selectInput("plot_alpha", label = "Alpha",
                                           choices = c("NONE", "CUSTOM", 
                                                       colnames(select(all, -c(Player, Team))))),
                               textInput("alpha_expression", label = "Alpha Expression", width = "100%"),
                               
                               selectInput("plot_size", label = "Size",
                                           choices = c("NONE", "CUSTOM",
                                                       colnames(select(all, -c(Player, Team))))),
                               textInput("size_expression", label = "Size Expression", width = "100%"),
                               
                               switchInput("plot_smooth_line", label = "Smooth Line"),
                               
                               switchInput("plot_smooth_ci", label = "Confidence Interval"),
                               
                               sliderInput("plot_smooth_span", label = "Wiggle (Span)",
                                           0, 1, 0.75, 0.01),
                               
                               circle = TRUE, status = "primary", size = "sm",
                               icon = icon("gear"), width = "300px"
                             )
                    ),
                    plotOutput("wizard_plot", height = "500px", brush = brushOpts(id = "plot_brush")),
                    uiOutput("brush_info")
                ),
                tabBox(id = "filters", title = span("Filters", style = "color:white;"),
                       width = 5, selected = "Basic", side = "right",
                       tabPanel("Custom",
                                h4("Edit filters"),
                                uiOutput("custom_filter_1"),
                                uiOutput("custom_filter_2"),
                                uiOutput("custom_filter_3"),
                                uiOutput("custom_filter_4"),
                                uiOutput("custom_filter_5"),
                                verbatimTextOutput("filter_error"),
                                actionButton("apply_custom_filter", "Apply")
                                # uiOutput("custom_filters")
                                # actionButton("add_filter", label = NULL, icon = icon("plus"))
                       ),
                       tabPanel("Basic",
                                selectizeInput("player_filter", label = "Players", 
                                               choices = NULL, width = "100%",
                                               multiple = TRUE),
                                column(6, 
                                       selectInput("position_filter", label = "Positions", 
                                                   choices = c("Running Back" = "RB", 
                                                               "Quarterback" = "QB", 
                                                               "Wide Receiver" = "WR",
                                                               "Tight End" = "TE",
                                                               "Other/Multiple" = "0"),
                                                   width = "100%", multiple = TRUE)),
                                column(6, 
                                       selectInput("team_filter", label = "Teams",
                                                   choices = c("ARI Cardinals" = c("ARI", "PHO", "STL"), 
                                                               "ATL Falcons" = c("ATL"),
                                                               "BAL Ravens" = c("BAL"), 
                                                               "BUF Bills" = c("BUF"),
                                                               "CAR Panthers" = c("CAR"), 
                                                               "CHI Bears" = c("CHI"),
                                                               "CIN Bengals" = c("CIN"), 
                                                               "CLE Browns" = c("CLE"),
                                                               "DAL Cowboys" = c("DAL"), 
                                                               "DEN Broncos" = c("DEN"),
                                                               "DET Lions" = c("DET"), 
                                                               "GB Packers" = c("GNB"),
                                                               "HOU Texans" = c("HOU"), 
                                                               "IND Colts" = c("IND"),
                                                               "JAX Jaguars" = c("JAX"), 
                                                               "KC Chiefs" = c("KAN"),
                                                               "LV Raiders" = c("OAK", "RAI"), 
                                                               "LAR Rams" = c("RAM", "LAR"),
                                                               "LAC Chargers" = c("SDG", "LAC"), 
                                                               "MIA Dolphins" = c("MIA"),
                                                               "MIN Vikings" = c("MIN"), 
                                                               "NWE Patriots" = c("BOS", "NWE"),
                                                               "NOL Saints" = c("NOR"),
                                                               "NYG Giants" = c("NYG"),
                                                               "NYJ Jets" = c("NYJ"),
                                                               "PHI Eagles" = c("PHI"),
                                                               "PIT Steelers" = c("PIT"), 
                                                               "SF 49ers" = c("SFO"),
                                                               "SEA Seahawks" = c("SEA"),
                                                               "TB Buccaneers" = c("TAM"),
                                                               "TEN Titans" = c("TEN"),
                                                               "WAS Commanders" = c("WAS"),
                                                               "Multiple Teams" = c("2TM", "3TM", "4TM")),
                                                   width = "100%", multiple = TRUE)),
                                sliderInput("year_filter", label = "Years", 1970, 2019, 
                                            value = c(1970, 2019), width = "100%"),
                                actionButton("apply_basic_filter", "Apply")
                       )
                 )
              ),
              fluidRow(
                box(id = "plot_legend", title = span("Legend", style = "color:white;"),  
                    status = "primary", solidHeader = TRUE, width = 7, collapsible = TRUE,
                    verbatimTextOutput("plot_legend_text")
                )
              )
      ),
      tabItem(tabName = "player",
              ############################## Player Radar Chart
              fluidRow(
                box(id = "radar", title = span("Player", style = "color:white;"), 
                    status = "primary", solidHeader = TRUE, width = 12, height = "50%", 
                    collapsible = TRUE,
                    selectizeInput("player_radar", label = "Player", 
                                   choices = c("Select up to three..." = ""), 
                                   multiple = TRUE, width = "100%",
                                   options = list(maxItems = 3)),
                    plotOutput("radar_plot", height = "500px")
                )
              ),
              fluidRow(
                box(id = "radar_legend", title = span("Legend", style = "color:white;"),  
                    status = "primary", solidHeader = TRUE, width = 12, collapsible = TRUE,
                    verbatimTextOutput("radar_legend_text")
                )
              )
      )
    )
  )
)

server <- function(input, output, session) {

############################ FUNCTIONS ############################
  
  playerYear <- function(p, y){
    return(paste(p, y, sep = " - "))
  }
  
  uniquePlayerYear <- function(data){
    return(reduce(select(data, Player, Year), playerYear))
  }
  
  legendStr <- function(axes_used){
    lgd <- ""
    
    for (axis in axes_used)
      if (axis != "NONE" & axis != "CUSTOM")
        lgd <- paste0(lgd, axis, " = ", descriptions[[axis]], "\n")
    
    return(lgd)
  }
  
  custom_filter_UI <- function(i){
    return(
        textInput(paste0("filter_expression_", i), label = paste0("Expression ", i),
                  width = "100%")
    )
  }
  
############################ DASHBOARD ############################
  
  output$dashboard_text <- renderText({
    "Here are some examples of the visualizations you can create with this application!"
  })
  
  dashboard_images <- c("output/rb-wr-targets-vs-fpts.png",
                        "output/mvp-rushing-qbs.png",
                        "output/christian-mccaffrey-career.png",
                        "output/qb-rushing-vs-fpts.png")
  
  output$dashboard1 <- renderImage({
    list(src = dashboard_images[1])
  }, deleteFile = FALSE)
  
  output$dashboard2 <- renderImage({
    list(src = dashboard_images[2])
  }, deleteFile = FALSE)
  
  output$dashboard3 <- renderImage({
    list(src = dashboard_images[3])
  }, deleteFile = FALSE)
  
  output$dashboard4 <- renderImage({
    list(src = dashboard_images[4])
  }, deleteFile = FALSE)
  
########################### STAT WIZARD ###########################

########################################## Filters
  
  player_filter_choices <-  unique(all[, 1, drop = TRUE])
  
  updateSelectizeInput(session, "player_filter", choices = player_filter_choices,
                       server = TRUE)
  
  players <- reactive({
    input$player_filter
  })
  
  positions <- reactive({
    input$position_filter
  })
  
  teams <- reactive({
    input$team_filter
  })
  
  years <- reactive({
    input$year_filter
  })
  
  filtered_data <- reactiveVal(all)

  observeEvent(input$apply_basic_filter, {
    filtered_data(all)
    
    if (!is.null(players()))
      filtered_data(filter(filtered_data(), Player %in% players()))
    
    if (!is.null(positions()))
      filtered_data(filter(filtered_data(), Pos %in% positions()))
    
    if (!is.null(teams()))
      filtered_data(filter(filtered_data(), Team %in% teams()))
    
    filtered_data(filter(filtered_data(), Year >= years()[1] & Year <= years()[2]))
  })
  
  # num_filters <- reactiveVal(0)                 # TODO: dynamic custom filter UI
  # filter_list <- reactiveVal(list())
  # 
  # observeEvent(input$add_filter, {
  #   num_filters(num_filters() + 1)
  #   
  #   filter_list(append(filter_list(),
  #                      fluidRow(
  #                        column(10,
  #                               textInput(paste0("expression_", num_filters()), label = "Expression", 
  #                                         width = "100%")),
  #                        column(1,
  #                               actionButton(paste0("remove_axes_", num_filters()), label = "",
  #                                            icon = icon("minus")))
  #                      )))
  #   
  #   output[["custom_filters"]] <- renderUI({
  #     filter_list()
  #   })
  # })
  
  output$custom_filter_1 <- renderUI({
    custom_filter_UI(1)
  })
  
  output$custom_filter_2 <- renderUI({
    custom_filter_UI(2)
  })
  
  output$custom_filter_3 <- renderUI({
    custom_filter_UI(3)
  })
  
  output$custom_filter_4 <- renderUI({
    custom_filter_UI(4)
  })
  
  output$custom_filter_5 <- renderUI({
    custom_filter_UI(5)
  })
  
  filter_list <- lapply(1:5, function(i){
    reactive({input[[paste0("filter_expression_", i)]]})
  })
  
  observeEvent(input$apply_custom_filter, {
    filtered_data(all)
    errors <- reactiveVal()
    
    for(i in 1:length(filter_list)){
      
      filter_exp <- filter_list[[i]]
      
      if (filter_exp() != ""){
        
        filtered_data(
          tryCatch(
            filter(filtered_data(), eval(parse(text = filter_exp()))),
            error = function(cond){
              errors(paste0(errors(), "Expression ", i, " is invalid, and has not been included in the filter.\n"))
              filtered_data()
            },
            warning = function(cond){
              errors(paste0(errors(), "Expression ", i, " is invalid, and has not been included in the filter.\n"))
              filtered_data()
            }
          )
        )
      }
      else
        errors(paste0(errors(), "Expression ", i, " is empty, and has not been included in the filter.\n"))
    }
    
    if (errors() != "")
      output$filter_error <- renderText({errors()})
  })
  
########################################## Wizard Plot
  
  x <- reactive({
    input$plot_x
  })

  y <- reactive({
    input$plot_y
  })

  color <- reactive({
    input$plot_color
  })

  alpha <- reactive({
    input$plot_alpha
  })
  
  size <- reactive({
    input$plot_size
  })
  
  smooth <- reactive({
    input$plot_smooth_line
  })

  se <- reactive({
    input$plot_smooth_ci
  })
  
  span <- reactive({
    input$plot_smooth_span
  })
  
  observeEvent(smooth(), {
    if (smooth()){
      show("plot_smooth_ci")
      show("plot_smooth_span")
    }
    else{
      hide("plot_smooth_ci")
      hide("plot_smooth_span")
    }
  })
  
  observeEvent(x(), {
    if (x() == "CUSTOM")
      show("x_expression")
    else
      hide("x_expression")
    
  })
  
  observeEvent(y(), {
    if (y() == "CUSTOM")
      show("y_expression")
    else
      hide("y_expression")
  })
  
  observeEvent(color(), {
    if (color() == "CUSTOM")
      show("color_expression")
    else
      hide("color_expression")
  })
  
  observeEvent(alpha(), {
    if (alpha() == "CUSTOM")
      show("alpha_expression")
    else
      hide("alpha_expression")
  })
  
  observeEvent(size(), {
    if (size() == "CUSTOM")
      show("size_expression")
    else
      hide("size_expression")
  })
  
  output$wizard_plot <- renderPlot({
    aes <- aes_string(color = ifelse(color() == "NONE", 
                                     "NULL",
                                     ifelse(color() == "CUSTOM",
                                            eval(parse(text = paste0("(\'", input$color_expression, "\')"))),
                                            color())),
                      size = ifelse(size() == "NONE",
                                    "NULL",
                                    ifelse(size() == "CUSTOM",
                                           eval(parse(text = paste0("('", input$size_expression, "')"))),
                                           size())),
                      alpha = ifelse(alpha() == "NONE",
                                     "NULL",
                                     ifelse(alpha() == "CUSTOM",
                                            eval(parse(text = paste0("('", input$alpha_expression, "')"))),
                                            alpha())))
    
    if (size() == "NONE")
      scatter <- geom_point(mapping = aes, size = 2)
    else
      scatter <- geom_point(mapping = aes)
    
    plot <- ggplot(filtered_data(), aes_string(ifelse(x() == "CUSTOM",
                                                      eval(parse(text = paste0("('", input$x_expression, "')"))),
                                                      x()), 
                                               ifelse(y() == "CUSTOM", 
                                                      eval(parse(text = paste0("('", input$y_expression, "')"))), 
                                                      y()))) + scatter

    if (smooth())
      if (se())
        plot + geom_smooth(se = TRUE)
        #plot + geom_smooth(se = TRUE, method = "loess", span = span())
      else
        plot + geom_smooth(se = FALSE)
        #plot + geom_smooth(se = FALSE, method = "loess", span = span())
    else
      plot
    
  })
  
  brush <- reactive({
    input$plot_brush
  })

  output$brush_info <- renderUI({
    points <- brushedPoints(as.data.frame(filtered_data()), brush())

    req(nrow(points) > 0)

    verbatimTextOutput("info")
  })
  
  output$info <- renderPrint({
    points <- brushedPoints(as.data.frame(filtered_data()), brush())

    req(nrow(points) > 0)
    
    axes_used <- unique(c(x(), y(), color(), alpha(), size()))
    axes <- c()
    
    for (axis in axes_used)
      if (axis != "NONE" & axis != "CUSTOM")
        axes <- c(axes, axis)

    select(points, Player, Team, Pos, Year, axes)
  })

  
#################### Legend
  
  descriptions <- c("Pos" = "The position of the player.",
                    "Age" = "The age of the player.",
                    "Games" = "The number of games the player played in.",
                    "GmStart" = "The number of games the player started in.",
                    "PassCmp" = "The number of passes completed by the player.",
                    "PassAtt" = "The number of passes thrown by the player.",
                    "PassYds" = "The number of passing yards gained by the player.",
                    "PassTD" = "The number of passing touchdowns scored by the player.",
                    "Int" = "The number of interceptions thrown by the player.",
                    "RushAtt" = "The number of rushing attempts by the player.",
                    "RushYds" = "The number of rushing yards gained by the player.",
                    "RushTD" = "The number of rushing touchdowns scored by the player.",
                    "Tgt" = "The number of targets (balls thrown to) the player had. 
                    [Note: the NFL only began tracking targets in 1992]",
                    "Rec" = "The number of receptions (balls caught) the player had.",
                    "RecYds" = "The number of receiving yards gained by the player.",
                    "RecTD" = "The number of receiving touchdowns scored by the player.",
                    "YPR" = "The number of receiving yards gained per reception by the player.",
                    "FumblesLost" = "The number of fumbles lost by the player.",
                    "FPTS" = "The number of fantasy points earned by the player.",
                    "CmpPct" = "The percentage of completed passes out of total passes thrown.",
                    "RushAvg" = "The average number of rushing yards gained per rushing attempt.",
                    "RecPct" = "The percentages of receptions (balls caught) out of total targets 
                    (balls thrown to). [Note: the NFL only began tracking targets in 1992]")

  output$plot_legend_text <- renderText({
    axes_used <- unique(c(x(), y(), color(), alpha(), size()))
    lgd <- legendStr(axes_used)
    lgd
  })
  
#################### Radar Chart
  
  output$radar_legend_text <- renderText({
    axes_used <- colnames(select(radardata, -c(Player, Pos, Year)))
    lgd <- legendStr(axes_used)
    lgd
  })
  
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
  }, res = 96)
}

shinyApp(ui, server)
