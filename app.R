library(shiny)
library(ggplot2)

ui <- fluidPage(
  #titlePanel()
  #sideBarLayout(
  #sideBarPanel(
  #mainPanel(
  selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
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

server <- function(input, output, session) {
  dataset <- reactive({
    get(input$dataset, "package:datasets")
  })
  
  output$summary <- renderPrint(summary(dataset()))
  
  output$table <- renderTable({
    dataset()
  })
  
  output$product <- renderText({ 
    input$x * 5
  })
  
  #renderPlot() res = 96
}

shinyApp(ui, server)