# MyEC Tracker

A Shiny app to illustrate the economics impacts of COVID-19 outbreak to Malaysia (https://group-a-principle-data-science.shinyapps.io/myec-tracker)

## To run directly from GitHub:
```R
# R console
library(shiny)

runGitHub( "MyEC_Tracker", "WeiHien")
```

## To run locally and contribute:
- Clone the repo
```
git clone https://github.com/WeiHien/MyEC_Tracker.git
```

- Run the app locally
```R
# R console
library(shiny)

runApp( "MyEC_Tracker")
```

- Switch to new Git branch before making changes
```
git checkout -b {BRANCH_NAME}
```

- After done making changes, stage, commit and push the branch
```
// Stage all changes
git add .

// Commit staged changes
git commit -m "{COMMIT_MESSAGE}"

// Push the new branch
git push --set-upstream origin {BRANCH_NAME}
```

- Go to GitHub and click "Pull Request". Select your branch and create.
- Pull Request must be approved by any other collaborator before it is merged into master branch.

## Code Structure
Each pages is separated into different file inside modules directory.

To add new page (eg Job page):
- Load the module (file) in app.R
```R
source("modules/jobs.R")
```

- For UI part of pages, register on app.R
```R
ui <- navbarPage(
  ...
  tabPanel("Jobs", jobsUI(id = "jobs")),
)
```

- For server part, register on app.R
```R
server <- function(input, output, session) {
  ...
  callModule(module = jobs, id = "jobs")
}
```
