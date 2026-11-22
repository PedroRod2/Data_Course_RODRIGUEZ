library(tidyverse)

mushroom_growth <- read.csv("C:/Users/11037267/Desktop/Data_Course_RODRIGUEZ/Data/mushroom_growth.csv")

head(mushroom_growth)

ggplot(mushroom_growth, aes(x = Light, y = GrowthRate)) +
  geom_point()
