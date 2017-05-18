library(shiny)

shinyUI(
  navbarPage("MTCars Dataset Application",
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("The relationship between variables and Temperature"),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Month" = "Month",
                                          "Day" = "Day",
                                          "Wind" = "Wind"
                                        )),
                            
                            checkboxInput("outliers", "Show BoxPlot's outliers", FALSE)
                          ),
                          
                          mainPanel(
                            h3(textOutput("caption")),
                            
                            tabsetPanel(type = "tabs", 
                                        tabPanel("BoxPlot", plotOutput("mpgBoxPlot")),
                                        tabPanel("Regression model", 
                                                 plotOutput("mpgPlot"),
                                                 verbatimTextOutput("fit")
                                        )
                            )
                          )
                        )
                      )
             )
  )
)
