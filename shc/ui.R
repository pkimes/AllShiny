#' UI script for SHC example in Shiny
#'
#' @author Patrick Kimes

library(shiny)


shinyUI(fluidPage(

    includeCSS("styles.css"),
    
    titlePanel("Significance for Hierarchical Clustering"),

    fluidRow(
        column(
            4,
            ##separate pre-set, manual settings using tabs
            br(),
            wellPanel(
                tabsetPanel(
                    type="tabs",
                    tabPanel(
                        "Data Params:",
                        selectInput("K",
                                    label = "K:",
                                    choices=as.list(1:4),
                                    selected=1),
                        uiOutput("arrangements"),
                        numericInput("n",
                                     label = "n:",
                                     value = 50,
                                     min=2, max=100),
                        numericInput("p",
                                     label = "p:",
                                     value = 100,
                                     min=2, max=1000),
                        numericInput("delta", 
                                     label = HTML("&delta;:"),
                                     value = 5,
                                     min = 0),
                        br(),
                        br(),
                        br(),
                        actionButton("simulate", label="Simulate!"),
                        br()
                    ),
                    tabPanel(
                        "SHC Params:",
                        selectInput("diss",
                                    label = "Dissimilarity:",
                                    choices=list(
                                        "euclidean"),
                                    selected="euclidean"),
                        selectInput("linkage", 
                                    label = "Linkage:",
                                    choices=list(
                                        "ward.D2",
                                        "average",
                                        "single",
                                        "complete"),
                                    selected="Ward's"),
                        selectInput("ci_type",
                                    label = "Cluster Index:",
                                    choices=list(
                                        "2CI",
                                        "linkage"),
                                    selected = "2CI"),
                        numericInput("alpha",
                                     label = HTML("&alpha;:"),
                                     value = 0.05,
                                     step = 0.01),
                        checkboxInput("fwer",
                                      label = "FWER:",
                                      value = TRUE),
                        br(),
                        br(),
                        br(),
                        br(),
                        actionButton("analyze", label="Analyze!"),
                        br()
                    ),
                    tabPanel(
                        "Arguments:",
                        code("K"), ": number of underlying normal components",
                        br(),
                        code("arr."), ": arrangement of component means",
                        br(),
                        code("n"), ": per-component sample size",
                        br(),
                        code("p"), ": dimension of problem",
                        br(),
                        code(HTML("&delta;")), ": dimension of problem",
                        br(),
                        br(),
                        code("Dissimilarity"), ": dissimilarity for hierarchical clustering",
                        br(),
                        code("Linkage"), ": linkage for hierarchical clustering",
                        br(),
                        code("Cluster Index"), ": measure of strength of clustering",
                        br(),
                        code(HTML("&alpha;")), ": significance threshold",
                        br(),
                        code("FWER"), ": whether to use FWER control",
                        br(),
                        br(),
                        br()
                    )
                ),
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
            6,
            skip=2,
            tabsetPanel(
                type="tabs",
                tabPanel(
                    h3("PCA view", align="center"),
                    plotOutput("pca_plot", width="100%")
                ),
                tabPanel(
                    h3("Dendrogram", align="center"),
                    plotOutput("shc_plot", width="100%")
                )
            )
        )
    )
    ## br(),
    ## p("* build useful webapps..."),
    ## p("* blah blah blah...")
))



