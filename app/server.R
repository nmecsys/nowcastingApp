shinyServer(function(input, output) {
   
  # list of time series available
  output$series_available <- renderUI({
    selectInput(inputId = "series_available", label = "Time series available:", 
                choices = paste0(list_series_available$series_disponiveis," - ",list_series_available$labels),
                selectize = F, multiple = T, selected = paste0(list_series_available$series_disponiveis," - ",list_series_available$labels)[c(1,2,14,38,40,51,94)])
  })
  
  # nowcast
  
  output$print <- renderPrint({

    pib <- lag(data_series_available[,"serie22099"],-2)
    y <- month2qtr(diff(diff(pib,3),12))
    codes <- paste0("serie", as.numeric(sapply(input$series_available, FUN = function(x) unlist(strsplit(x, "-"))[1]))) 
    x <- Bpanel(data_series_available[,codes], rep(4,length(codes)), aggregate = F)
    q <- input$number_error
    r <- input$number_error
    p <- input$number_lag
    now <- nowcast(y,x,q,r,p,method = '2sm')
    str(now)
    
    
  })
    
  now <- reactive({
    input$now_button
    isolate({
      pib <- lag(data_series_available[,"serie22099"],-2)
      y <- month2qtr(diff(diff(pib,3),12))
      codes <- paste0("serie", as.numeric(sapply(input$series_available, FUN = function(x) unlist(strsplit(x, "-"))[1]))) 
      x <- Bpanel(data_series_available[,codes], rep(4,length(codes)), aggregate = F)
      q <- input$number_shocks
      r <- input$number_factors
      p <- 1
      now <- nowcast(y,x,q,r,p,method = '2sm')
      now
    })
  })

  # graph 1 - y and yhat
  output$graph1 <- renderPlot({
    if(input$now_button != 0)
    nowcast.plot(now())
  })
  
  # graph 2 - factors
  output$graph2 <- renderPlot({
    if(input$now_button != 0)
      nowcast.plot(now(), type = "factors")
  })
  
  # graph 3 - eigenvalues
  output$graph3 <- renderPlot({
    if(input$now_button != 0)
      nowcast.plot(now(), type = "eigenvalues")
  })
  
  # graph 4 - eigenvectors
  output$graph4 <- renderPlot({
    if(input$now_button != 0)
      nowcast.plot(now(), type = "eigenvectors")
  })
  
  # graph 5 - eigenfactors
  output$graph5 <- renderPlot({
    if(input$now_button != 0)
      nowcast.plot(now(), type = "month_y")
  })
  
  
})
