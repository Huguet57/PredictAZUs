DIR <- "C:\\Users\\andreu.huguet\\Downloads\\AZUs"
setwd(DIR)
dd <- read.csv("./historic_personal_all.csv")
head(dd)

assaigos.dates <- sort(unique(dd$assaig_id))
N.assaigos <- length(assaigos.dates)
head(assaigos.dates)

assist.assaig <- data.frame(data = as.Date(character()),
                           tipus = factor(),
                           assistents = integer())

# actuacions.especials <- function(dia, hora) {
#   if (hora == "16:00" | hora == "15:30") return(TRUE)
#   else return (FALSE)
# }

# mallorca <- function(dia, hora) {
#   if (format(dia,"%B") != "April") return(FALSE)
#   if (17 <= day(dia) & day(dia) <= 20) return(TRUE)
# }

get.tipus.assaig <- function(dia, hora) {
  dia.setmana <- strftime(data.assaig.k, "%A")
  mes <- strftime(data.assaig.k, "%m")

  if (hora == "14:00") return(0) # assaig migdia
  else if (hora == "20:00") return(1) # assaig pilars
  else if (dia.setmana == "Thursday" & mes == "05") return(2) # diada
  # else if (actuacions.especials(dia,hora)) return(3) # actuaciÃ³ especial
  # else if (mallorca(dia, hora) | perpinya(dia,hora)) return(4)
  else return(3)
}

for (k in 1:N.assaigos) {
  people.in.assaig.k <- which(dd$assaig_id == assaigos.dates[k])
  N.assistents.k <- sum(dd[people.in.assaig.k,]$assistencia == 1)
  data.assaig.k <- as.Date(dd[people.in.assaig.k[1],]$data,
                           origin="1900-01-01")
  
  tipus.assaig.k <- get.tipus.assaig(data.assaig.k,
                                     dd[people.in.assaig.k[1],]$hora)
  
  if (N.assistents.k > 20) {
    assist.assaig <- rbind(assist.assaig,
                          data.frame(data = data.assaig.k,
                                     tipus = tipus.assaig.k,
                                     assistents = N.assistents.k))
  } else {
    print(dd[people.in.assaig.k,])
  }
}

head(assist.assaig)
tail(assist.assaig)

assist.assaig <- assist.assaig[assist.assaig$tipus == 0,]

# Trec instàncies perquè els dos anys quadrin en dies
assist.assaig <- assist.assaig[-which(assist.assaig$data == "2018-09-20"),]
assist.assaig <- assist.assaig[-which(assist.assaig$data == "2018-10-02"),]
assist.assaig <- assist.assaig[-which(assist.assaig$data == "2018-10-09"),]
assist.assaig <- assist.assaig[-which(assist.assaig$data == "2017-11-09"),]
assist.assaig <- assist.assaig[-which(assist.assaig$data == "2019-05-28"),]

AA.temp1 <- assist.assaig[assist.assaig$data < as.Date('2018-09-01'),]
AA.temp2 <- assist.assaig[assist.assaig$data >= as.Date('2018-09-01'),]

AA.temp1$assistents
AA.temp2$assistents

write.csv(assist.assaig,
          file = "assistents_2017_2019.csv",
          row.names = FALSE)