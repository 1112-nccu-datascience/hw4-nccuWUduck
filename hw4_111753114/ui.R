library(ggvis)
library(shiny)


shinyUI(
  navbarPage(
    title = "HW4",
    tabPanel("PCA",
             fluidPage(
               titlePanel("PCA"),
               sidebarLayout(
                 sidebarPanel(
                   "variable",
                   sliderInput("n", "Number of points", min = 1, max = nrow(iris),
                               value = 50, step = 1),
                   uiOutput("plot_ui"),
                   checkboxGroupInput("var.levels",
                                      label = "請選擇",
                                      choices = list("Sepal.Length" = 1,
                                                     "Sepal.Width" = 2,
                                                     "Petal.Length" = 3,
                                                     "Petal.Width" = 4),
                                      selected = c(1, 2, 3, 4)),
                   selectInput("x_axis", label = h3("x_axis"),
                               choices = list("PCA 1" = 1,
                                              "PCA 2" = 2,
                                              "PCA 3" = 3,
                                              "PCA 4" = 4),
                               selected = 1),
                   selectInput("y_axis", label = h3("y_axis"),
                               choices = list("PCA 1" = 1,
                                              "PCA 2" = 2,
                                              "PCA 3" = 3,
                                              "PCA 4" = 4),
                               selected = 2)
                 ),
                 mainPanel(
                   "PCA GRAPH",
                   plotOutput("output_g", height = "700px", width = "100%"),
                   tableOutput("pca_table"),
                   tableOutput("a1123")
                 )
               )
             )
    ),
    tabPanel("CA",
             fluidPage(
               titlePanel("CA"), 
               sidebarPanel(
                 # 輸入元件
                 checkboxGroupInput("var_levels", "選擇變數",
                                    choices = colnames(iris)[-5],
                                    selected = colnames(iris)[-5]),
                 numericInput("num_clusters", "聚類數量", value = 3, min = 1, max = 10),
                 actionButton("run_ca", "執行CA分析")
               ),
               mainPanel(
                 plotOutput("output_ca")
               )
             
             )
    ),
    tabPanel("DATA",
             fluidPage(
               titlePanel("DATA"),
               tableOutput("orgin")
    )
  )
)
)