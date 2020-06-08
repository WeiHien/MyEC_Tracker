library(quantmod)
library(shinyWidgets)
library(DT)

stocksUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        h1("Impact on Stocks"),
        p(class = "lead",
            "Let's look at the impact on Malaysia stock market. As shown by red line in the charts, we'll use the MCO date (2020-03-18) as reference point, which 
            represents the period when the covid-19 started getting severe and impacting business.",
        ),
        br(),
        p("Drag the slider to select the period range :"),
        br(),

        chooseSliderSkin("Flat"),
        sliderTextInput(
            ns("period"),
            label = NULL,
            choices = c(
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

        h2("FBM KLCI"),
        p(
            a(href = "https://www.bursamalaysia.com/trade/our_products_services/indices/ftse_bursa_malaysia_indices/ftse_bursa_malaysia_klci", "FTSE Bursa Malaysia KLCI"),
            " comprises the largest 30 companies listed on the Main Board by full market capitalisation that meet the eligibility requirements.
            It was enhanced by Bursa Malaysia to ensure that it remains robust in measuring the national economy with growing linkage to the global economy.",
            br(), br(),
            "As could be seen from the stock trend, the stock market in Malaysia had been declining when covid-19 pandemic started, and took a deep hit 
            around the time MCO is announced. After MCO, it has been slowly recovering.",
            br(), br(),
            strong("In the span of a week (11th March to 18 March 2020), the index drops by 14.19% (1443.83 to 1239.01).")
        ),
        selectInput(ns("groupKlse"), 
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
        br(),

        h2("Aviation (AirAsia)"),
        p(
            "One of the most badly impacted industry is aviation / tourism, as many countries have closed their borders and people afraid to go oversea. 
            We look at Malaysia's leading Low-Cost Carrier, ",
            a(href = "https://www.airasia.com/", "AirAsia Berhad"),
            ".",
            br(), br(),
            "The stock has been declining since beginning of 2020, and further plunged around the period MCO is announced. After MCO, the stock is still struggling. This 
            is because oversea travels are still expected to be severely limited for the rest of this year.",
            br(), br(),
            strong("At it's lowest point at 19th March (0.52), the stock price is 30.77% as valuable compared to beginning of the year (1.69).")
        ),
        selectInput(ns("groupAirasia"), 
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
        br(),

        h2("Petroleum (Petronas)"),
        p(
            "Secondly, another badly impacted industry is oil & gas, as MCO has kept people indoor. At some point of time, there was even news of ",
            a(href = "https://www.bbc.com/news/business-52350082", "negative oil price in US"),
            ". We look at Malaysia's national oil and gas company, Petronas Dagangan Berhad.",
            br(), br(),
            "The stock had been stable up until March, where it had a sharp decline. After MCO, it has been slowly recovering."
        ),
        selectInput(ns("groupPetronas"), 
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
        ),
        br(),
        br(),

        p(class="blockquote-reverse",
            "Data from ",
            a(href = "https://finance.yahoo.com/", "Yahoo Finance"),
            " using ",
            a(href = "https://cran.r-project.org/web/packages/quantmod/index.html", "quantmod"),
            " package"
        )
    )
}

stocks <- function(input, output, session) {
    # Dictionary to map period label to actual represented date
    periodMaps <- c(
        "6 months before MCO" = "2019-09-18",
        "3 months before MCO" = "2019-12-18",
        "MCO Starts" = "2020-03-18",
        "1 month after MCO" = "2020-04-18",
        "Now" = as.character(Sys.Date())
    )

    # Load stock data from Yahoo Finance
    allKlseStock <- getSymbols("^KLSE", src = "yahoo", from = "2019-09-18", to = as.character(Sys.Date()), auto.assign = FALSE);
    allAirasiaStock <- getSymbols("5099.KL", src = "yahoo", from = "2019-09-18", to = as.character(Sys.Date()), auto.assign = FALSE);
    allPetronasStock <- getSymbols("PETR.KL", src = "yahoo", from = "2019-09-18", to = as.character(Sys.Date()), auto.assign = FALSE);

    # Filter & group stock data
    groupedKlseStock <- reactive({
        klseStock <- allKlseStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$groupKlse == "weekly") return(apply.weekly(klseStock, mean))
        if (input$groupKlse == "monthly") return(apply.monthly(klseStock, mean))
        if (input$groupKlse == "daily") return(apply.daily(klseStock, mean))
    })

    groupedAirasiaStock <- reactive({
        airasiaStock <- allAirasiaStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$groupAirasia == "weekly") return(apply.weekly(airasiaStock, mean))
        if (input$groupAirasia == "monthly") return(apply.monthly(airasiaStock, mean))
        if (input$groupAirasia == "daily") return(apply.daily(airasiaStock, mean))
    })

    groupedPetronasStock <- reactive({
        petronasStock <- allPetronasStock[paste(periodMaps[input$period[1]], "::", periodMaps[input$period[2]], sep="")];

        if (input$groupPetronas == "weekly") return(apply.weekly(petronasStock, mean))
        if (input$groupPetronas == "monthly") return(apply.monthly(petronasStock, mean))
        if (input$groupPetronas == "daily") return(apply.daily(petronasStock, mean))
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

        if (input$groupKlse == "daily") {
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

        if (input$groupAirasia == "daily") {
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

        if (input$groupPetronas == "daily") {
            addBBands(); addVo(); addMACD();
        }
    })

    # Table Outputs
    output$klseTable = DT::renderDataTable({
        as.data.frame(groupedKlseStock())['KLSE.Close']
    }, colnames = c("Closing Price"), options = list(pageLength = 7))

    output$airasiaTable = DT::renderDataTable({
        as.data.frame(groupedAirasiaStock())['5099.KL.Close']
    }, colnames = c("Closing Price"), options = list(pageLength = 7))

    output$petronasTable = DT::renderDataTable({
        as.data.frame(groupedPetronasStock())['PETR.KL.Close']
    }, colnames = c("Closing Price"), options = list(pageLength = 7))
}