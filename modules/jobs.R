jobsUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        titlePanel("Jobs"),

        sidebarLayout(
            sidebarPanel(
                selectInput(ns("year"), 
                    label = "Choose year", 
                    choices = list("2020", "2019", "2018", "2017"),
                    selected = "2020"
                ),
            ),

            mainPanel(
                plotOutput(ns("rate")),
            ),
        ),
    )
}

jobs <- function(input, output, session) {
    output$rate <- renderPlot({
        rate <- data.frame("Month" = 1:12, rate = (sample(1:50, 12) / 10));
        plot(rate, type="l", main = paste("Unemployment Rate in year ", input$year))
    })
}