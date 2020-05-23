homeUI <- function(id) {
    ns <- NS(id)
    
    div(
        class="jumbotron",
        fluidPage(
            tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "css/home.css")
            ),

            h1(class="text-center", "CoronaJob"),
            h3(class="text-center", "An analysis on economic impact of COVID-19 towards Asia region")
        )
    )
}