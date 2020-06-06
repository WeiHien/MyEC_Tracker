library(quantmod)
library(shinyWidgets)
library(DT)

stocksUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        h1(textOutput(ns("title"))),
        chooseSliderSkin("Flat"),
        sliderTextInput(
            ns("period"),
            label = NULL,
            choices = c(
                "1 year before MCO",
                "6 months before MCO",
                "3 months before MCO",
                "MCO Starts",
                "1 month after MCO",
                "Now"
            ),
            selected = c("3 months before MCO", "1 month after MCO"),
            width = "100%"
        ),
        br(),

        h2("KLSE"),
        p(class = "lead",
            "The FTSE Bursa Malaysia KLCI, also known as the FBM KLCI, is a capitalisation-weighted stock market index, composed of the 30 largest companies on the 
            Bursa Malaysia by market capitalisation that meet the eligibility requirements of the FTSE Bursa Malaysia Index Ground Rules. The index is jointly operated 
            by FTSE and Bursa Malaysia.",
            br(),
            "As indicated by KLSE stock, the stock market in Malaysia had been declining when covid-19 pandemic started, and took a deep hit 
            right after MCO is announced."),
        selectInput(ns("group"), 
            label = "Show by", 
            choices = c(
                "Daily" = "daily",
                "Weekly" = "weekly",
                "Monthly" = "monthly"
            ),
            selected = "Daily"
        ),
        div(class = "row",
            div(class = "col-md-8",
                plotOutput(ns("klse")),
            ),

            div(class = "col-md-4",
                DT::dataTableOutput(ns("klseTable"))
            )
        ),

        h2("Aviation (Airasia)"),
        p(class = "lead",
            "One of the most badly impacted industry is aviation. We look at Malaysia's leading Low-Cost Carrier, Airasia.",
            br(),
            "The stock has been declining since beginning of 2020, and similarly took a deep hit right after MCO is announced. After MCO, the stock is still struggling."),
        selectInput(ns("group"), 
            label = "Show by", 
            choices = c(
                "Daily" = "daily",
                "Weekly" = "weekly",
                "Monthly" = "monthly"
            ),
            selected = "Daily"
        ),
        div(class = "row",
            div(class = "col-md-4",
                DT::dataTableOutput(ns("airasiaTable"))
            ),
            div(class = "col-md-8",
                plotOutput(ns("airasia")),
            )
        ),

        h2("Petroleum (Petronas)"),
        p(class = "lead",
            "Secondly, another badly impacted industry is petroleum. At some point of time, there was even negative oil price. We look at Malaysia's national oil and gas company, Petronas.",
            br(),
            "The stock has been declining since beginning of 2020, and similarly took a deep hit right after MCO is announced. After MCO, the stock is still struggling."),
        selectInput(ns("group"), 
            label = "Show by", 
            choices = c(
                "Daily" = "daily",
                "Weekly" = "weekly",
                "Monthly" = "monthly"
            ),
            selected = "Daily"
        ),
        div(class = "row",
            div(class = "col-md-8",
                plotOutput(ns("petronas")),
            ),
            div(class = "col-md-4",
                DT::dataTableOutput(ns("petronasTable"))
            )
        )
    )
}

stocks <- function(input, output, session) {
    output$title <- renderText({
        paste("Stocks : ", input$period[1], " - ", input$period[2])
    })

    # Dictionary to map period label to actual represented date
    periodMaps <- c(
        "1 year before MCO" = "2019-03-18",
        "6 months before MCO" = "2019-09-18",
        "3 months before MCO" = "2019-12-18",
        "MCO Starts" = "2020-03-18",
        "1 month after MCO" = "2020-04-18",
        "Now" = as.character(Sys.Date())
    )

    # Load stock data from Yahoo Finance
    allKlseStock <- getSymbols("^KLSE", src = "yahoo", from = "2019-03-18", to = as.character(Sys.Date()), auto.assign = FALSE);
    allAirasiaStock <- getSymbols("5099.KL", src = "yahoo", from = "2019-03-18", to = as.character(Sys.Date()), auto.assign = FALSE);
    allPetronasStock <- getSymbols("PGAS.KL", src = "yahoo", from = "2019-03-18", to = as.character(Sys.Date()), auto.assign = FALSE);

    # Filter & group stock data
    groupedKlseStock <- reactive({
        klseStock <- allKlseStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$group == "weekly") return(to.weekly(klseStock))
        if (input$group == "monthly") return(to.monthly(klseStock))
        if (input$group == "daily") return(to.daily(klseStock))
    })

    groupedAirasiaStock <- reactive({
        airasiaStock <- allAirasiaStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$group == "weekly") return(to.weekly(airasiaStock))
        if (input$group == "monthly") return(to.monthly(airasiaStock))
        if (input$group == "daily") return(to.daily(airasiaStock))
    })

    groupedPetronasStock <- reactive({
        petronasStock <- allPetronasStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$group == "weekly") return(to.weekly(petronasStock))
        if (input$group == "monthly") return(to.monthly(petronasStock))
        if (input$group == "daily") return(to.daily(petronasStock))
    })

    # Graph Outputs
    output$klse <- renderPlot({
        dayToMCO <- min(which(format(index(groupedKlseStock()), "%Y-%m-%d") == '2020-03-18'))

        chartSeries(
            groupedKlseStock(), 
            type = "line", 
            log.scale = FALSE,
            up.col='green',
            dn.col='red',
            TA = paste0("addLines(v=", dayToMCO, ", col='red')")
        )

        if (input$group == "daily") {
            addBBands(); addVo(); addMACD();
        }
    })

    output$airasia <- renderPlot({
        dayToMCO <- min(which(format(index(groupedAirasiaStock()), "%Y-%m-%d") == '2020-03-18'))

        chartSeries(
            groupedAirasiaStock(), 
            type = "line", 
            log.scale = FALSE,
            up.col='green',
            dn.col='red',
            TA = paste0("addLines(v=", dayToMCO, ", col='red')")
        )

        if (input$group == "daily") {
            addBBands(); addVo(); addMACD();
        }
    })

    output$petronas <- renderPlot({
        dayToMCO <- min(which(format(index(groupedPetronasStock()), "%Y-%m-%d") == '2020-03-18'))

        chartSeries(
            groupedPetronasStock(), 
            type = "line", 
            log.scale = FALSE,
            up.col='green',
            dn.col='red',
            TA = paste0("addLines(v=", dayToMCO, ", col='red')")
        )

        if (input$group == "daily") {
            addBBands(); addVo(); addMACD();
        }
    })

    # Table Outputs
    output$klseTable = DT::renderDataTable({
        as.data.frame(groupedKlseStock())['klseStock.Close']
    }, colnames = c("Closing Price"))

    output$airasiaTable = DT::renderDataTable({
        as.data.frame(groupedAirasiaStock())['airasiaStock.Close']
    }, colnames = c("Closing Price"),)

    output$petronasTable = DT::renderDataTable({
        as.data.frame(groupedPetronasStock())['petronasStock.Close']
    }, colnames = c("Closing Price"),)
}