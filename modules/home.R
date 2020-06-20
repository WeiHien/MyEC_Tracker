library(dplyr)
library(DT)

data.raw <- read.csv("data/COVID19_MY.csv")
data_state <- read.csv("data/COVID19_State.csv")

homeUI <- function(id) {
    ns <- NS(id)
    
    div(
        class = "jumbotron",
        fluidPage(
            tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
                tags$link(rel = "stylesheet", type = "text/css", href = "css/home.css")
            ),

            h1(class = "text-center", "MyEC Tracker"),
            h3(class = "text-center", "An analysis on economic & financial impacts of COVID-19 towards Malaysia"),

            div(class = "row mt-16",
                div(class = "col-md-3",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h2(
                                class = "panel-title", 
                                icon("line-chart", "fa-2x"),
                                "Confirmed Cases"
                            )
                        ),
                        div(class="panel-body", 
                            h4(
                                last(data.raw)$total_cases, 
                                span(class = "small", 
                                    paste0("(", last(data.raw)$date, ")")
                                )
                            ),
                        )
                    )
                ),

                div(class = "col-md-3",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h3(
                                class = "panel-title", 
                                icon("ambulance", "fa-2x"),
                                "Active Cases"
                            )
                        ),
                        div(class="panel-body", 
                            h4(
                                last(data.raw)$active_cases, 
                                span(class = "small", 
                                    paste0("(", last(data.raw)$date, ")")
                                )
                            ),
                        )
                    )
                ),
                
                div(class = "col-md-3",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h3(
                                class = "panel-title", 
                                icon("stethoscope", "fa-2x"),
                                "Recovered Cases"
                            )
                        ),
                        div(class="panel-body", 
                            h4(
                                last(data.raw)$total_recover, 
                                span(class = "small", 
                                    paste0("(", last(data.raw)$date, ")")
                                )
                            ),
                        )
                    ),
                ),

                div(class = "col-md-3",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h3(
                                class = "panel-title", 
                                icon("bed", "fa-2x"),
                                "Death Cases"
                            )
                        ),
                        div(class="panel-body", 
                            h4(
                                last(data.raw)$total_deaths, 
                                span(class = "small", 
                                    paste0("(", last(data.raw)$date, ")")
                                )
                            ),
                        )
                    ),
                ),
            ),

            h3(class = "text-center mb-8", "Summary of COVID-19 Cases in Malaysia"),
            div(class = "row mb-16",
                div(class = "col-md-12",
                    plotlyOutput(ns("summaryPlot")),
                ),
            ),

            h3(class = "text-center mb-8", "Cumulative Confirmed Case of Each State in Malaysia"),
            div(class="row mb-16",
                div(class = "col-md-6",
                    plotlyOutput(ns("cumulativePlot")),
                ),

                div(class = "col-md-6",
                    DT::dataTableOutput(ns("cumulativeTable"))
                ),
            ),
        )
    )
}

home <- function(input, output, session) {
    data_state$date <- as.Date(format(as.Date(data_state$date, "%d/%m/%Y"), "%Y-%m-%d"))

    confirmed_color <- "#ff7f0e"
    active_color <- "yellow"
    recovered_color <- "forestgreen"
    death_color <- "red"

    output$summaryPlot <- renderPlotly({ 
        plotly::plot_ly(data = data.raw) %>%
        plotly::add_trace(
            x = ~date,
            y = ~total_cases,
            type = "scatter",
            mode = "lines",
            name = "Confirmed",
            line = list(color = confirmed_color)
        ) %>%
        plotly::add_trace(
            x = ~date,
            y = ~total_deaths,
            type = "scatter",
            mode = "lines",
            name = "Death",
            line = list(color = death_color)
        ) %>%
            plotly::add_trace(
            x = ~date,
            y = ~total_recover,
            type = "scatter",
            mode = "lines",
            name = "Recovered",
            line = list(color = recovered_color)
        ) %>%
            plotly::add_trace(
            x = ~date,
            y = ~active_cases,
            type = "scatter",
            mode = "lines",
            name = "Active",
            line = list(color = active_color)
        ) %>%
        plotly::add_annotations(
            x = as.Date("2020-01-24"),
            y = 1,
            text = paste("First case","(Jan 24)", sep="\n"),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = -10,
            ay = -50,
            font = list(color = '#7f7f7f')
        ) %>%
        plotly::add_annotations(
            x = as.Date("2020-03-17"),
            y = 2,
            text = paste("First death","(Mar 17)", sep="\n"),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = -90,
            ay = -60,
            font = list(color = '#7f7f7f')
        ) %>%
        plotly::add_annotations(
            x = as.Date("2020-03-18"),
            y = 5,
            text = paste(
            "MCO Started","(Mar 18)", sep="\n"
            ),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = -10,
            ay = -130,
            font = list(color = '#7f7f7f', face="bold")
        ) %>%
            plotly::add_annotations(
            x = as.Date("2020-06-04"),
            y = 8247,
            text = paste(
            "Highest daily case","(Jun 4)", sep="\n"
            ),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = -30,
            ay = -30,
            font = list(color = '#ff7f0e')
        ) %>%
        plotly::add_annotations(
            x = as.Date("2020-03-29"),
            y = 14,
            text = paste(
            "Highest daily death","(Mar 29)", sep="\n"
            ),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = 30,
            ay = 30,
            font = list(color = 'red')
        ) %>%
            plotly::add_annotations(
            x = as.Date("2020-04-06"),
            y = 1241,
            text = paste(
            "Highest daily recovered","(Apr 6)", sep="\n"
            ),
            xref = "x",
            yref = "y",
            arrowhead = 5,
            arrowhead = 3,
            arrowsize = 1,
            showarrow = TRUE,
            ax = 140,
            ay = -10,
            font = list(color = 'green')
        ) %>%
        plotly::layout(
            title = NULL,
            yaxis = list(title = "Cumulative Number of Cases", showgrid=F),
            xaxis = list(title = "Date", showgrid=F),
            legend = list(x = 0.1, y = 0.9),
            plot_bgcolor='white',
            hovermode = "compare"
        )
    })

    output$cumulativePlot <- renderPlotly({ 
        max_date <- max(data_state$date)
        data_state %>% 
        dplyr::filter(date == max_date) %>%
        dplyr::group_by(state) %>%
        dplyr::summarise(total = total_cases) %>%
        dplyr::arrange(total) %>%
        dplyr::mutate(state = factor(state, levels = state)) %>%
        dplyr::ungroup() %>%
        dplyr::top_n(n = 16, wt = total) %>%
        plotly::plot_ly(x = ~ total,
                        y = ~ state,
                        text = ~ total,
                        textposition = 'auto',
                        type = "bar",
                        orientation = 'h') %>%
        plotly::layout(yaxis = list(title = ""),
                        xaxis = list(title = "Cumulative Confirmed Cases"),
                        title = NULL)
    })

    output$cumulativeTable = DT::renderDataTable({
        data_state[rev(order(data_state$date)),]
    }, rownames = FALSE, colnames = c("Date", "State", "Total Cases", "Total Deaths"))
}