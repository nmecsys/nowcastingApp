shinyUI(
  navbarPage(div("Nowcasting", style = "color:white; font-weight:bold; font-family:helvetica"), theme = shinytheme("yeti"), inverse = T,
             tabPanel("CRAN",""),
                      
              tabPanel("Just do it!",
                      
                      fluidRow(
                        column(offset = 1, width = 10,
                               
                               sidebarLayout(
                                 sidebarPanel(width = 4, div("Nowcasting Brazilian GDP", style = "text-align:center"), hr(),
                                              
                                              uiOutput("series_available"),
                                              sliderInput(inputId = "number_factors", label = "Number of factors:", min = 1, max = 5, value = 1),
                                              sliderInput(inputId = "number_shocks", label = "Number of common shocks:", min = 1, max = 5, value = 1),
                                              #sliderInput(inputId = "number_lag", label = "Factor lag:", min = 1, max = 5, value = 1),
                                             
                                              
                                              div(bsButton(inputId = "now_button", label = "Nowcast!", style = "primary" ), style = "text-align:center")
                                              
                                              
                                 ),
                                 mainPanel(
                                   
                                   wellPanel(style = "background-color:white",
                                             div(style = "height:400px",
                                                 plotOutput("graph1", width = "100%", height = "100%"))
                                   ),
                                    
                                   fluidRow(
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px", 
                                                          plotOutput("graph2", width = "100%", height = "99%"))
                                            )
                                     ),
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px",
                                                          plotOutput("graph3", width = "100%", height = "99%"))
                                            )
                                     )
                                   ),
                                   fluidRow(
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px", 
                                                          plotOutput("graph4", width = "100%", height = "99%"))
                                            )
                                     ),
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px",
                                                          plotOutput("graph5", width = "100%", height = "99%"))
                                            )
                                     )
                                   )
                                 )
                               ))
                      )
                      
                      
             )
  )
)
