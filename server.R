library(shiny)
library(UsingR)
library(ggplot2)
library(caret)
library(rpart)
library(randomForest)
library(gbm)
library(e1071)
data(iris)

shinyServer(
    function(input, output) {
        
        s <- reactive({as.numeric(input$seed)})
        p <- reactive({as.numeric(input$partition)})
        m <- reactive({(input$method)})
        
        output$seed <- renderText({s()})
        output$partition <- renderText({p()})
        output$method <- renderText({m()})
        
        output$accuracy <- renderText({
            set.seed(s())
            inTrain <- createDataPartition(y = iris$Species, p = p(), list = FALSE)
            training <- iris[inTrain,]
            testing <- iris[-inTrain,]
            
            modFit <- train(Species ~ ., method = m(), data = training)
            predictions <- predict(modFit, testing)
            
            cm <- confusionMatrix(predictions, testing$Species)
            round(cm$overall['Accuracy'],3)
        })
        
        output$newcm <- renderPlot({
            set.seed(s())
            inTrain <- createDataPartition(y = iris$Species, p = p(), list = FALSE)
            training <- iris[inTrain,]
            testing <- iris[-inTrain,]
            
            modFit <- train(Species ~ ., method = m(), data = training)
            predictions <- predict(modFit, testing)
            
            results <- data.frame(pred = predictions, obs = testing$Species)
            p <- ggplot(results, aes(x = pred, y = obs, color = factor(pred)))
            p <- p + labs(title = "Confusion Matrix", x = "Predictions", y = "Observations") + 
                scale_color_discrete(name="Predictions") +
                geom_jitter(position = position_jitter(width = 0.25, height = 0.25))
            p
        })
    }
)