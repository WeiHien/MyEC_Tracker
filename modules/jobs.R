library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)
library(dplyr)
library(DT)

mev <- as.data.frame(read.csv("data/Compilation of Economy Factors.csv",stringsAsFactors = FALSE))
mev$Year <- as.Date(c(mev$Year),format="%m/%d/%Y")
mev <- subset(mev, Year >= as.Date("2018-01-01") )

jobsUI <- function(id) {
  ns <- NS(id)
  
  fluidPage(
    titlePanel("Unemployment Rate"),
    p(class = "lead",
      "For insight on job market impact, let's look at the monthly unemployment rate. Unemployment rate was peaked at March 2020, i.e. 3.9% over 5 years. It is highly related 
      to government decision on release the Movement Control Order at 16 March 2020."
    ),
    br(),

    # Date range for the time serios
    sliderInput(ns("Year"),
      label = "Date Range",
      min = as.Date("2018-01-01"),
      max = max(mev$Year),
      value = c(as.Date("2019-01-31"),max(mev$Year)),
      timeFormat="%b %Y",
      width = "100%"
    ),
    br(),
    
    div(class = "row",
        div(class = "col-md-8",
            plotlyOutput(ns("distplot")),
        ),

        div(class = "col-md-4",
            DT::dataTableOutput(ns("unemploymentTable"))
        ),
    ),
    br(),

    p(class="blockquote-reverse",
        "Data from ",
        a(href = "https://www.bnm.gov.my/index.php?ch=statistic_nsdp&pg=statistic_nsdp_labor_unemp_mth&lang=en", "Bank Negara Malaysia")
    )
  )
}

jobs <- function(input, output, session) {
  rownames(mev) <- format(mev$Year,"%B %Y")

  dat <- reactive({
    mev <- mev[mev$Year %in% seq(from=min(input$Year[1]),to=max(input$Year[2]),by=1),]
    mev$Year <- as.Date(format(as.Date(mev$Year, "%Y-%m-%d"), "%Y-%m-01"))
    mev$Month <- row.names(mev)
    mev
  })

  output$distplot <- renderPlotly({ 
    data <- dat()$Unemployment
    interval <- ceiling(nrow(dat()) / 10)

    p <- ggplot(dat(), aes_string(dat()$Year, data, Period="Month", "Rate (%)"=data, group=1)) + geom_line(color = 'red') + geom_point(color = 'red') + 
      xlab("Month") + ylab("Unemployment Rate (%)") + scale_x_date(date_breaks = paste(interval, "month"), date_labels = "%b %Y")
    ggplotly(p, tooltip=c("Period", "Rate (%)"))
  })

  output$unemploymentTable = DT::renderDataTable({
    dat()[rev(order(dat()$Year)),]['Unemployment.Rate....']
  }, colnames = c("Unemployment Rate (%)"))
}