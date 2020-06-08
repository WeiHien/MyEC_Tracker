library(shiny)

# Load modules ----
source("modules/home.R")
source("modules/jobs.R")
source("modules/finance.R")
source("modules/stocks.R")
source("modules/about-us.R")

# Define UI ----
ui <- navbarPage(
    theme = "css/bootstrap.min.css",
    inverse = TRUE,
    title = div(
        icon("line-chart"),
        "CoronaJob"
    ),
    windowTitle = "CoronaJob",

    # Homepage ----
    tabPanel("Home", homeUI(id = "home")),

    # Page 1 ----
    tabPanel("Jobs", jobsUI(id = "jobs")),

    # Page 2 ----
    tabPanel("Economy", financeUI(id = "finance")),

    # Page 3 ----
    tabPanel("Stocks", stocksUI(id = "stocks")),

    # Other pages ----
    navbarMenu("More",
        tabPanel("About Us", aboutUsUI(id = "about-us")),
        "----",
        "Subsection header",
        tabPanel("Subsection 2")
    )
)

# Define Server logic ----
server <- function(input, output, session) {
    callModule(module = jobs, id = "jobs")
    callModule(module = finance, id = "finance")
    callModule(module = stocks, id = "stocks")
}

# Run the App ----
shinyApp(ui = ui, server = server)