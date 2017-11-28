shinyServer(function(input, output) {
  
  
  # Homepage ------------------------------------------------------------
  
  output$hoje <- renderText({paste('Atualizado em',hoje)})
  output$tri_nowcasting <- renderText({tri_nowcasting_yoy})
  output$tri_backcasting <- renderText({tri_backcasting_yoy})
  output$tri_forecasting <- renderText({tri_forecasting_yoy})

  output$fcst_back <- renderText({
    paste0(as.vector(tail(na.omit(backcasting_yoy),1)),"%")
  })
  
  output$fcst_now <- renderText({
    paste0(as.vector(tail(nowcasting_yoy,1)),"%")
  })
  
  output$fcst_fore <- renderText({
    paste0(as.vector(tail(forecasting_yoy,1)),"%")
  })

  
  output$grafico_MSFE <- renderPlotly({
    plot_ly(y = round(RMSE,2), x = 1:length(RMSE), type = "bar", hoverinfo = "y",
            marker = list(line = list(width = 0.5, color = "#50729F"), color = "#50729F")) %>%
      layout(yaxis = list(range = c(0, max(RMSE) + 0.1), zeroline = T, zerolinecolor = "black", zerolinewidth = 1, title = "RMSE"),
             xaxis = list(title = "Vintages"),
             margin = list(b = 40, l = 40, r = 15, t = 0),
             font = list(size = 10)) %>%
      config(displayModeBar = F)

  })

  output$grafico_completo_yoy <- renderPlotly({
    plot_ly(y = as.vector(backcasting_yoy), x = index(backcasting_yoy), type = "scatter", mode = "lines", hoverinfo = "y + x", line = list(color = "#5E2D79", width = 1.5), name = tri_backcasting_yoy) %>%
      add_trace(y = as.vector(nowcasting_yoy), x = index(nowcasting_yoy), type = "scatter", mode = "lines", hoverinfo = "y + x", line = list(color = "#50729F", width = 1.5), name = tri_nowcasting_yoy) %>%
      add_trace(y = as.vector(forecasting_yoy), x = index(forecasting_yoy), type = "scatter", mode = "lines", hoverinfo = "y + x",  line = list(color = "#F2473F", width = 1.5), name = tri_forecasting_yoy) %>% #marker = list(color = "#FF7D40"),
      layout(yaxis = list(range = c(min(nowcasting_yoy, forecasting_yoy,backcasting_yoy, na.rm = T)-0.1, max(nowcasting_yoy,forecasting_yoy,backcasting_yoy, na.rm = T) + 0.1), zeroline = F, title = "PIB (%)"),
             margin = list(b = 15, l = 40, r = 15, t = 0),
             font = list(size = 10),
             shapes = list(
               list(type = "rect",
                    fillcolor = c("#5E2D79"), line = list(color = c("#5E2D79")), opacity = 0.1,
                    x0 = data_quadrado_back_yoy, x1 = data_quadrado_now_yoy, xref = "x",
                    y0 = c(min(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)-0.1), y1 = c(max(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)+0.1), yref = "y"),
               list(type = "rect",
                    fillcolor = c("#50729F"), line = list(color = c("#50729F")), opacity = 0.1,
                    x0 = data_quadrado_now_yoy, x1 = data_quadrado_fore_yoy, xref = "x",
                    y0 = c(min(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)-0.1), y1 = c(max(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)+0.1), yref = "y"),
               list(type = "rect",
                    fillcolor = c("#A02422"), line = list(color = c("#F2473F")), opacity = 0.1,
                    x0 = data_quadrado_fore_yoy, x1 = data_quadrado_fore_yoy+90, xref = "x",
                    y0 = c(min(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)-0.1), y1 = c(max(backcasting_yoy,nowcasting_yoy,forecasting_yoy, na.rm = T)+0.1), yref = "y")),
             annotations = list(x = c(data_quadrado_back_yoy,data_quadrado_now_yoy, data_quadrado_fore_yoy)+45,
                                y = max(backcasting_yoy,nowcasting_yoy,forecasting_yoy,na.rm=T),
                                text = c(tri_backcasting_yoy,tri_nowcasting_yoy,tri_forecasting_yoy),  showarrow = F,
                                xanchor = 'center', yanchor = 'top', font = list(color = "#A3A3A3", size = 10)))  %>%
      config(displayModeBar = F)

  })

  output$grafico_historico_yoy <- renderPlotly({
    plot_ly(y = round(datashiny$lasgdp[,1],2), x = rownames(datashiny$lasgdp), type = "scatter", mode = "lines", hoverinfo = "y + x", line = list(color = "#5E2D79", width = 1.5), name = "Previsão", showlegend = F) %>%
      add_trace(y = round(datashiny$lasgdp[,2],2), x = rownames(datashiny$lasgdp), type = "scatter", mode = "lines", hoverinfo = "y + x", line = list(color = "red", width = 1.5), name = "PIB Observado") %>%
      layout(yaxis = list(zeroline = F, title = "PIB (%)"),
             margin = list(b = 75, l = 40, r = 15, t = 10),
             font = list(size = 10)) %>%
      config(displayModeBar = F)
  })
  
  
  # como interpretar os gráficos
  
  # observeEvent(input$question_now, {
  #   showModal(modalDialog(
  #     fluidRow(
  #       column(5, img(src = "pibnow_explicar.png", width = "100%")),
  #       column(7, div(style = "text-align:justify", "Os três gráficos em ", span("1", style = "font-weight:bold; color:#3299CC"), "apresentam a previsão do PIB para três trimestres: o atual, o anterior e o posterior.",
  #                     "A área hachurada (azul, verde e laranja) representam o período do", tags$b("Nowcasting,"),"isto é, a previsão do trimestre quando se está no trimestre.",
  #                     "A área em branco anterior à área hachurada representa o", tags$b("Forecasting"), "(previsão do trimestre antes de estar no trimestre).",
  #                     "E, por último, a área em branco posterior representa o", tags$b("Backcasting"), "(previsão do trimestre após o trimestre ter passado).", br(), br(),
  #                     "O gráfico em ", span("2", style = "font-weight:bold; color:#3299CC"), " apresenta uma medida de erro (Root Mean Square Erro - RMSE) para as previsões de acordo com cada vintage.",
  #                     "São 34 vintages, isto é, cada trimestre é previsto 34 vezes. Espera-se que assim que as informações necessárias para as previsões sejam divulgadas, os erros diminuam, e por isso, ",
  #                     "o erro da vintage 34 seja o menor de todos.", br(), br(),
  #                     "O gráfico em ", span("3", style = "font-weight:bold; color:#3299CC"), " é a união dos três gráficos em ", span("1.", style = "font-weight:bold; color:#3299CC"),
  #                     "Nele é possível comparar o avanço das previsões simultaneamente e verificar como a chegada de novas informações afeta a previsão dos três trimestres previstos.")
  #       )
  #     ),
  #     title = "Como interpretar cada gráfico?",
  #     easyClose = TRUE, footer = modalButton("Fechar"), size = "l"
  #   ))
  # })
  
  
  # Just do it! ---------------------------------------------------------------------------------------
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
  
  # pib level and yoy
  x <- reactive({
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
      x
    }
  })
  
  # graph 6 - pib yoy
  output$graph6 <- renderDygraph({
    if(input$now_button != 0){
      dygraph(x()) %>%
        dySeries("y", strokePattern = "dotted", color = "#000000") %>%
        dySeries("fit", strokeWidth = 2, color = "#3299CC") %>%
        dySeries("fcst", strokeWidth = 2, color = "#3299CC", strokePattern = "dashed") %>%
        dyAxis("y", axisLabelWidth = 20) %>%
        dyRangeSelector(dateWindow = c(tail(as.Date(x()),1) - years(12),tail(as.Date(x()),1)), strokeColor = "#3299CC", fillColor = "#F0F8FF") %>%
        dyLegend(labelsDiv = "legenda_graph6", show = "always", labelsSeparateLines = T)
    }
  })
  
  output$title_graph6 <- renderText({
    if(input$unit_y == "Level"){
      "Brazilian GDP (Level)"
    }else{
      "Brazilian GDP (Year over year)"
    }
  })
  
  # text Q3 and Q4
  output$Q3 <- renderText({
    k <- round(x()[max(which(is.na(x()[,3]))) + 2,3],2)
    if(input$unit_y == "YoY"){
      k <- paste0(k,"%")
    }
    k
  })
  
  output$Q4 <- renderText({
    k <- round(x()[max(which(is.na(x()[,3]))) + 3,3],2)
    if(input$unit_y == "YoY"){
      k <- paste0(k,"%")
    }
    k
  })
  
  output$Q1 <- renderText({
    k <- round(x()[max(which(is.na(x()[,3]))) + 4,3],2)
    if(input$unit_y == "YoY"){
      k <- paste0(k,"%")
    }
    k
  })
  
  
})
