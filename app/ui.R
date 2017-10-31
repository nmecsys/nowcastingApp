shinyUI(
  navbarPage(div("Nowcasting", style = "color:white; font-weight:bold; font-family:helvetica"), theme = shinytheme("yeti"), inverse = T,
             tabPanel("Home",
                      
                      fluidRow(
                        column(offset = 1, width = 10,
                               
                               sidebarLayout(
                                 sidebarPanel(width = 3, div("Configurações", style = "text-align:center"), hr(),
                                              
                                              radioButtons(inputId = "y", label = "Série Resposta", choices = "PIB"),
                                              selectInput(inputId = "series_available", label = "Séries disponíveis", choices = c("st1","st2","st3"),
                                                          selectize = F, multiple = T),
                                              sliderInput(inputId = "number_factors", label = "Número de fatores:", min = 1, max = 5, value = 2),
                                              
                                              div(bsButton(inputId = "now_button", label = "Nowcast!", style = "primary" ), style = "text-align:center")
                                              
                                              
                                 ),
                                 mainPanel(
                                   fluidRow(
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px", 
                                                          "Gráfico 1")
                                            )
                                     ),
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px",
                                                          "Gráfico 2")
                                            )
                                     )
                                   ),
                                   fluidRow(
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px", 
                                                          "Gráfico 3")
                                            )
                                     ),
                                     column(6, 
                                            wellPanel(style = "background-color:white",
                                                      div(style = "height:300px",
                                                          "Gráfico 4")
                                            )
                                     )
                                   )
                                 )
                               ))
                      )
                      
                      
             )
  )
)
