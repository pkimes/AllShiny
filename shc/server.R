#' Server script for SHC example in Shiny
#'
#' @author Patrick Kimes


##necessary packages
library(shiny)
library(devtools)
install_github("pkimes/sigclust2")
library(sigclust2)


##functions for setting simulation parameters
source("helpers.R")


## Define server logic required to draw a histogram
shinyServer(function(input, output) {

    data <- reactive({
        input$simulate
        isolate(
            if (input$K == 1) {
                matrix(rnorm(input$n * input$p,
                             mean=input$delta),
                       input$n, input$p)
            } else if (input$K == 2) {
                rbind(
                    matrix(rnorm(input$n * input$p,
                                 mean=input$delta),
                           input$n, input$p),
                    matrix(rnorm(input$n * input$p,
                                 mean=-input$delta),
                           input$n, input$p)
                )
            } else {
               rbind(
                    matrix(rnorm(input$n * input$p,
                                 mean = input$delta),
                           input$n, input$p),
                    matrix(rnorm(input$n * input$p,
                                 mean = -input$delta),
                           input$n, input$p),
                    matrix(rnorm(input$n * input$p,
                                 mean = 0),
                           input$n, input$p)
               )
           }
        )
    })
    
    output$raw_plot <- renderPlot({
        plot(data()[, 1:2])
    })

    output$pca_plot <- renderPlot({
        pca <- prcomp(data())
        plot(pca$x[, 1:2])
    })

    output$shc_plot <- renderPlot({
        out <- shc(data(), "euclidean", "ward.D2")
        plot(out)
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
