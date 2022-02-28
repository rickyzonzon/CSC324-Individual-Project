library(shiny)
library(shinythemes)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(tidyverse)

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
                    solidHeader = TRUE, width = 8,
                    dropdownButton(
                      useShinyjs(),
                      
                      h4("Plot Options"),
                      
                      radioGroupButtons("plot_type", label = NULL, #turn into toggle if cant think of any other plots (pie?)
                                        choices = c("Scatterplot", "Histogram", "Pie Chart"), #maybe do aesthetic options (like smooth line)
                                        selected = "Scatterplot"),                #instead of diff plots
                      
                      selectInput("x", label = "X-Axis", 
                                  choices = colnames(select(all, -c("Player", "Team", "Pos", "Year")))),
                      
                      selectInput("y", label = "Y-Axis", 
                                  choices = colnames(select(all, -c("Player", "Team", "Pos", "Year")))),
                      
                      #selectInput("color"),
                        #color picker?
                      
                      #selectInput("size"),
                      
                      #switchInput("smooth_line"),
                        #
                      
                      circle = TRUE, status = "primary", size = "sm",
                      icon = icon("gear"), width = "300px",
                      
                      tooltip = tooltipOptions(title = "Click to see inputs !")
                    ),
                    plotOutput("wizard_plot")
                    # actionButton("download", label = "Download Plot")
                ),
                # box(title = span("Plot Axes", style = "color:white;"), status = "primary", 
                #     solidHeader = TRUE, width = 6, collapsible = TRUE,
                #     column(6, 
                #            selectInput("x", label = "X-Axis", 
                #                        choices = colnames(select(all, -c("Player", "Team", "Pos", "Year"))))),
                #     column(6, 
                #            selectInput("y", label = "Y-Axis", 
                #                        choices = colnames(select(all, -c("Player", "Team", "Pos", "Year"))))),
                #     box(title = span("Other axes", style = "font-size:14px"), 
                #         status = "danger", solidHeader = FALSE, width = 12, 
                #         collapsible = TRUE, collapsed = TRUE
                #         # checkboxInput("color_axes", label = "Color"),
                #         # selectInput("a", label = NULL, width = "60%", choices = c())
                #         # actionButton("add_axes", label = NULL, icon = icon("plus")),
                #         # actionButton("remove_axes", label = NULL, icon = icon("minus"))
                #     ),
                #     
                #         # options for plot features (smooth line, se = TRUE, etc.)
                #     actionButton("apply_axes", label = "Apply", justified = TRUE)
                # ),
                tabBox(title = span("Filters", style = "color:white;"), id = "filters", 
                       width = 4, selected = "Basic", side = "right",
                       tabPanel("Custom",
                                textInput("test", "Test")),
                       tabPanel("Basic",
                                selectizeInput("players", label = "Players", 
                                               choices = NULL, width = "100%",
                                               multiple = TRUE),
                                #################### players with same name
                                column(6, 
                                       selectInput("position", label = "Positions", 
                                                   choices = c("Running Back", 
                                                               "Quarterback", 
                                                               "Wide Receiver",
                                                               "Tight End",
                                                               "Other/Multiple"),
                                                   width = "100%", multiple = TRUE)),
                                #################### players with position '0' -> interpret as multiple/ambigious
                                column(6, 
                                       selectInput("teams", label = "Teams",
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
                                sliderInput("years", label = "Years", 1970, 2019, 
                                            value = c(1970, 2019), width = "100%",
                                            animate = TRUE),
                                actionButton("apply_filter", label = "Apply"),
                                actionButton("clear_filter", label = "Clear")
                       )
                )
              ),
              fluidRow(
                box(title = span("Player", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 6, collapsible = TRUE,
                    selectizeInput("player", label = "Player", 
                                   choices = NULL, width = "100%"),
                    plotOutput("radar_plot")
                )
              )
      )
    )
  )
)

server <- function(input, output, session) {
  updateSelectizeInput(session, "players", choices = unique(all$Player), server = TRUE)
  updateSelectizeInput(session, "player", choices = unique(all$Player), server = TRUE)
  
  type <- reactive({
    input$plot_type
  })
  
  x <- reactive({
    input$x
  })
  
  y <- reactive({
    input$y
  })
  
  observeEvent(type(), {
    if (type() == "Histogram"){
      hide("y")
      output$wizard_plot <- renderPlot({
        ggplot(all, aes_string(x())) +
          geom_histogram()
      })
    }
    else{
      show("y")
      output$wizard_plot <- renderPlot({
        ggplot(all, aes_string(x(), y())) +
          geom_jitter()
      })
    }
  })

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
