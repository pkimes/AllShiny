#' UI script for SHC example in Shiny
#'
#' @author Patrick Kimes

library(shiny)


shinyUI(fluidPage(
    titlePanel("Significance of Hierarchical Clustering"),
    fluidRow(
        column(
            4,
            ##separate pre-set, manual settings using tabs
            h3("Parameters"),
            wellPanel(
                tabsetPanel(
                    type="tabs",
                    tabPanel(
                        "Pre-set",
                        selectInput("select",
                                    label=h4("Default options"),
                                    choices=list(
                                        "Choice 1" = 1,
                                        "Choice 2" = 2,
                                        "Choice 3" = 3),
                                    selected = 1),
                        br(),
                        br(),
                        br(),
                        br(),
                        br()
                    ),
                    tabPanel(
                        "Manual",
                        fluidRow(
                            column(
                                5,
                                numericInput("n",
                                             label = h4("Sample size"),
                                             value = 100),
                                br(),
                                numericInput("p",
                                             label = h4("Dimension"),
                                             value = 100),
                                br(),
                                numericInput("delta", 
                                             label = h4(HTML("&delta;:")),
                                             value = 5)
                            ),
                            column(
                                5, offset=1,
                                selectInput("K",
                                            label = h4("Components"),
                                            choices=as.list(1:5),
                                            selected=1),
                                br(),
                                uiOutput("arrangements"),
                                br(),
                                br(),
                                br(),
                                br()
                            )
                        ),
                        br(),
                        br()
                    )
                ),
                actionButton("simulate", label="Simulate!"),
                br(),
                HTML("<hr>"),
                code("sigclust2"),
                " is written/maintained by ",
                a(href="http://pkimes.github.io", "Patrick Kimes"),
                br()##,
                ## br(),
                ## img(src="UNC_Lineberger.jpg", width=200)
            )
        ),
        column(
            4,
            h3("Raw Data", align="center"),
            plotOutput("raw_plot", width="100%")
        ),
        column(
            4,
            h3("PCA Data", align="center"),
            plotOutput("pca_plot", width="100%")
        )
    )
    ## br(),
    ## p("* build useful webapps..."),
    ## p("* blah blah blah...")
))



