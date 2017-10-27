library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Prediction App"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("entry",
                h5("Put your text here:"),
                ""),
      submitButton("SUBMIT"),
      br(),
      helpText("Help Instruction:"),
      helpText("To predict the next word, type a
                     sentence into the input box and press SUBMIT.
                     Enjoy!",style = "color:blue")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
        tabPanel("Prediction",
                 h3("Word Prediction"),
                 h5('The sentence you just typed:'),                             
                 span(h4(textOutput('sent')),style = "color:blue"),
                 br(),
                 h5('Single Word Prediction:'),
                 span(h4(textOutput('top1')),style = "color:red"),
                 br(),
                 h5('Other Possible Single Word Prediction:'),
                 span(h5(textOutput('top2')),style = "color:green"),
                 span(h5(textOutput('top3')),style = "color:green"),
                 span(h5(textOutput('top4')),style = "color:green"),
                 span(h5(textOutput('top5')),style = "color:green"),
                 br(),
                 p('More details of the prediction algorithm and source codes', 
                   code("prediction.R"), code("server.R"), code("ui.R"), 
                   'cand be found in other Tags.')),
        tabPanel("teste",
                 h3("teste"))
      )
    )
  )
))
