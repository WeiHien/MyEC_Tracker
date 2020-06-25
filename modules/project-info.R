projectInfoUI <- function(id) {
    ns <- NS(id)
    
    fluidPage(
        div(class ="col-md-10 col-md-offset-1",
            h1(class = "text-primary text-center",
                "Project Info"
            ),
            br(), br(),

            h3(class = "text-primary", "Section"),
            a(href = "#background-section", "A. Background"), br(),
            a(href = "#quick-explanation-section", "B. Quick Explanation"), br(),
            a(href = "#observation-section", "C. Interesting Observation"), br(),
            a(href = "#guideline-section", "D. User Guideline"), br(),
            a(href = "#data-timeframe-section", "E. Data Timeframe"), br(),
            a(href = "#experience-section", "F. Summary of Experiences"), br(),
            a(href = "#project-link-section", "G. Relevent Project Link"), br(),
            a(href = "#reference-section", "H. References"), br(),
            br(), br(),

            h3(class = "text-primary", "Background", id = "background-section"),
            br(),

            p(class="lead", "The outbreak of a novel pandemic across worldwide countries, which is COVID-19, has become a global concern amongst 
            people today. Notwithstanding, nobody would know at the point when will the discovery of precise treatment happen to 
            stop the current pandemic. Most of the information regarding this pandemic outbreak is solely came from \"News Article\" 
            and \"Report\"."),

            p(class="lead", "Although some visualization dashboards for COVID-19 pandemic are created recently, but there is less or no one has built 
            it in the context of its impact to economic factors especially in Malaysia, such as the comparison between before and after 
            the outbreak. Thereby, this project aims to bring some insights to public society regarding COVID-19 and its impact on 
            economics in Malaysia."),
            br(), br(),

            h3(class = "text-primary", "Quick Explanation", id = "quick-explanation-section"),
            br(),

            p(class="lead", strong("COVID-19"), " - Coronavirus disease (COVID-19) is an infectious disease caused by a newly discovered coronavirus. 
            Most people infected with the COVID-19 virus will experience mild to moderate respiratory illness and recover without requiring special treatment."),

            p(class="lead", strong("Unemployment Rate (UR)"), " - Unemployment rate is the share of the labour force that is jobless, expressed as a percentage. 
            This can used to assess the economics situation of a country."),

            p(class="lead", strong("Consumer Pricing Index (CPI)"), " - Consumer Price Index (CPI) is a measure that examines the weighted average of 
            prices of a basket of consumer goods and services, such as transportation, food, and medical care.  Changes in the CPI are 
            used to assess price changes associated with the cost of living."),

            p(class="lead", strong("Weighted Average Lending Rate (WALR)"), " - WALR is the aggregate rate of interest paid on all debt divided by 
            the total amount of debt in the measurement period. It shows the average interest rate in the current economy."),

            p(class="lead", strong("Exchange Rate (ER)"), " - ER is the value of one nation's currency versus the currency of another nation or 
            economic zone. For example, how many MYR does it take to buy one U.S. Dollar?"),

            p(class="lead", strong("Stock Index (SI)"), " - SI is a method used to measure the performance of a basket of securities intended to 
            replicate a certain area of the market."),

            p(em("**Note: All of the definitions above are taken from",  strong("\"Investopedia\","), " except COVID-19 from World Health Organization (WHO).")),
            br(), br(),

            h3(class = "text-primary", "Interesting Observation Found", id = "observation-section"),
            br(),

            p(class="lead", "1. As shown on the chart, all of the economics factors (limited to 4 factors) of Malaysia analysed in this app 
            have experienced a significant negative impact, such as a drop in the consumer price index, weighted average 
            lending rate, and a rise in the unemployment and exchange rate after the pandemic outbreak. The effect is lagging 
            after the outbreak of COVID-19 in March 2020."),

            p(class="lead", "2. As shown on the chart, Malaysia’s FTSE Bursa Malaysia KLCI stock index has experienced a significant drop 
            during March 2020 when the media announced the outbreak of COVID-19 in Malaysia. However, after the government 
            of Malaysia has taken some immediate actions to curb the spread of COVID-19 such as Movement Control Order (MCO), 
            the confident of market started to recover steadily."),

            p(class="lead", "3. Even the confident of market has started to recover steadily, but particular stocks such as aviation or tourism 
            related are still struggling until today (15 June 2020) due to people are still afraid of travelling especially by 
            using airline (limited space within)."),
            br(), br(),

            h3(class = "text-primary", "User Guideline", id = "guideline-section"),
            br(),

            div(img(class = "img-responsive center-block", src = "images/table-functions.png", style="height: 50px")),
            br(),
            p(class="lead", "Whenever you see this kind of \"search box\",  it allows you to search for whatever you want that is applicable in the 
            table. For example, date, number or state. Also, it allows you to choose to show only the number of entries that you are 
            interested in."),

            div(img(class = "img-responsive center-block", src = "images/select-dropdown.png", style="height: 70px")),
            br(),
            p(class="lead", "Whenever you see this kind of “side bar”,  it allows you to filter/choose a particular factor to look for."),

            div(img(class = "img-responsive center-block", src = "images/date-slider.png", style="height: 80px")),
            br(),
            p(class="lead", "Whenever you see this kind of “slider bar”,  it allows you to select a range of date that you are interested in."),
            br(), br(),

            h3(class = "text-primary", "Data timeframe", id = "data-timeframe-section"),
            br(),

            p(class="lead", "- The Malaysia’s COVID-19 data used in this app is from January 2020 until 15 June 2020 only. This is due to a lack of 
            reliable source to design for an automatic data update in this app."),

            p(class="lead", "- All of the economics factors studied in this app are up to April 2020 only except weighted average lending rate, which 
            is up to March 2020 only. This is due to lagging of announcement by relevant authority."),

            p(class="lead", "- The stock index in this app will keep pulling the latest data from the application software interface (API) if the 
            users slide the timeframe available to “now”."),
            br(), br(),

            h3(class = "text-primary", "Summary of Experiences", id = "experience-section"),
            br(),

            p(class="lead", "- From this project, we learned how to build a basic Shiny application from scratch, with limited knowledge at initial."),

            p(class="lead", "- Due to lack of accessibility and completeness of data sources, we have to narrow down our coverage to only Malaysia."),

            p(class="lead", "- After this project, we have become more familiar with the data science pipeline and its application."),

            p(class="lead", "- Additionally, we have improved our coding knowledge and skills."),
            br(), br(),

            h3(class = "text-primary", "Relevant Project Links", id = "project-link-section"),
            br(),

            p(class="lead", "Source Code: ", a(href="https://github.com/WeiHien/MyEC_Tracker", icon("github"), "GitHub")),
            p(class="lead", "Presentation Video: "),
            div(class = "embed-responsive embed-responsive-16by9",
                HTML('<iframe width="560" height="315" src="https://www.youtube.com/embed/C6BKrsEcLYI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>')
            ),
            br(), br(),

            h3(class = "text-primary", "References", id = "reference-section"),
            br(),

            p("1. Calculating the weighted average interest rate. (2020). In accountingtools. Retrieved June 15, 2020, from https://www.accountingtools.com/articles/calculating-the-weighted-average-interest-rate.html"),
            p("2. Chen, J. (2020, January 31). Exchange Rate Definition. Retrieved June 15, 2020, from https://www.investopedia.com/terms/e/exchangerate.asp"),
            p("3. Chappelow, J. (2020, February 1). Unemployment Rate. Retrieved June 15, 2020, from https://www.investopedia.com/terms/u/unemploymentrate.asp"),
            p("4. Chen, J. (2020, April 23). Consumer Price Index (CPI). Retrieved June 15, 2020, from https://www.investopedia.com/terms/c/consumerpriceindex.asp"),
            p("5. Chen, J. (2020, May 24). Index. Retrieved June 15, 2020, from https://www.investopedia.com/terms/i/index.asp"),
            p("6. COVID-19 Outbreak Live Updates. (n.d.). Retrieved June 15, 2020, from https://www.outbreak.my/"),
            p("7. Learn Shiny. (n.d.). Retrieved June 15, 2020, from https://shiny.rstudio.com/tutorial/"),
            p("8. RStudio Support. (2020, June 11). Authoring R Presentations. Retrieved June 15, 2020, from https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations"),
            p("9. World Health Organization. (n.d.). Coronavirus. Retrieved June 15, 2020, from https://www.who.int/health-topics/coronavirus#tab=tab_1"),
            br(), br(),
        )
    )
}