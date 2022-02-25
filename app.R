library(shiny)
library(shinythemes)
library(shinydashboard)
library(ggplot2)

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
            # fact wizard
            # image wizard
          
          selectInput("dataset", label = "Dataset", choices = 1970:2019),
          verbatimTextOutput("summary"),
          tableOutput("table"),
          sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
          "then x times 5 is",
          textOutput("product")
        )
      ),
      
      tabItem(tabName = "wizard",
              fluidRow(
                tags$style(HTML("
                  .box.box-solid.box-primary>.box-header {
                    color:#fff;
                    background:#666666
                  }
                  
                  .box.box-solid.box-primary{
                    border-bottom-color:#666666;
                    border-left-color:#666666;
                    border-right-color:#666666;
                    border-top-color:#666666;
                  }
                                ")),
                box(title = span("Plot Options", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 6, collapsible = TRUE,
                    column(6, selectInput("x", label = "X-Axis", choices = c(),
                                multiple = TRUE)),
                    column(6, selectInput("y", label = "Y-Axis", choices = c(),
                                multiple = TRUE)),
                    # options for plot features (smooth line, se = TRUE, etc.)
                    actionButton("apply_axes", label = "Apply")
                ),
                box(title = span("Filters", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 6, collapsible = TRUE,
                    selectizeInput("players", label = "Players", 
                                choices = NULL,
                                multiple = TRUE),
   #################### players with same name
                    column(6, selectInput("position", label = "Positions", 
                                          choices = unique(all$Pos),
                                          multiple = TRUE)),
   #################### players with position '0' -> interpret as multiple/ambigious
                    column(6, selectInput("teams", label = "Teams", 
                                          choices = c("ARI Cardinals", "ATL Falcons",
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
                                          multiple = TRUE)),
   #################### individual players on team and total team
   #################### teams with different acronyms over time
                        # Chargers: SDG LAC
                        # Raiders: OAK RAI
                        # Rams: RAM LAR
                        # Patriots: BOS NWE
                        # Cardinals: ARI CAR
                        # Multiple: 2TM 3TM 4TM
                    sliderInput("years", label = "Years", 1970, 2019, 
                                value = c(2000, 2019), animate = TRUE),
                    actionButton("apply_filter", label = "Apply")
                )
              ),
              fluidRow(
                box(title = span("Plot", style = "color:white;"), status = "primary", 
                    solidHeader = TRUE, width = 12, 
                    plotOutput("wizard_plot"),
                 #   actionButton("download", label = "Dowload Plot")
                )
              )
      )
    )
  )
)

server <- function(input, output, session) {
  output$product <- renderText({
    input$x * 5
  })
  
  updateSelectizeInput(session, "players", choices = unique(all$Player), server = TRUE)
  
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
