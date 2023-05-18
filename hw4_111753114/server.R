library(ggvis)
library(shiny)
library(ggbiplot)
library(plotly)
library(ca)


subcol<- function(x){
  b<-c()
  b<-c(b,integer(x))
}
shinyServer(function(input, output, session) {
  
  
  
  
  DATA_ir <-reactive({
    log.ir <-   log(iris[1:input$n,
                         c(as.numeric(input$var.levels))
    ]) 
    log.ir
  })
  DATA_species<-reactive({
    ir.species <- iris[1:input$n, 5] 
    ir.species
  })
  org <- reactive({ iris[1:input$n,c(as.numeric(input$var.levels))] })
  x_var<-reactive({input$x_axis})
  y_var<-reactive({input$y_axis})
  
  observeEvent(input$run_ca, {
    data <- iris[, input$var_levels]
    ca_result <- ca(data)
    
    output$output_ca <- renderPlot({
      plot(ca_result)
    })
  })
  
  
  
  output$output_g <-renderPlot({
    ir.pca <- prcomp(DATA_ir(),center = TRUE, scale. = TRUE)
    #ir.pca <- prcomp(log.ir,center = TRUE, scale. = TRUE)
    g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, groups = DATA_species(),choices = c(as.numeric(x_var()),as.numeric(y_var())))
    #g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, groups = ir.species)
    g <- g + scale_color_discrete(name = '')
    g <- g + theme(legend.direction = 'horizontal', legend.position = 'top')
    g
  })
  
  #var_levels_data <-reactive({ iris[1:input$n_ca,c(input$var_levels)]  })
  
  output$orgin <- renderTable({
    org()
    #ca(var_levels_data())
  })
  
  
  
  
  
  
  
  
  
  # output$a1123 <- renderTable({
  #   gg_well<-ir.pca$rotation
  #  gg_well
  #})
})