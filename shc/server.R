#' Server script for SHC example in Shiny
#'
#' @author Patrick Kimes

library(shiny)

## Define server logic required to draw a histogram
shinyServer(function(input, output) {

    data <- reactive({
        input$simulate
        isolate(
            matrix(rnorm(input$n * input$p,
                         mean=input$delta),
                   input$n, input$p)
            )
    })
    
    output$raw_plot <- renderPlot({
        plot(data()[, 1:2])
    })

    output$pca_plot <- renderPlot({
        pca <- prcomp(data())
        plot(pca$x[, 1:2])
    })

    output$arrangements <- renderUI({
        switch(input$K,
               "1" = selectInput("arr",
                   label = h4("Arrangement1"),
                   choices=c("N/A"),
                   selected=("N/A")),
               "2" = selectInput("arr",
                   label = h4("Arrangement2"),
                   choices=c("line"),
                   selected=("line")),
               "3" = selectInput("arr",
                   label = h4("Arrangement3"),
                   choices=c("line", "triangle"),
                   selected=("triangle")),
               "4" = selectInput("arr",
                   label = h4("Arrangement4"),
                   choices=c("line", "square", "tetra", "rect"),
                   selected=("square")),
               "5" = selectInput("arr",
                   label = h4("Arrangement5"),
                   choices=c("line", "other"),
                   selected=("other"))
               )
    })
                                    
})
