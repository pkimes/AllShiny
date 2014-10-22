#' Server script for SHC example in Shiny
#'
#' @author Patrick Kimes


##necessary packages
library("shiny")
library("devtools")
library("ggplot2")
library("GGally")
##install_github("pkimes/sigclust2")
library("sigclust2")


##functions for setting simulation parameters
source("simulator.R")
source("helpers.R")


## Define server logic required to draw a histogram
shinyServer(function(input, output) {

    ##data for analysis
    data <- reactive({
        input$simulate
        isolate(
            simulator(input$n, input$p, input$delta,
                      input$K, input$arr)
        )
    })

    ##reactive for plotting PCA
    pca_data <- reactive({
        input$simulate
        isolate(
            prcomp(data())
        )
    })

    output$pca_plot <- renderPlot({
        ggpairs(pca_data()$x[, 1:min(3, input$p)], alpha=1/2)
    })

    
    ##reactive for plotting SHC ouput/dendrogram
    shc_data <- reactive({
        input$analyze
        isolate(
            shc(data(), input$diss, input$linkage, ci=input$ci_type)
        )
    })

    output$shc_plot <- renderPlot({
        plot(shc_data(), alpha=input$alpha, fwer=input$fwer, ci_emp=FALSE) +
            theme(legend.position="bottom")
    })

    
    
    output$arrangements <- renderUI({
        switch(input$K,
               "1" = selectInput("arr",
                   label = "arrangement:",
                   choices=c("N/A"),
                   selected=("N/A")),
               "2" = selectInput("arr",
                   label = "arrangement:",
                   choices=c("line"),
                   selected=("line")),
               "3" = selectInput("arr",
                   label = "arrangement:",
                   choices=c("line", "triangle"),
                   selected=("triangle")),
               "4" = selectInput("arr",
                   label = "arrangement:",
                   choices=c("line", "square", "tetra", "rect"),
                   selected=("square"))
               )
    })
                                    
})
