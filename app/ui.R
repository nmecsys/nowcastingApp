shinyUI(
  navbarPage(div("Nowcasting", style = "color:white; font-weight:bold; font-family:helvetica"), theme = shinytheme("yeti"), inverse = T,
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
                                  a(href = "https://github.com/guilbran/nowcasting", "https://github.com/guilbran/nowcasting", target = "_blank"),
                                  div("devtools::install_github('guilbran/nowcasting')", style = "background-color:#F0F8FF; height:45px; margin-top:5px; padding-top:15px; padding-left:15px; font-family:lucida console; font-size:90%;border-radius:5px")
                                
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
                                              sliderInput(inputId = "number_factors", label = "Number of factors:", min = 1, max = 5, value = 1),
                                              sliderInput(inputId = "number_shocks", label = "Number of common shocks:", min = 1, max = 5, value = 1),
                                              sliderInput(inputId = "number_lag", label = "Factor lag:", min = 1, max = 5, value = 1),
                                              
                                              
                                              div(bsButton(inputId = "now_button", label = "Nowcast!", style = "primary" ), style = "text-align:center")
                                              
                                              
                                 ),
                                 mainPanel(
                                   
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:400px",
                                                 
                                                 fluidRow(
                                                   column(2, radioButtons(inputId = "unit_y", label = "Unit:", choices = c("Level","YoY")),
                                                          div(textOutput("legenda_graph6"), style = "font-size:80%;")),
                                                   column(10,
                                                          
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
                                    
                                    icon("angle-right"), "Daiane Marcolino de Mattos", br(),
                                    "Graduate student in Electrical Engineering - Methods of Decision Support (PUC-Rio) and major in Statistical Science (ENCE/IBGE).", br(),
                                    a(href = "mailto:daiane.mattos@fgv.br","email", title = "daiane.mattos@fgv.br", style ="color:#3299CC"), "|",
                                    a(href = "http://lattes.cnpq.br/5903694854336540","lattes", target = "_blank", style = "color:#3299CC"),
                                    br(),br(),
                                    
                                    icon("angle-right"),"Guilherme Branco Gomes", br(),
                                    "Graduate student in Economics (FGV EPGE) and major in Economics (FEA/USP)", br(),
                                    a(href = "mailto:guilherme.branco@fgv.br","email", title = "guilherme.branco@fgv.br", style ="color:#3299CC"), "|",
                                    a(href = "http://lattes.cnpq.br/4872383719355805","lattes", target = "_blank", style = "color:#3299CC")
                                    
                                    
                                )
                                
                      )
             ) # tabPanel Authors
  ) # navbarPage
) # shinyUI
