# UI Library Code

get_player_headshot <- function(id){
  url <- sprintf("https://img.mlbstatic.com/mlb-photos/image/upload/w_32,q_100/v1/people/%s/headshot/silo/current", id)
  return(c('<img style="image-rendering: pixelated; height:128px;" src="',url,'">'))
}

team_select_screen <- tags$div( 
  style = "background-color: #000000; padding: 10px; padding-left: 20px;",
  
  # Select Batters
  fluidRow(
    column(width = 5,
           tags$h3("Team Vipers", style = "text-align: center; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
           div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
               selectInput("batter_one", "Select Batter", 
                           choices = NULL, 
                           selected = NULL)
           ),
           div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
               selectInput("pitcher_one", "Select Pitcher", 
                           choices = NULL, 
                           selected = NULL)
           ),
           span(
             style="display:flex;",
             htmlOutput("batter_headshot_one"),
             htmlOutput("pitcher_headshot_one"),
           )
    ),
    column(width=2,
           div(style="display: flex; margin: auto; text-align: center;",
               tags$h3("VS"), style = "color: #7A1414; text-align: center; font-family: 'Luminari', fantasy;"),
           
    ),
    
    column(width = 5,
           tags$h3("Team Skulls", style = "text-align: center; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
           
           div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
               selectInput("batter_two", "Select Batter", 
                           choices = NULL, 
                           selected = NULL)
           ),
           div(style = "color: #7A1414; background-color: #000000; font-family: 'Luminari', fantasy;", 
               selectInput("pitcher_two", "Select Pitcher", 
                           choices = NULL, 
                           selected = NULL)
           ),
           span(
             style="display:flex;",
             htmlOutput("batter_headshot_two"),
             htmlOutput("pitcher_headshot_two"),
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
)

game_screen <- fluidRow(
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
)