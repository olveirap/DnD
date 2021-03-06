
background <- function() {
rad <- c(ceiling(runif(1, min = 0, max = 151)), ceiling(runif(1, min = 0, max = 9)), ceiling(runif(1, min = 0, max = 12)), ceiling(runif(1, min = 0, max = 784)))
background <- str_c(Stories[[1]][rad[1],], Stories[[2]][rad[2],], Stories[[3]][rad[3],], Stories[[4]][rad[4],], sep = " ")
return(background)
}



jk <- replicate(200, background())
read.1 <- as.character(unlist(read.csv("Background1")[,2]))
read.2 <- as.character(read.csv("Background2")[,2])
read.3 <- as.character(read.csv("Background3")[,2])
read.4 <- as.character(read.csv("Background4")[,2])
back <- c(read.1, read.2, read.3, read.4)
#Get ride of Absent and Pretty, regular expression problem
forward <- forward[-554]







library(reshape2)
personalit <- colsplit(forward," ",c("Personality","Race"))
holding <- apply(personalit[2], 2, as.character)
race <- colsplit(holding, " ", c("Race", "Background"))
holding.2 <- apply(race[2], 2, as.character)
class <- colsplit(holding.2, " ", c("Class", "Background"))

Personality <- unique(personalit[1], rm.na=T)
Race <- unique(race[1], rm.na=T)
Class <- unique(class[1], rm.na=T)
Motivation <- unique(class[2], rm.na=T)

Stories <- list(Personality, Race, Class, Motivation)
write.csv(Stories, "Stories.csv")

html <- read_html("http://thebombzen.github.io/grimoire/tags/bard.html")

#works well for spell info
Para <- html %>% html_nodes(".post-link") %>% html_text
Bard.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/cleric.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Cleric.spells <- Para


html <- read_html("http://thebombzen.github.io/grimoire/tags/druid.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Druid.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/paladin.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Paladin.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/ranger.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Ranger.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/sorcerer.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Socerer.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/warlock.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Warlock.spells <- Para

html <- read_html("http://thebombzen.github.io/grimoire/tags/wizard.html")
Para <- html %>% html_nodes(".post-link") %>% html_text
Wizard.spells <- Para

Class_Spells <- list(Bard.spells, Cleric.spells, Druid.spells, Paladin.spells, Ranger.spells, Socerer.spells, Warlock.spells, Wizard.spells)
names(Class_Spells) <- c("Bard", "Cleric", "Druid", "Paladin", "Ranger", "Sorcerer", "Warlock", "Wizard")


res <- sapply(list(Wizard.spells = Wizard.spells, Warlock.spells = Warlock.spells, Soceror.spells = Soceror.spells, Ranger.spells = Ranger.spells, Paladin.spells = Paladin.spells, Druid.spells = Druid.spells, Cleric.spells = Cleric.spells, Bard.spells = Bard.spells), function(u) as.numeric(unlist(Spell_List) %in% u))
row.names(res) <- unlist(Spell_List)
Spells_by_Class <- res
Save(Spells_by_Class, "Spells_by_Class")


html <- read_html("http://thebombzen.github.io/grimoire/spells/mass-heal")

#works well for spell info
Para <- html %>% html_nodes(".post-content") %>% html_text
head(Para)
listed <- strsplit(Para, "n\n")


listed <- list()
super.list <- list()
spelly <- 
  for(j in 1:10){
    listed <- NULL
    listed <- list()
for (i in Spell_List[[j]]){
  namey <- gsub("ge/", "ge-", trimws(i))
    namey <- gsub("ss/", "ss", trimws(namey))
        namey <- gsub("y/", "y-", trimws(namey))
  namey <- tolower(gsub(" ", "-", trimws(namey)))
    namey <-gsub("'", "", trimws(namey))
  ur <- paste("http://thebombzen.github.io/grimoire/spells", namey, sep='/')
  htm <- read_html(ur)
  Para <- htm %>% html_nodes(".post-content") %>% html_text
  listed[[i]] <- strsplit(Para, "\n")
  listed[[i]] <- unique(listed[[i]][[1]]) %>% trimws() %>% .[-2]
  
  
}
  super.list[[j]] <- listed
}
  
spell_description <- list(cantrip = super.list[[1]], level.1=super.list[[2]], level.2 = super.list[[3]], level.3 = super.list[[4]], level.4 = super.list[[5]], level.5 =super.list[[6]], level.6 = super.list[[7]], level.7 = super.list[[8]], level.8 = super.list[[9]], level.9=super.list[[10]])


prof <- c(2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6)

Saves <- c("Strength", "Dexterity", "Consititution", "Intelligence", "Wisdom", "Charisma")
Barbarian <- c(1, 0,1,0,0,0)
Bard <- c(0,1,0,0,0,1)
Cleric <- c(0,0,0,0,1,1)
Druid <- c(0,0,0,1,1,0)
Fighter <- c(1,0,1,0,0,0) 
Monk <- c(1,1,0,0,0,0)
Paladin <- c(0,0,0,0,1,1)
Ranger <- c(1,1,0,0,0,0)
Rogue <- c(0,1,0,1,0,0)
Sorcerer <-c(0,0,1,0,0,1)
Warlock <-c(0,0,0,0,1,1)
Wizard <- c(0,0,0,1,1,0)

class.table <- as.data.frame(cbind(Barbarian, Bard, Cleric, Druid, Fighter, Monk, Paladin, Ranger, Rogue, Sorcerer, Warlock, Wizard))
row.names(class.table) <- Saves

types.of.classes <- c("Barbarian", "Bard", "Cleric", "Druid", "Fighter", "Monk", "Paladin", "Ranger", "Rogue", "Sorcerer", "Warlock", "Wizard")



nam <- c("str", "dex", "con", "int", "wis", "char")
Elf <- c(0,2,0,0,1,0)
Halfing <- c(0,2,1,0,0,0)
Human <- c(1,1,1,1,1,1)
Dragonborn <- c(2,0,0,0,0,1)
Gnome <- c(0,0,1,2,0,0)
HE<- c(0,0,1,1,0,2)
HO <- c(2,0,1,0,0,0)
Tiefling <- c(0,0,0,1,0,2)
Dwarf <- c(2,0,2,0,0,0)
race.table <- data.frame(Elf, Halfing, Human, Dragonborn, Gnome, HE, HO, Tiefling, Dwarf)
row.names(race.table) <- nam
names(race.table) <- c("Elf", "Halfling", "Human", "Dragonborn", "Gnome", "Half-elf", "Half-orc", "Tiefling", "Dwarf")
race_table <- race.table
save(race_table, file = "race_table.rda")


skills <- c("Acrobatics","Animal Handling","Arcana","Athletics","Deception","History","Insight","Intimidation","Investigation","Medicine","Nature","Perception","Performance","Persuasion","Religion","Sleight of Hand","Stealth","Survival")

Barbarian.skills <- c("Animal Handling", "Athletics","Intimidation", "Nature", "Perception",  "Survival")
Bard.skills <- c("Preformance", "Persuasion", "Perception", "Arcana", "Insight","History")
Cleric.skills <- c("History", "Insight", "Medicine","Persuasion", "Religion")
Druid.skills <- c("Arcana", "Animal Handling", "Insight", "Medicine", "Nature","Perception", "Religion", "Survival")
Fighter.skills <- c("Acrobatics", "Animal Handling", "Athletics", "History", "Insight", "Intimidation", "Perception",  "Survival")
Monk.skills <- c("Acrobatics", "Athletics", "History","Insight", "Religion",  "Stealth")
Paladin.skills <- c("Athletics", "Insight", "Intimidation","Medicine", "Persuasion",  "Religion")
Ranger.skills <- c("Animal Handling","Athletics", "Insight", "Investigation", "Nature", "Perception", "Stealth",  "Survival")
Rogue.skills <- c("Athletics","Deception", "Insight", "Intimidation", "Investigation", "Perception", "Performance", "Persuasion", "Sleight of Hand",  "Stealth")
Socerer.skills <- c("Arcana", "Deception", "Insight","Intimidation", "Persuasion",  "Religion")
Warlock.skills <- c("Arcana","Deception", "History", "Intimidation", "Investigation", "Nature",  "Religion")
Wizard.skills <- c("Arcana", "History", "Insight","Investigation", "Medicine",  "Religion")

hold <- sapply(list(Barbarian.skills = Barbarian.skills, Bard.skills = Bard.skills, Cleric.skills = Cleric.skills, Druid.skills = Druid.skills, Fighter.skills = Fighter.skills, Monk.skills = Monk.skills, Paladin.skills = Paladin.skills, Ranger.skills = Ranger.skills, Rogue.skills = Rogue.skills, Socerer.skills = Socerer.skills, Warlock.skills = Warlock.skills, Wizard.skills = Wizard.skills), function(u) as.numeric(skills %in% u))
hold <- data.frame(hold)
row.names(hold) <- skills
colnames(hold) <- types.of.classes
Skills_by_Class <- hold
save(Skills_by_Class, "Skills_by_Class.rda")

Barbarian.ps <- c("str", "con", "dex", "wis", "char", "int")
Bard.ps <- c("char", "dex", "int", "con", "str", "wis")
Cleric.ps <- c("wis", "con", "str", "char", "int", "dex")
Druid.ps <- c("wis", "dex", "char", "int", "str", "con")
Fighter.ps <- c("str", "con", "dex", "int", "wis", "char")
Monk.ps <- c("dex", "wis", "con", "int", "char", "str")
Paladin.ps <- c("str", "char", "con", "wis", "dex", "int")
Ranger.ps <- c("dex", "wis", "con", "str", "char", "int")
Rogue.ps <- c("dex", "char", "int", "wis", "con", "str")
Socerer.ps <- c("char", "dex", "con", "wis", "int", "str")
Warlock.ps <- c("char", "dex", "str", "con", "int", "wis")
Wizard.ps <- c("int", "dex", "char", "con", "str", "wis")
stats.table <- data.frame(Barbarian.ps, Bard.ps, Cleric.ps, Druid.ps, Fighter.ps, Monk.ps, Paladin.ps, Ranger.ps, Rogue.ps, Socerer.ps, Warlock.ps, Wizard.ps)
colnames(stats.table) <- types.of.classes
stats_table <- stats.table
save(stats_table, file = "stats_table.rda")

#########################
## Stat Simulations

library(ggplot2)

n = 10000
fm<-replicate(n = n, expr = stat.roll(method = Ferguson.Method))
fm<-fm[1,,1:n]
pm<-replicate(n = n, expr= stat.roll(method = Pilsfer.Method))
pm<-pm[1,,1:n]
hm<-replicate(n = n, expr=stat.roll(method = Heroic.Method))
hm<-hm[1,,1:n]
bm<-replicate(n = n, expr=stat.roll(method = Base.Method))
bm<-bm[1,,1:n]
cm<-replicate(n = n, expr=stat.roll(method = Commoner.Method))
cm<-cm[1,,1:n]

#method<- as.data.frame(cbind(fm,pm,hm,bm,cm))

dat <- data.frame(xx = c(fm,pm,hm,bm,cm),yy = rep(c("fm","pm","hm","bm","cm"),each = n))

#ggplot(method) + geom_histogram(data = fm)

ggplot(dat, aes(x =xx)) + 
  geom_histogram(data=subset(dat,yy == 'fm'),fill = "red", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'pm'),fill = "blue", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'hm'),fill = "green", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'bm'),fill = "black", alpha = 0.2) +
  geom_histogram(data=subset(dat,yy == 'cm'),fill = "orange", alpha = 0.2)

 ggplot(dat, aes(x =xx)) +
   geom_histogram(data=subset(dat,yy == 'fm'),fill = "red", alpha = 0.4) +
   geom_histogram(data=subset(dat,yy == 'pm'),fill = "blue", alpha = 0.4) +
   geom_histogram(data=subset(dat,yy == 'hm'),fill = "green", alpha = 0.4) +
   geom_histogram(data=subset(dat,yy == 'bm'),fill = "black", alpha = 0.4) +
   geom_histogram(data=subset(dat,yy == 'cm'),fill = "orange", alpha = 0.4) +
facet_grid(yy ~ .) +  ggtitle("Stat Roll Methods") +  theme(legend.position="none") 



#Run this file and it should create two lists
#First list will have details of the ones that use spells

#Second List will have details of characters that dont use spells


url<- list()
spell.char<- list()
url[1] <- "http://www.5esrd.com/classes/bard/"
url[2] <- "http://www.5esrd.com/classes/ranger/"
url[3] <- "http://www.5esrd.com/classes/paladin/"
url[4] <- "http://www.5esrd.com/classes/wizard/"
url[5] <- "http://www.5esrd.com/classes/sorcerer/"
url[6] <- "http://www.5esrd.com/classes/cleric/"
url[7] <- "http://www.5esrd.com/classes/druid/"


for(i in 1:7)
{
  html <- read_html(url[i][[1]])
  tables <- html %>% html_table(fill=TRUE)
  #tables %>% purrr::map(glimpse)
  
  df<- tables[[2]]
  df<- as.data.frame(df)
  colnames(df)<- df[1,]
  df<- df[-1,]
  
  
  spell.char[[i]]<- df
  rm(df,html,tables)
  
}
names(spell.char)<- c("bard", "ranger", "paladin","wizard","sorcerer","cleric","druid")

nospell.char<- list()
urlnospell<- list()
urlnospell[1]<- "http://www.5esrd.com/classes/barbarian/"
urlnospell[2]<- "http://www.5esrd.com/classes/warlock/"
urlnospell[3]<- "http://www.5esrd.com/classes/fighter/"
urlnospell[4]<- "http://www.5esrd.com/classes/rogue/"
urlnospell[5]<- "http://www.5esrd.com/classes/monk/"
for(i in 1:2)
{
  html <- read_html(urlnospell[i][[1]])
  tables <- html %>% html_table(fill=TRUE)
  df<- tables[[1]]
  df<- as.data.frame(df)
  nospell.char[[i]]<- df
  rm(df,html,tables)
  
}

for(i in 3:5)
{
  html <- read_html(urlnospell[i][[1]])
  tables <- html %>% html_table(fill=TRUE)
  df<- tables[[2]]
  df<- as.data.frame(df)
  nospell.char[[i]]<- df
  rm(df,html,tables)
  
}
names(nospell.char)<- c("barbarian","warlock","fighter","rogue","monk")
nospell.char
spell.char[[1]][7,]

spell.char$warlock <- nospell.char$warlock
nospell.char$warlock <- NULL
