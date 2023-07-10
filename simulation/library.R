library(dplyr)
# Simulation Library Code
init_sim <- function(pitcher1, batter1, pitcher2, batter2){
  sc_selected <- read.csv("../data/sc_selected.csv")
  pitcher1_sc <- sc_selected |> filter(pitcher == pitcher1)
  pitcher2_sc <- sc_selected |> filter(pitcher == pitcher2)
  batter1_sc <- sc_selected |> filter(batter == batter1)
  batter2_sc <- sc_selected |> filter(batter == batter2)
  
  boxscore <- array(integer(20), dim=c(2,10), dimnames=list(c("Vipers", "Skulls"), c("1","2","3","4","5","6","7","8","9","10")))
  
  # R1, H1, R2, H2
  score <- array(integer(4), dim=c(2,2), dimnames=list(c("Vipers", "Skulls"), c("R", "H")))
  mycount <- array(integer(3), dim=c(1,3), dimnames=list(c(""), c("BALL", "STRIKE", "OUT")))
  inning <- 1
  bases <- list(0,0,0)
  return(list(pitcher1_sc, batter1_sc, pitcher2_sc, batter2_sc, boxscore, score, mycount, inning, bases))
}

# init_test <- init_sim(660271,660271,282332,429664)
# init_test[5]

choosePitch <- function(pitcher_sc, fld_winning1, mycount, inning1, bases1){
  # return(mycount)
  balls1 <- mycount[[1]][[1]]
  strikes1 <- mycount[[1]][[2]]
  outs1 <- mycount[[1]][[2]]
  pitches <- pitcher_sc |> filter(fld_winning == fld_winning1 & inning == inning1 & outs_when_up == outs1 & balls == balls1 & strikes == strikes1)
  if (nrow(pitches) > 0) {
    pitch <- (pitches |> sample_n(1))
  } else {
    # otherwise, try again but ignore the inning and fld_winning columns
    pitches <- pitcher_sc |> filter(outs_when_up == outs & balls == balls & strikes == strikes)
    pitch <- pitches |>
      sample_n(1)
  }
  return(pitch)
}

simPitch <- function(pitcher_sc, batter_sc, fld_winning, count, inning) {
  pitch <- choosePitch(pitcherID, fld_winning, count, inning)
  # Now, we simulate how the batter does against this pitch.
  batter_results <- batter_selected |>
    filter(batter == batterID & pitch_type == pitchtype) |>
    # select the 30 pitches with the closest speeds
    mutate(speed_diff = abs(effective_speed - speed)) |>
    arrange(speed_diff) |>
    slice(1:30) |>
    select(result)
  # for some extra randomness, add some extras
  batter_results <- batter_results |>
    add_row(result = c("S", "B", "single", "double"))
  result <- batter_results |> sample_n(1)
  return(result)
}

advanceRunners <- function(bases, num) {
  first <- bases[[1]]
  second <- bases[[2]]
  third <- bases[[3]]
  score <- 0
  home <- TRUE
  i <- 0
  while (i < num) {
    if (home | i > 0) {
      if (first | i > 1) {
        if (second | i > 2) {
          if (third | i > 3) {
            score <- score + 1
            if (third) {
              third <- FALSE
            }
          }
          if (second) {
            third <- TRUE
            second <- FALSE
          }
        }
        if (first) {
          second <- TRUE
          first <- FALSE
        }
      }
      if (home) {
        first <- TRUE
        home <- FALSE
      }
    }
    i <- i + 1
  }
  return(list(c(first, second, third), score))
}