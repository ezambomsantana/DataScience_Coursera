library(shiny)
library(datasets)

airData <- airquality

shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("Temp ~", input$variable)
  })
  
  formulaTextPoint <- reactive({
    paste("Temp ~", "as.integer(", input$variable, ")")
  })
  
  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data=airData)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$mpgBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = airData,
            outline = input$outliers)
  })
  
  output$fit <- renderPrint({
    summary(fit())
  })
  
  output$mpgPlot <- renderPlot({
    with(airData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })
  })
  
})
