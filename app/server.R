shinyServer(function(input, output) {
  
  # list of time series available
  output$series_available <- renderUI({
    selectInput(inputId = "series_available", label = "Time series available:", 
                choices = paste0(list_series_available$series_disponiveis," - ",list_series_available$labels),
                selectize = F, multiple = T, selected = paste0(list_series_available$series_disponiveis," - ",list_series_available$labels)[c(1,2,14,38,40,51,94)])
  })
  
  # nowcast
  now <- reactive({
    input$now_button
    isolate({
      pib <- lag(data_series_available[,"serie22099"],-2)
      y <- month2qtr(diff(diff(pib,3),12))
      codes <- paste0("serie", as.numeric(sapply(input$series_available, FUN = function(x) unlist(strsplit(x, "-"))[1]))) 
      x <- Bpanel(data_series_available[,codes], rep(4,length(codes)), aggregate = F)
      q <- input$number_shocks
      r <- input$number_factors
      p <- input$number_lag
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
  
  # graph 6 - pib yoy
  output$graph6 <- renderDygraph({
    if(input$now_button != 0){
      
      pib <- lag(data_series_available[,"serie22099"],-2)
      pibq<-month2qtr(pib)
      
      fit_nivel <- now()$main[,2]+lag(pibq,-4)+lag(pibq,-1)-lag(pibq,-5)
      k <- data.frame(cbind(now()$main[,3],pibq))
      
      for(i in 71:75){
        k[i,2] <- k[i-1,2] + k[i-4,2] - k[i-5,2] + k[i,1]
      }
      prev_nivel <- ts(tail(k[,2],5), end = end(now()$main), freq = 4)
      
      x <- cbind(pibq, fit_nivel, prev_nivel)
      if(input$unit_y == "Level"){
        x[max(which(is.na(x[,3]))),3] <- x[max(which(is.na(x[,3]))),2]
      }else{
        varpibq <- (x[,1]/lag(x[,1],-4)-1)*100
        varfit <- (x[,2]/lag(x[,1],-4)-1)*100
        prev <- ts(na.omit(c(x[,1],x[,3])), start = start(x), freq = frequency(x))
        varprev <- ts(c(tail(na.omit(varfit),1), tail((prev/lag(prev,-4)-1)*100,5)), start = end(na.omit(varfit)), freq = 4)
        x <- cbind(varpibq, varfit, varprev)
      }
      colnames(x) <- c("y", "fit","fcst")
      
      dygraph(x) %>%
        dySeries("y", strokePattern = "dotted", color = "#000000") %>%
        dySeries("fit", strokeWidth = 2, color = "#3299CC") %>%
        dySeries("fcst", strokeWidth = 2, color = "#3299CC", strokePattern = "dashed") %>%
        dyAxis("y", axisLabelWidth = 20) %>%
        dyRangeSelector(dateWindow = c(tail(as.Date(x),1) - years(5),tail(as.Date(x),1)), strokeColor = "#3299CC", fillColor = "#F0F8FF") %>%
        dyLegend(labelsDiv = "legenda_graph6", show = "always", labelsSeparateLines = T)
    }
  })
  
  
})
