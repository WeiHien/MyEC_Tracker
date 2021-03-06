aboutUsUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        h1(class = "text-primary text-center",
            "We are Group A"
        ),
        br(), br(),

        div(class = "row",
            div(class = "col-md-3",
                img(class = "img-responsive", src = "images/team-member-1.jpg"),
                br(),
                h4(class = "text-center", "Ng Keat Zhao"),
                h4(class = "text-center", "(A17217743)"),
            ),
            div(class = "col-md-3",
                img(class = "img-responsive", src = "images/team-member-2.jpg"),
                br(),
                h4(class = "text-center", "Ang Lin Siang"),
                h4(class = "text-center", "(A17174507)"),
            ),
            div(class = "col-md-3",
                img(class = "img-responsive", src = "images/team-member-3.jpg"),
                br(),
                h4(class = "text-center", "Cheong Wei Hien"),
                h4(class = "text-center", "(A17218461)"),
            ),
            div(class = "col-md-3",
                img(class = "img-responsive", src = "images/team-member-4.jpg"),
                br(),
                h4(class = "text-center", "Lai Hoi Yee"),
                h4(class = "text-center", "(A17218659)"),
            ),
        )
    )
}