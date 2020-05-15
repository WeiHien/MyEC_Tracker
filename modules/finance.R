library(readxl)

gdpGrowth <- as.data.frame(read_excel("data/imf-real-gdp-growth.xls"))
gdpGrowth <- gdpGrowth[,c("Real GDP growth (Annual percent change)", "2016", "2017", "2018", "2019", "2020")]
names(gdpGrowth)[names(gdpGrowth) == 'Real GDP growth (Annual percent change)'] <- 'Region'
gdpGrowth <- gdpGrowth[complete.cases(gdpGrowth),]


financeUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        titlePanel("Finance"),

        sidebarLayout(
            sidebarPanel(
                selectInput(ns("region"), 
                    label = "Real GDP Growth by region", 
                    choices = gdpGrowth["Region"],
                    selected = "Malaysia"
                ),
            ),

            mainPanel(
                plotOutput(ns("gdpGrowth")),
            ),
        ),
    )
}

finance <- function(input, output, session) {
    output$gdpGrowth <- renderPlot({
        plot(c("2016", "2017", "2018", "2019", "2020"), 
            gdpGrowth[gdpGrowth["Region"] == input$region, c("2016", "2017", "2018", "2019", "2020")], 
            type="l",
            main=input$region,
            xlab="Year",
            ylab="Real GDP Growth",
            ylim=c(-10, 10)
        )
        abline(h=0, lty=2, col="red")
    })
}