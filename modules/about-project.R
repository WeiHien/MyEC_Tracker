aboutProjectUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        div(class ="col-md-10 col-md-offset-1",
            h1(class = "text-primary text-center",
                "Motivation"
            ),
            br(), br(),

            p(class = "lead", 
                "Amid the global pandemic of COVID-19, we would like to seek for an insight about this,"
            ),

            h2(class = "text-center text-primary", 
                em("What are the economical impacts?")
            ),
            br(), br(),

            p(class = "lead", 
                "The team comes out with the idea of creating a Shiny app regarding current pandemic, i.e. COVID-19 pandemic against the economic factors in Asia. 
                However, our main concern was the data sources available for the topic. We then started to search accessible data sources for our project. Unfortunately, 
                it is much more difficult to access to every economy data for Asia countries. Hence, we narrowed down coverage to only Malaysia."
            )
        )
    )
}