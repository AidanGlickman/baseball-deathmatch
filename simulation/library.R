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
  count <- array(integer(3), dim=c(1,3), dimnames=list(c(""), c("BALL", "STRIKE", "OUT")))
  inning <- 1
  bases <- list(0,0,0)
  return(list(pitcher1_sc, batter1_sc, pitcher2_sc, batter2_sc, boxscore, score, count, inning, bases))
}

# init_test <- init_sim(660271,660271,282332,429664)
# init_test[5]
