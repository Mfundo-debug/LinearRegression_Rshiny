library(shiny)
library(highcharter)
library(plotly)

# Define UI
ui <- fluidPage(
  # App title
  titlePanel("Simple Linear Regression"),
  # Sidebar layout with input and output definitions
  sidebarLayout(
    # Sidebar panel for inputs
    sidebarPanel(
      # Input: Select a file
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      # Horizontal line
      tags$hr(),
      # Input: Checkbox if file has header
      checkboxInput("header", "Header", TRUE),
      # Input: Select separator
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),
      # Input: Select quotes
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),
      # Horizontal line
      tags$hr(),
      # Input: Select number of rows to display
      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head")
    ),
    # Main panel for displaying outputs
    mainPanel(
      tabsetPanel(
        tabPanel("Table", tableOutput("contents")), 
        tabPanel("Summary", verbatimTextOutput("summary")), 
        tabPanel("Corelogram", plotOutput("corrplot")),
        tabPanel("Histogram", plotOutput("Hist1"),
                 plotOutput("Hist2")),
        tabPanel("Prediction", verbatimTextOutput("modelSummary")),
        tabPanel("Vizualising Test Results", plotOutput("Viz")),
        tabPanel("Model Checks", plotOutput("modelChecks")),
        tabPanel("Residuals", plotOutput("residuals"))
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  data <- reactive({ 
    req(input$file1)
    inFile <- input$file1
    df <- read.csv(inFile$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    df
  })
  
  output$contents <- renderTable({
    req(data())
    df <- data()
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
  })
  
  output$summary <- renderPrint({
    req(data())
    df <- data()
    print(summary(df))
  })
  
  output$corrplot <- renderPlot({
    req(data())
    df <- data()
    library(PerformanceAnalytics)
    chart.Correlation(df, histogram=TRUE, pch=19)
  })
  
  output$Hist1 <- renderPlot({
    req(data())
    df <- data()
    ggplot(df, aes(x = YearsExperience)) +
      geom_histogram(fill = "blue", color = "black") +
      ggtitle("Histogram for Years of Experience")
  })
  
  output$Hist2 <- renderPlot({
    req(data())
    df <- data()
    ggplot(df, aes(x = Salary)) +
      geom_histogram(fill = "blue", color = "black") +
      ggtitle("Histogram for Salary")
  })
  
  output$modelSummary <- renderPrint({
    req(data())
    df <- data()
    model <- lm(Salary ~ YearsExperience, data = df)
    summary(model)
  })
  
  output$Viz <- renderPlot({
    req(data())
    df <- data()
    model <- lm(Salary ~ YearsExperience, data = df)
    df$Fitted <- predict(model, newdata = df)
    p <- hchart(df, "scatter", hcaes(x = YearsExperience, y = Salary)) %>%
      hc_add_series(data = df, type = "line", hcaes(x = YearsExperience, y = Fitted), name = "Fitted line")
    p
  })
  
  output$modelChecks <- renderPlot({
    req(data())
    df <- data()
    model <- lm(Salary ~ YearsExperience, data = df)
    plot(model)
  })
  
  output$residuals <- renderPlot({
    req(data())
    df <- data()
    model <- lm(Salary ~ YearsExperience, data = df)
    plot(resid(model))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)