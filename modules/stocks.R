library(quantmod)
library(shinyWidgets)

stocksUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        chooseSliderSkin("Flat"),
        sliderTextInput(
            ns("period"),
            label = NULL,
            choices = c(
                "1 year before MCO",
                "6 months before MCO",
                "3 months before MCO",
                "MCO Starts",
                "Now"
            ),
            selected = c("3 months before MCO", "Now"),
            width = "100%"
        ),

        h2(textOutput(ns("period"))),

        selectInput(ns("group"), 
            label = "Show by", 
            choices = c(
                "Daily" = "daily",
                "Weekly" = "weekly",
                "Monthly" = "monthly"
            ),
            selected = "Daily"
        ),

        plotOutput(ns("klse"))
    )
}

stocks <- function(input, output, session) {
    klseStock <- reactive({
        periodMaps <- c(
            "1 year before MCO" = "2019-03-18",
            "6 months before MCO" = "2019-09-18",
            "3 months before MCO" = "2019-12-18",
            "MCO Starts" = "2020-03-18",
            "Now" = as.character(Sys.Date()),
            grid = TRUE
        )

        getSymbols(
            "^KLSE", 
            src = "yahoo",
            from = periodMaps[input$period[1]],
            to = periodMaps[input$period[2]],
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

    output$period <- renderText({
        paste("KLSE Index : ", input$period[1], " - ", input$period[2])
    })
}