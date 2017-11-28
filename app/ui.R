shinyUI(
  navbarPage("Nowcasting", theme = "shiny.css", inverse = T,
             
               
             # Home ------------------------------------------------
             tabPanel("Now", 
                      div(textOutput('hoje'), style = "text-align:right; font-size:85%"),
                      fluidRow(
                        column(2, offset = 3,
                               wellPanel(style = "background-color:white;border-radius: 5px;",
                                         div(textOutput("tri_backcasting"), style = "text-align:center; font-size:85%"),
                                         div(tags$i("backcasting"), style = "text-align:center;font-size:80%"),
                                         div(textOutput("fcst_back"), style = "text-align:center; font-weight:bold")
                               )
                        ),
                        column(2, 
                               wellPanel(style = "background-color:white;border-radius: 5px;",
                                         div(textOutput("tri_nowcasting"), style = "text-align:center; font-size:85%"),
                                         div("nowcasting", style = "text-align:center;font-size:80%"),
                                         div(textOutput("fcst_now"), style = "text-align:center; font-weight:bold")
                               )
                        ),
                        column(2, 
                               wellPanel(style = "background-color:white;border-radius: 5px;",
                                         div(textOutput("tri_forecasting"), style = "text-align:center; font-size:85%"),
                                         div("forecasting", style = "text-align:center; font-size:80%"),
                                         div(textOutput("fcst_fore"), style = "text-align:center;  font-weight:bold")
                               )
                        )
                      ),
                      
                      wellPanel(style = "background-color:white",
                                
                                span("Backcasting, nowcasting and forecasting", style = "color:#858585; font-weight:bold; font-size:110%; font-family: 'Trebuchet MS'"),
                                div("Year over year (%)", style = "color:#808080; font-size:90%; font-family: 'Trebuchet MS';"), br(), br(),
                                plotlyOutput("grafico_completo_yoy", height = "250px"),
                                hr(),
                                
                                span("Nowcasting evolution for the last quarter observed", style = "color:#858585; font-weight:bold; font-size:110%; font-family: 'Trebuchet MS'"),
                                div("Year over year (%)", style = "color:#808080; font-size:90%; font-family: 'Trebuchet MS';"), br(),br(),
                                plotlyOutput("grafico_historico_yoy", height = "250px"),
                                hr(), 
                                
                                span("RMSE - Vintages", style = "color:#858585; font-weight:bold; font-size:110%; font-family: 'Trebuchet MS'"),
                                div("Root Mean Square Error of the vintages (from Q1-2011)", style = "color:#808080; font-size:90%; font-family: 'Trebuchet MS';"), br(),br(),
                                plotlyOutput("grafico_MSFE", height = "250px")
                      )
             ),
             
             # PACKAGE ------------------------------------------------
             tabPanel("Package", 
                      wellPanel(style = "background-color:white",
                                div(#style = "height:280px", 
                                  div("nowcasting: Nowcast Analysis and Create Real-Time Data Basis", style = "font-family:lucida console;"),
                                  br(),
                                  div(icon("angle-right"), "CRAN", style = "font-weight:bold"),
                                  a(href = "https://CRAN.R-project.org/package=nowcasting", "https://CRAN.R-project.org/package=nowcasting", target = "_blank"), br(), 
                                  div("install.packages('nowcasting')", style = "background-color:#F0F8FF; height:45px; margin-top:5px; padding-top:15px; padding-left:15px; font-family:lucida console; font-size:90%;border-radius:5px"),
                                  
                                  br(), br(),
                                  div(icon("angle-right"), "Github", style = "font-weight:bold"),
                                  a(href = "https://github.com/nmecsys/nowcasting", "https://github.com/nmecsys/nowcasting", target = "_blank"),
                                  div("devtools::install_github('nmecsys/nowcasting')", style = "background-color:#F0F8FF; height:45px; margin-top:5px; padding-top:15px; padding-left:15px; font-family:lucida console; font-size:90%;border-radius:5px")
                                  
                                )
                      )
             ),
             
             # JUST DO IT ----------------------------------------------
             tabPanel("Just do it!",
                      
                      fluidRow(
                        column(offset = 1, width = 10,
                               
                               sidebarLayout(
                                 sidebarPanel(width = 4, div("Nowcasting Brazilian GDP", style = "text-align:center"), hr(),
                                              
                                              uiOutput("series_available"),
                                              sliderInput(inputId = "number_factors", label = "Number of factors:", min = 1, max = 5, value = 2),
                                              sliderInput(inputId = "number_shocks", label = "Number of common shocks:", min = 1, max = 5, value = 2),
                                              sliderInput(inputId = "number_lag", label = "Factor lag:", min = 1, max = 5, value = 2),
                                              
                                              
                                              div(bsButton(inputId = "now_button", label = "Nowcast!", style = "primary" ), style = "text-align:center")
                                              
                                              
                                 ),
                                 mainPanel(
                                   
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:400px",
                                                 fluidRow(
                                                   column(3, radioButtons(inputId = "unit_y", label = "Unit:", choices = c("Level","YoY"), selected = "YoY"),
                                                          div(textOutput("legenda_graph6"), style = "font-size:80%;"), br(),
                                                          conditionalPanel("input.now_button != 0",
                                                          div("Q3/2017:", textOutput("Q3", inline = T), br(), "Q4/2017:",textOutput("Q4", inline = T), 
                                                              br(), "Q1/2018:",textOutput("Q1", inline = T), style = "background-color:#F0F8FF; width:140px;height:85px; margin-top:5px; padding-top:15px; padding-left:10px; font-family:lucida console; font-size:90%;border-radius:5px")
                                                          )
                                                   ),
                                                   column(9,
                                                          conditionalPanel("input.now_button != 0",
                                                                           div(textOutput("title_graph6"), style = "text-align:center; font-size: 95%")
                                                          ),br(),
                                                          dygraphOutput("graph6", width = "100%"))
                                                 )
                                             )
                                   ),
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:300px",
                                                 plotOutput("graph1", width = "100%", height = "100%"))
                                   ),
                                   
                                   
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:300px", 
                                                 plotOutput("graph2", width = "100%", height = "99%"))
                                   ),
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:300px",
                                                 plotOutput("graph3", width = "100%", height = "99%"))
                                   ),
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:300px", 
                                                 plotOutput("graph4", width = "100%", height = "99%"))
                                   ),
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:300px",
                                                 plotOutput("graph5", width = "100%", height = "99%"))
                                   )
                                 ) # main panel
                               ) # sidebarlayout
                        )
                      )
             ), # tabPanel Just do it!
             
             
             # VINTAGE ----------------------------------------------
             tabPanel("Vintage",
                      
                      wellPanel(style = "background-color:white",
                                div("Collecting information available now", style = "font-weight:bold"),br(),
                                
                                "You can create real time data base from series available in", a(hreg = "https://www3.bcb.gov.br/sgspub/","Brazilian Central Bank Time Series Management System v2.1.", target = "_blank"), br(),
                                span("Warning:", style = "background-color:#FFE4E1; height:15px; padding-bottom:5px; padding-top:5px; padding-left:5px; font-family:lucida console; font-size:90%;border-radius:5px"), 
                                "We take no responsibility for delays in disclosure of new information or malfunctioning of the central bank platform.",
                                br(),br(),
                                
                                "Example",
                                div(style = "background-color:#F0F8FF; margin-top:5px; padding-top:15px; padding-bottom:15px; padding-left:15px; font-family:lucida console; font-size:90%;border-radius:5px",
                                    "> ipca <- base_extraction(series_code = 433)", br(),
                                    "> window(ipca, start = c(2016,1), end = c(2016,12), frequency = 12)"
                                ),br(),
                                img(src = "ipca.PNG")
                                
                                
                                    
                      )
             ), # tabPanel Vintages
             
             # AUTHORS ---------------------------------------------
             tabPanel("Authors", 
                      wellPanel(style = "background-color:white",
                                div(style = "height:280px",
                                    icon("angle-right"),"Pedro G. C. Ferreira", br(),
                                    "PhD. in Electrical Engineering - Methods of Decision Support (PUC-Rio) and master in Economics (UFJF-MG).", br(),
                                    "Coordenador do NMEC", br(),
                                    a(href = "mailto:pedro.guilherme@fgv.br","email", title = "pedro.guilherme@fgv.br", style ="color:#3299CC"), "|",
                                    a(href = "http://lattes.cnpq.br/2228133411590933","lattes", target = "_blank", style = "color:#3299CC"),
                                    br(),br(),
                                    
                                    icon("angle-right"),"Guilherme Branco Gomes", br(),
                                    "Graduate student in Economics (FGV EPGE) and major in Economics (FEA/USP)", br(),
                                    a(href = "mailto:guilherme.branco@fgv.br","email", title = "guilherme.branco@fgv.br", style ="color:#3299CC"), "|",
                                    a(href = "http://lattes.cnpq.br/4872383719355805","lattes", target = "_blank", style = "color:#3299CC"),
                                    br(),br(),
                                    
                                    icon("angle-right"), "Daiane Marcolino de Mattos", br(),
                                    "Graduate student in Electrical Engineering - Methods of Decision Support (PUC-Rio) and major in Statistical Science (ENCE/IBGE).", br(),
                                    a(href = "mailto:daiane.mattos@fgv.br","email", title = "daiane.mattos@fgv.br", style ="color:#3299CC"), "|",
                                    a(href = "http://lattes.cnpq.br/5903694854336540","lattes", target = "_blank", style = "color:#3299CC")
                                    
                                    
                                )
                                
                      )
             ) # tabPanel Authors
  ) # navbarPage
) # shinyUI
