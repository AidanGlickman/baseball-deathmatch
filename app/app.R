library(shiny)

# Define UI
ui <- fluidPage(
  
  # Custom CSS style
  tags$head(
    tags$link(rel = "stylesheet", href = "https://fonts.googleapis.com/css2?family=Metal+Mania&display=swap"),
    tags$style(HTML("
      /* Set body background color */
      body {
        background-color: #000000;
      }

      /* Header font styles */
      h1 {
        font-family: 'Metal Mania', sans-serif;
        font-size: 35px;
        font-weight: bold;
        color: #caccce;
      }
      
      /* Logo styles */
      .logo {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
      }
      
      .logo img {
        width: 150px;
        height: auto;
        margin-right: 10px;
      }
      
      /* Image placement styles */
      .image-container {
        display: flex;
        justify-content: center;
        margin-bottom: 20px;
      }
      
      .image-container img {
        max-width: 100%;
        max-height: 300px;
      }
      
      /* Spotify embedding styles */
      .spotify-embed {
        display: flex;
        justify-content: center;
        margin-top: 20px;
      }
    "))
  ),
  
  # Header with logo
  tags$div(class = "logo",
           tags$img(src = "imgbin_vipers-png.png"),
           tags$h1("2v2 Baseball Death Match"), 
           tags$img(src = "Baseball-skull-design-on-transparent-background-PNG.png"),
  ),
  
  # Image placement
  #tags$div(class = "image-container",
  #         tags$img(src = "image1.jpg")
  #),
  
  
  tags$div( 
    style = "background-color: #000000; padding: 10px; padding-left: 20px",
  
    # Select Batters
    fluidRow(
      column(width = 5,
           tags$h3("Team Vipers", style = "text-align: left; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
           div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
               selectInput("dropdown1", "Select Batter", 
                       choices = c("Option 1", "Option 2", "Option 3"), 
                       selected = NULL)
              )
           ),

      column(width = 5,
             tags$h3("Team Skulls", style = "text-align: left; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
             div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
                 selectInput("dropdown1", "Select Batter", 
                             choices = c("Option 1", "Option 2", "Option 3"), 
                             selected = NULL)
             )
        )
      ),
    
    # Select Pitchers
    fluidRow(
      column(width = 5,
             div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
                 selectInput("dropdown1", "Select Pitcher", 
                             choices = c("Option 1", "Option 2", "Option 3"), 
                             selected = NULL)
             )
      ),
      column(width = 5,
             div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
                 selectInput("dropdown1", "Select Pitcher", 
                             choices = c("Option 1", "Option 2", "Option 3"), 
                             selected = NULL)
             )
      )
    ), 
    
    # Action button
    fluidRow(
      column(width = 12,
             div(style = "padding-top: 20px; text-align: left;",
                 actionButton("startButton", "Commence Death Match", 
                              style = "background-color: #000000; color: #caccce; font-family: 'Metal Mania', sans-serif;"
                 )
             )
      )
    )
    
  ),
  
  fluidRow(
    column(width = 4,
           style = "overflow-y: scroll; max-height: 300px;",
           verbatimTextOutput("verboseOutput")
    ),
    
    column(width = 4,
           plotOutput("plot1")
    ),
    
    column(width = 4,
           plotOutput("plot2")
    )
  ),
  
  br(),
  # Spotify embedding
  tags$div(class = "spotify-embed",
           mainPanel(
           tags$iframe(src = "https://open.spotify.com/embed/playlist/4fR5U0vK3YxOMIRGYpotpB?utm_source=generator",
                       width = "500",
                       height = "100%",
                       frameborder = "0",
                       allowtransparency = "true",
                       allow = "autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture",
                       loading = "lazy"))
  ),

  br(),
  br(),
  tags$p("Team Vipers image credit:", tags$a("@nospotts", href = "https://imgbin.com/png/2mmcv6gT/vipers-png")),
  tags$p("Team Skulls image credit:", tags$a("@ra20Ga", href = "https://similarpng.com/baseball-skull-design-on-transparent-background-png/#getdownload"))
  
)




# Define server logic
server <- function(input, output, session) {
  
  # Initialize the verbose output
  verbose_output <- reactiveVal("")
  
  # Initialize the plot data
  plot1_data <- reactiveVal(NULL)
  plot2_data <- reactiveVal(NULL)
  
  observeEvent(input$startButton, {
    # Perform desired operations on the backend here
    # Code to be executed when the action button is clicked
    
    # Render the verbose output
    output$verboseOutput <- renderText({
      verbose_output()
    })
    
    # Render plot 1
    output$plot1 <- renderPlot({
      plot(plot1_data(), 1:length(plot1_data()), type = "l", main = "Plot 1")
    })
    
    # Render plot 2
    output$plot2 <- renderPlot({
      plot(plot2_data(), 1:length(plot2_data()), type = "l", main = "Plot 2")
    })    
    
    
  })
}

# Run the app
shinyApp(ui = ui, server = server)