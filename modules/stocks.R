library(quantmod)

stocksUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        titlePanel("Stocks"),

        sidebarLayout(
            sidebarPanel(
                selectInput(ns("from"), 
                    label = "Choose Period", 
                    choices = c(
                        "This year" = "2020-01-01",
                        "Since MCO" = "2020-03-18"
                    ),
                    selected = "2020-01-01"
                ),

                selectInput(ns("group"), 
                    label = "Show by", 
                    choices = c(
                        "Daily" = "daily",
                        "Weekly" = "weekly",
                        "Monthly" = "monthly"
                    ),
                    selected = "Daily"
                ),
            ),

            mainPanel(
                plotOutput(ns("klse")),
                br(),
                plotOutput(ns("klse2")),
            ),
        ),
    )
}

stocks <- function(input, output, session) {
    klseStock <- reactive({
        getSymbols(
            "^klse", 
            src = "yahoo",
            from = input$from,
            to = Sys.Date(),
            auto.assign = FALSE
        )
    })

    groupedKlseStock <- reactive({
        if (input$group == "weekly") return(to.weekly(klseStock()))
        if (input$group == "monthly") return(to.monthly(klseStock()))
        klseStock()
    })

    output$klse <- renderPlot({
        chartSeries(
            groupedKlseStock(), 
            type = "line", 
            log.scale = FALSE,
            up.col='green',
            dn.col='red'
        )

        if (input$group == "daily") {
            addBBands(); addVo(); addMACD();
        }
    })
}