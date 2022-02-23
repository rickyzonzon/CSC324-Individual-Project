library(shiny)
library(shinydashboard)
library(ggplot2)

ui <- dashboardPage(skin = "red",
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
        fluidPage(
          #titlePanel()
          #sideBarLayout()
          #sideBarPanel()
          #mainPanel()
          selectInput("dataset", label = "Dataset", choices = 1970:2019),
          verbatimTextOutput("summary"),
          tableOutput("table"),
          sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
          "then x times 5 is",
          textOutput("product")
          #numericInput()
          #textInput()
          #passwordInput()
          #textAreaInput()
          #actionButton()
          #actionLink()
          #plotOutput() click, dblclick, and hover
        )
      ),
      
      tabItem(tabName = "wizard",
              fluidRow(
                box(title = "Axes", status = "warning", solidHeader = TRUE,
                    width = 12, collapsible = TRUE,
                    "monkey"),
              ),
              fluidRow(
                box(title = "Filters", status = "warning", solidHeader = TRUE,
                    width = 12, collapsible = TRUE,
                    selectInput("players", label = "Players", choices = c(),
                                multiple = TRUE),
                    selectInput("position", label = "Positions", choices = c(),
                                multiple = TRUE),
                    selectInput("teams", label = "Teams", choices = c(),
                                multiple = TRUE),
                    # individual players on team and total team
                    sliderInput("years", label = "Years", 1970, 2019, 
                                value = c(2000, 2019), animate = TRUE),
                    submitButton("Apply")
                )
              ),
              fluidRow(
                box(title = "Plots", status = "danger", solidHeader = TRUE,
                    width = 12, 
                    plotOutput("wizard_plot")
                )
              )
      )
    )
  )
)

server <- function(input, output, session) {
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

  output$product <- renderText({
    input$x * 5
  })

  #renderPlot() res = 96
}

shinyApp(ui, server)
