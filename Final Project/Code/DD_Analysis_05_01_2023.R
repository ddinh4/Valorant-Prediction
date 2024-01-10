library(readxl)
library(easypackages)
library(dplyr)
library(olsrr)   
library(caret)   
library(leaps)    
library(MASS)    
library(tidyverse)    
library(car)
libraries("ggplot2","MASS","aod","ResourceSelection")

df1 <- read_excel("C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_CompetitiveCareer_02_25_2023.xlsx")
str(df1)
df2 <- df1[, -c(1,5,10,11)]
df2$Results[df2$Results == "W"] <- 1
df2$Results[df2$Results == "L"] <- 0
df2$Results[df2$Results == "D"] <- ""
df2$Agent[df2$Agent == "sage"] <- "Sage"
df2$Agent[df2$Agent == "reyna"] <- "Reyna"
df2$Agent[df2$Agent == "brimstone"] <- "Brimstone"
df2
df2[df2 == ""] <- NA
df3 <- df2[complete.cases(df2), ]
str(df3)
response_index <- which(names(df3) == "Results")
df <- df3[, c(response_index, 1:(response_index-1), (response_index+1):ncol(df3))]

#df3<- df2$Results <- ifelse(df2$Results == "W", 1, ifelse(df2$Results == "L", 0, df2$Results))


#barplot(df3$Results, names.arg = df3$Agent, main = "Bar Plot", xlab = "Agent", ylab = "Results")
freq_table <- table(df$Agent, df$Results)
freq_table
row_perc <- prop.table(freq_table, margin = 1) * 100
Breach <- row_perc[1,2]   
Brimstone <- row_perc[2,2]
Cypher  <- row_perc[3,2]   
Jett   <- row_perc[4,2]    
Killjoy  <- row_perc[5,2] 
Neon   <- row_perc[6,2]   
Omen  <- row_perc[7,2]    
Raze   <- row_perc[8,2]    
Reyna <- row_perc[9,2]   
Sage  <- row_perc[10,2]   
Skye  <- row_perc[11,2]    
Sova  <- row_perc[12,2]    
Viper <- row_perc[13,2]

plot <- barplot(freq_table, beside = FALSE, legend = TRUE, col = rainbow(13), main = "Agent Win Rate")
ggsave("C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/AgentWR.jpeg",plot)



freq_table2 <- table(df$Map, df$Results)
freq_table2
row_perc2 <- prop.table(freq_table2, margin = 1) * 100
Ascent  <- row_perc2[1,2]
Bind   <- row_perc2[2,2]  
Breeze   <- row_perc2[3,2]
Fracture <- row_perc2[4,2]
Haven  <- row_perc2[5,2] 
Icebox  <- row_perc2[6,2] 
Lotus  <- row_perc2[7,2]   
Pearl  <- row_perc2[8,2]  
Split  <- row_perc2[9,2] 

plot2 <- barplot(freq_table2, beside = FALSE, legend = TRUE, col = rainbow(9), main = "Map Win Rate")
ggsave(filename = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/MapWR.jpg", plot = plot2, dpi = 300)

freq_table3 <- table(df$Placement, df$Results)
freq_table3
row_perc3 <- prop.table(freq_table3, margin = 1) * 100
Placement1  <- row_perc3[1,2] 
Placement2   <- row_perc3[2,2] 
Placement3   <- row_perc3[3,2]  
Placement4 <- row_perc3[4,2] 
Placement5  <- row_perc3[5,2]  
Placement6  <- row_perc3[6,2] 
Placement7  <- row_perc3[7,2]  
Placement8   <- row_perc3[8,2] 
Placement9   <- row_perc3[9,2] 
Placement10  <- row_perc3[10,2] 

plot3 <- barplot(freq_table3, beside = FALSE, legend = TRUE, col = rainbow(10), main = "Placement Win Rate")
ggsave(filename = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/PlacementWR.jpg", plot = plot3, dpi = 300)

freq_table4 <- table(df$`Average Rank of Match`, df$Results)
freq_table4
row_perc4 <- prop.table(freq_table4, margin = 1) * 100
BronzeI  <- row_perc4[1,2]    
BronzeII   <- row_perc4[2,2]  
BronzeIII <- row_perc4[3,2]
GoldI   <- row_perc4[4,2]    
GoldII   <- row_perc4[5,2]   
GoldIII    <- row_perc4[6,2]  
PlatinumI  <- row_perc4[7,2]  
PlatinumII   <- row_perc4[8,2]
PlatinumIII <- row_perc4[9,2]
SilverI <- row_perc4[10,2]    
SilverII   <- row_perc4[11,2]
SilverIII  <- row_perc4[12,2] 

plot4<- barplot(freq_table4, beside = FALSE, legend = TRUE, col = rainbow(12), main = "Average Rank of Match Win Rate")
ggsave(filename = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/RankWR.jpg", plot = plot3, dpi = 300)

overallwinrate <- mean(df$Results == 1) * 100

df$Agent[df$Agent == "Breach"] <- Breach
df$Agent[df$Agent == "Brimstone"] <- Brimstone
df$Agent[df$Agent == "Cypher"] <- Cypher
df$Agent[df$Agent == "Jett"] <- Jett
df$Agent[df$Agent == "Killjoy"] <- Killjoy
df$Agent[df$Agent == "Neon"] <- Neon
df$Agent[df$Agent == "Omen"] <- Omen
df$Agent[df$Agent == "Raze"] <- Raze
df$Agent[df$Agent == "Reyna"] <- Reyna
df$Agent[df$Agent == "Sage"] <- Sage
df$Agent[df$Agent == "Skye"] <- Skye
df$Agent[df$Agent == "Sova"] <- Sova
df$Agent[df$Agent == "Viper"] <- Viper

df$Map[df$Map == "Ascent"] <- Ascent
df$Map[df$Map == "Bind"] <- Bind
df$Map[df$Map == "Breeze"] <- Breeze
df$Map[df$Map == "Fracture"] <- Fracture
df$Map[df$Map == "Haven"] <- Haven
df$Map[df$Map == "Icebox"] <- Icebox
df$Map[df$Map == "Lotus"] <- Lotus
df$Map[df$Map == "Pearl"] <- Pearl
df$Map[df$Map == "Split"] <- Split

df$Placement[df$Placement == "1"] <- Placement1
df$Placement[df$Placement == "2"] <- Placement2
df$Placement[df$Placement == "3"] <- Placement3
df$Placement[df$Placement == "4"] <- Placement4
df$Placement[df$Placement == "5"] <- Placement5
df$Placement[df$Placement == "6"] <- Placement6
df$Placement[df$Placement == "7"] <- Placement7
df$Placement[df$Placement == "8"] <- Placement8
df$Placement[df$Placement == "9"] <- Placement9
df$Placement[df$Placement == "10"] <- Placement10

df$`Average Rank of Match`[df$`Average Rank of Match` == "Bronze I"] <- BronzeI
df$`Average Rank of Match`[df$`Average Rank of Match` == "Bronze II"] <- BronzeII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Bronze III"] <- BronzeIII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Gold I"] <- GoldI
df$`Average Rank of Match`[df$`Average Rank of Match` == "Gold II"] <- GoldII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Gold III"] <- GoldIII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Platinum I"] <- PlatinumI
df$`Average Rank of Match`[df$`Average Rank of Match` == "Platinum II"] <- PlatinumII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Platinum III"] <- PlatinumIII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Silver I"] <- SilverI
df$`Average Rank of Match`[df$`Average Rank of Match` == "Silver II"] <- SilverII
df$`Average Rank of Match`[df$`Average Rank of Match` == "Silver III"] <- SilverIII

cols_to_convert <- names(df)[-1]
df[, cols_to_convert] <- lapply(df[, cols_to_convert], as.numeric)
str(df)

write.csv(df, file = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_CleanCompetitiveCareer_05_01_2023.csv", row.names = FALSE)

logmodel <- glm(as.factor(Results) ~ ., data = df, family = "binomial")
stepboth.model <- stepAIC(logmodel, direction = "both",
                          trace = FALSE)
stepwise_summary <- summary(stepboth.model)
log_summary <- summary(logmodel)
stepwise_summary
log_summary

#log_coefficients <- coef(log_summary)
#log_statistics <- coef(summary(log_summary))
#log_summary_data <- data.frame(Coefficients = log_coefficients, log_statistics)
#write.csv(log_summary_data, file = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/logistic_regression_summary.csv", row.names = FALSE)
#stepwise_coefficients <- coef(stepwise_summary)
#stepwise_statistics <- coef(summary(stepwise_summary))
#stepwise_summary_data <- data.frame(Coefficients = stepwise_coefficients, stepwise_statistics)
#write.csv(stepwise_summary_data, file = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Results/stepwise_summary.csv", row.names = FALSE)

reduced_df <- df[, -c(5,8,10,11,13,15,16)]
write.csv(reduced_df, file = "C:/Users/ddinh/OneDrive/Documents/EXST 7087/Final Project/Data/DD_ReducedCleanCompetitiveCareer_05_01_2023.csv", row.names = FALSE)

logmodel2 <- glm(as.factor(Results) ~ ., data = reduced_df, family = "binomial")
summary(logmodel2)
