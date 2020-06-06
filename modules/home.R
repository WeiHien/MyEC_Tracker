homeUI <- function(id) {
    ns <- NS(id)
    
    div(
        class = "jumbotron",
        fluidPage(
            tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "css/styles.css"),
                tags$link(rel = "stylesheet", type = "text/css", href = "css/home.css")
            ),

            h1(class = "text-center", "CoronaJob"),
            h3(class = "text-center", "An analysis on economic & financial impacts of COVID-19 towards Malaysia"),

            div(class = "row mt-16",
                div(class = "col-md-4",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h2(
                                class = "panel-title", 
                                icon("line-chart", "fa-2x"),
                                "Confirmed Cases"
                            )
                        ),
                        div(class="panel-body", "1.234k")
                    )
                ),

                div(class = "col-md-4",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h3(
                                class = "panel-title", 
                                icon("line-chart", "fa-2x"),
                                "Recovered Cases"
                            )
                        ),
                        div(class="panel-body", "1.234k")
                    )
                ),
                
                div(class = "col-md-4",
                    div(class = "panel panel-primary",
                        div(class = "panel-heading",
                            h3(
                                class = "panel-title", 
                                icon("line-chart", "fa-2x"),
                                "Hospitalized"
                            )
                        ),
                        div(class="panel-body", "1.234k")
                    ),
                ),
            )
        )
    )
}