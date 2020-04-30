getwd()
install.packages("plyr")
install.packages("reshape2")
library("reshape2")
options(scipen=999)
library(ggplot2)
library(plyr)
theme_set(theme_bw())

midwest = na.omit(read.csv("Midwest.csv"))

midwest$percchildbelowpovert_type <- ifelse(midwest$percchildbelowpovert < mean(midwest$percchildbelowpovert), "below", "above")
midwest$countyState <- paste(midwest$county,midwest$state)

midwest <- midwest[order(midwest$percchildbelowpovert), ]
midwest$countyState <- factor(midwest$countyState, levels = midwest$countyState)

p <- ggplot(midwest, aes(x=countyState, y=percchildbelowpovert, label = percchildbelowpovert)) + 
  geom_bar(aes(fill = percchildbelowpovert_type), stat = "identity", width=.5) + 
  scale_fill_manual(name="Child Poverty", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  labs(title = "Diverging Bars", subtitle = "Percent Child Poverty of each County") +
  coord_flip()

p


midwest$percchildbelowpovert_z <- round((midwest$percchildbelowpovert - 
                                           mean(midwest$percchildbelowpovert))/sd(midwest$percchildbelowpovert), 2)
midwest$percchildbelowpovert_type <- ifelse(midwest$percchildbelowpovert_z < 0, "below", "above")

midwest <- midwest[order(midwest$percchildbelowpovert_z), ]
midwest$countyState <- factor(midwest$countyState, levels = midwest$countyState)

p <- ggplot(midwest, aes(x=countyState, y=percchildbelowpovert_z, label = percchildbelowpovert_z)) + 
  geom_bar(aes(fill = percchildbelowpovert_type), stat = "identity", width=.5) + 
  scale_fill_manual(name="Child Poverty", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  labs(title = "Diverging Bars", subtitle = "Percent Child Poverty of each County") +
  coord_flip()

p

ggsave('p.png', p, height = 50, width = 20, limitsize = F)

midwesttop30 <- midwest[order(midwest$poptotal), ]
midwesttop30 <- tail(midwesttop30, 30)
midwesttop30 <- midwesttop30[order(midwesttop30$percchildbelowpovert_z), ]

p <- ggplot(midwesttop30, aes(x=countyState, y=percchildbelowpovert_z, label = percchildbelowpovert_z)) + 
  geom_bar(aes(fill = percchildbelowpovert_type), stat = "identity", width=.5) + 
  scale_fill_manual(name="Child Poverty", 
                    labels = c("Above Average", "Below Average"), 
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  labs(title = "Diverging Bars", subtitle = "Percent Child Poverty of each County") +
  coord_flip()

p


