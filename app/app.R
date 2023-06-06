library(shiny)
source("ui_lib.R")

# Define UI
batterIDs <- read.csv("../data/batter_id.csv")
batter_choices <- setNames(batterIDs$id, batterIDs$name)

pitcherIDs <- read.csv("../data/pitcher_id.csv")
pitcher_choices <- setNames(pitcherIDs$id, pitcherIDs$name)

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
  
  htmlOutput("mainbody"),
  
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
  
    output$mainbody <- renderUI(team_select_screen)
  
  updateSelectizeInput(session, 'pitcher_one', choices = pitcher_choices, server = TRUE)
  updateSelectizeInput(session, 'pitcher_two', choices = pitcher_choices, server = TRUE)
  updateSelectizeInput(session, 'batter_one', choices = batter_choices, server = TRUE)
  updateSelectizeInput(session, 'batter_two', choices = batter_choices, server = TRUE)
  
  output$pitcher_headshot_one <- renderText({get_player_headshot(input$pitcher_one)})
  output$batter_headshot_one <- renderText({get_player_headshot(input$batter_one)})
  output$pitcher_headshot_two <- renderText({get_player_headshot(input$pitcher_two)})
  output$batter_headshot_two <- renderText({get_player_headshot(input$batter_two)})
  
  observeEvent(input$startButton, {
    output$mainbody <- renderUI(game_screen)
    # Perform desired operations on the backend here
    # Code to be executed when the action button is clicked
    
    # Render the verbose output
    # output$verboseOutput <- renderText({
    #   verbose_output()
    # })
    # 
    # # Render plot 1
    # output$plot1 <- renderPlot({
    #   plot(plot1_data(), 1:length(plot1_data()), type = "l", main = "Plot 1")
    # })
    # 
    # # Render plot 2
    # output$plot2 <- renderPlot({
    #   plot(plot2_data(), 1:length(plot2_data()), type = "l", main = "Plot 2")
    # })    
    
    
  })
}

# Run the app
shinyApp(ui = ui, server = server)