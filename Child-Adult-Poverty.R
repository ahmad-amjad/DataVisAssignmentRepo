getwd()
install.packages("plyr")
install.packages("reshape2")
library("reshape2")
options(scipen=999)
library(ggplot2)
library(plyr)
theme_set(theme_bw())

midwest = read.csv("Midwest.csv")

midwestLong = midwest[, c("county", "percchildbelowpovert", "percadultpoverty", "percelderlypoverty")]

midwestLong = melt(midwestLong, id.vars = "county",
                   measure.vars = c("percchildbelowpovert", "percadultpoverty", "percelderlypoverty"),
                   variable.name = "povertyperccategory", value.name = "percpoverty")

str(midwestLong)

cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")



p <- ggplot(na.omit(midwestLong)) + 
  geom_bar(aes(mapvalues(povertyperccategory, from = c("percchildbelowpovert", "percadultpoverty", "percelderlypoverty"),
                         to = c("Child", "Adult", "Elderly")),
               percpoverty, fill = povertyperccategory), show.legend = FALSE, stat = "summary", fun.y = "mean") + 
  scale_fill_manual(values=cbbPalette) + 
  labs(title = "Comparing Poverty Levels\nChild vs. Adult vs. Elderly", y="poverty percent", x="") +
  theme(plot.title = element_text(hjust = 0.5, face = "italic"))

p
