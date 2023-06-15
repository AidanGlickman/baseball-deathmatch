# UI Library Code
devtools::install_github("bdilday/GeomMLBStadiums")
library(GeomMLBStadiums)
library(ggplot2)
library(dplyr)


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

game_screen <- div(
  fluidRow(
    column(width=5,
           div(
             tags$h3("Team Vipers", style = "text-align: center; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
             span(
               style="display:flex; align:center;",
               htmlOutput("batter_headshot_one"),
               htmlOutput("pitcher_headshot_one"),
             )
           )),
    column(width=2,
           div(style="display: flex; margin: auto; text-align: center;",
               tags$h3("VS"), style = "color: #7A1414; text-align: center; font-family: 'Luminari', fantasy;"),
           
    ),
    column(width=5,
           div(
             tags$h3("Team Skulls", style = "text-align: center; color: #caccce; font-family: 'Metal Mania', sans-serif;"),
             span(
               style="display:flex; align:center;",
               htmlOutput("batter_headshot_two"),
               htmlOutput("pitcher_headshot_two"),
             )
           ))
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
scoreboard
)

scoreboard <- div(
  fluidRow(
    column(width=8,
           style="background-color: red;",
           tableOutput("boxscoreout")
           ),
    column(width=4,
           style="background-color: blue;",
           # RH
           tableOutput("scoreout")
           )
  ),
  fluidRow(
    column(width=12,
           style="background-color: green;",
           tableOutput("countout")
           )
  )
)

spotify_embed <- tags$div(class = "spotify-embed",
                          mainPanel(
                            tags$iframe(src = "https://open.spotify.com/embed/playlist/4fR5U0vK3YxOMIRGYpotpB?utm_source=generator",
                                        width = "500",
                                        height = "100%",
                                        frameborder = "0",
                                        allowtransparency = "true",
                                        allow = "autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture",
                                        loading = "lazy"))
)
