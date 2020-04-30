getwd()
install.packages("plyr")
options(scipen=999)
library(ggplot2)
library(plyr)
theme_set(theme_bw())

midwest = read.csv("Midwest.csv")
midwest

p <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
  labs(subtitle = "Area vs Population", y="Population", x="Area", title = "Scatterplot", caption = "Source: midwest")

p

p <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  labs(subtitle = "Area vs Population", y="Population", x="Area", title = "Scatterplot", caption = "Source: midwest")

p

p <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + ylim(c(500000,6000000)) + 
  labs(subtitle = "Area vs Population", y="Population", x="Area", title = "Scatterplot", caption = "Source: midwest")

p

p <- ggplot(midwest, aes(x= (inmetro), y=percbelowpoverty))
p + geom_bar(stat="identity")

p

p <- ggplot(na.omit(midwest[, c("inmetro", "percbelowpoverty")])) + 
  geom_bar(aes(mapvalues(as.factor(inmetro), from = c("0", "1"), to = c("In Metro Area", "Not In Metro Area")),
               percbelowpoverty, fill = factor(inmetro)), stat = "summary", fun.y = "mean") + 
  labs(title = "Percent of population under the poverty level by Metro Area", y="population percentage", x="") +
  theme(plot.title = element_text(hjust = 0.5, face = "italic"))

p

       
       