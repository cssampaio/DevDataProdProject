library(shiny)

radioButtons

shinyUI(pageWithSidebar(
    headerPanel("Iris Dataset Prediction"),
    sidebarPanel(
        h3('Documentation'),
        p('This application shows predictions for Iris Dataset using caret package'),
        p('Select the desired input parameters: seed, ML method, training set partition'),
        p('Observe the results: accuracy, confusion matrix'),
        h3('Prediction parameters'),
        numericInput('seed', 'Choose seed', 5, min = 1, max = 10, step = 1),
        selectInput("method", label = "Choose ML method", 
                    choices = list("Decision Tree" = "rpart", "Random Forest" = "rf",
                                   "Boosting" = "gbm"), selected = "rpart"),
        sliderInput('partition', 'Choose training set partition', value = 0.6, min = 0.1, max = 0.9, step = 0.05)
        
    ),
    mainPanel(
        h3('Prediction results'),
        h4("Seed"),
        verbatimTextOutput("seed"),
        h4("ML method in caret package"),
        verbatimTextOutput("method"),
        h4("Training set partition"),
        verbatimTextOutput("partition"),
        h4("Accuracy"),
        verbatimTextOutput("accuracy"),
        h4("Confusion Matrix Plot"),
        plotOutput('newcm')
    )
))