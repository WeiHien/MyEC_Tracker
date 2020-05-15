library(shiny)

# Load modules ----
source("modules/home.R")
source("modules/jobs.R")
source("modules/finance.R")

# Define UI ----
ui <- navbarPage(
    title = div(
        icon("briefcase"),
        "CoronaJob"
    ),
    windowTitle = "CoronaJob",

    # Homepage ----
    tabPanel("Home", homeUI(id = "home")),

    # Page 1 ----
    tabPanel("Jobs", jobsUI(id = "jobs")),

    # Page 2 ----
    tabPanel("Finance", financeUI(id = "finance")),

    # Other pages ----
    navbarMenu("More",
        tabPanel("Subsection 1"),
        "----",
        "Subsection header",
        tabPanel("Subsection 2")
    )
)

# Define Server logic ----
server <- function(input, output, session) {
    callModule(module = jobs, id = "jobs")
    callModule(module = finance, id = "finance")
}

# Run the App ----
shinyApp(ui = ui, server = server)