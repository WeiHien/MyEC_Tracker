library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)
library(dplyr)

mev <- as.data.frame(read.csv("data/Compilation of Economy Factors.csv",stringsAsFactors = FALSE))
mev$Year <- as.Date(c(mev$Year),format="%m/%d/%Y")
factor <- list("Consumer Price Index", "Weighted Average Lending Rate", "Exchange Rate (USD)")

financeUI <- function(id) {
  ns <- NS(id)
  
  fluidPage(
    titlePanel("Economic Factors"),
    
    sidebarLayout(
      sidebarPanel(
        # Filter of economic factors
        selectInput(ns("factorinput"), 
                    label = "Economic Factor", 
                    choices = c("Consumer Price Index", 
                                "Weighted Average Lending Rate", 
                                "Exchange Rate (USD)"),
                    selected = "Consumer Price Index"),
        
        # Date range for the time serios
        sliderInput(ns("Year"),
                    label = "Date Range",
                    min = min(mev$Year),
                    max = max(mev$Year),
                    value = c(as.Date("2019-01-31"),max(mev$Year)),
                    timeFormat="%b %Y"),
      ),
      
      mainPanel(
        p(class = "lead", "To illustrate the economic impact, the chart below presents various key economic factors"),
        
        textOutput(ns("desc")),
        br(),

        plotlyOutput(ns("distplot")),
        br(),

        p(class="blockquote-reverse",
            "Data from ",
            a(href = "https://www.bnm.gov.my/index.php?ch=statistic_nsdp&pg=statistic_nsdp_labor_unemp_mth&lang=en", "Bank Negara Malaysia")
        )
      ),
    ),
  )
}

finance <- function(input, output,session) {
  output$desc <- renderText({
    desc <- switch(input$factorinput, 
      "Consumer Price Index" = "Similar to Consumer Price Index, due to the order released by government, CPI has dropped from February to March, 122.4 to 120.9
         respectively.",
      "Weighted Average Lending Rate" = "Weighted Average Lending Rate was remaining stable at around 5.2% during second half of Year 2019 nevertheless it started 
        to fell at January 2020 and by far, March 2020 has the lowest lending rate, i.e. 4.8% over 5 years.",
      "Exchange Rate (USD)" = "")

    desc
  })

  dat <- reactive({
    mev = mev[mev$Year %in% seq(from=min(input$Year[1]),to=max(input$Year[2]),by=1),]
    mev$Year <- as.Date(format(as.Date(mev$Year, "%Y-%m-%d"), "%Y-%m-01"))
    mev$Month <- format(mev$Year,"%B %Y")
    mev
  })

  output$distplot <- renderPlotly({ 
    data <- switch(input$factorinput, 
      "Consumer Price Index" = dat()$Consumer.Price.Index,
      "Weighted Average Lending Rate" = dat()$Weighted.Average.Lending.Rate,
      "Exchange Rate (USD)" = dat()$Exchange.Rate..USD.,)
    interval <- ceiling(nrow(dat()) / 10)
    
    p <- ggplot(dat(), aes_string(x=dat()$Year, y=data, Period="Month", Value=data, group=1)) + ggtitle(input$factorinput) + geom_line(color = 'red') + geom_point(color = 'red') + xlab("Month") + ylab(input$factorinput) + 
      scale_x_date(date_breaks = paste(interval, "month"), date_labels = "%b %Y")
    ggplotly(p, tooltip=c("Period", "Value"))
  })
}