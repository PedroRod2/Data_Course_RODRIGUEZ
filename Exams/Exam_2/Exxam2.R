library(tidyverse)

unicef <- read_csv("Exam_2/unicef-u5mr.csv")
names(unicef)

glimpse(unicef)

unicef_long <- unicef %>%
  pivot_longer(
    cols = starts_with("U5MR"),
    names_to = "Year",
    values_to = "U5MR"
  )

unicef_long <- unicef_long %>%
  mutate(
    Year = str_remove(Year, "U5MR\\."),
    Year = as.numeric(Year)
  )

View(unicef_long)

plot1 <- unicef_long %>%
  ggplot(aes(x = Year,
             y = U5MR,
             group = CountryName)) +
  geom_line() +
  facet_wrap(~ Continent)

plot1
ggsave(
  "RODRIGUEZ_Plot_1.png",
  plot = plot1
)

continent_mean <- unicef_long %>%
  group_by(Continent, Year) %>%
  summarise(
    mean_U5MR = mean(U5MR, na.rm = TRUE)
  )

plot2 <- continent_mean %>%
  ggplot(aes(x = Year,
             y = mean_U5MR,
             color = Continent)) +
  geom_line()

plot2

mod1 <- lm(
  U5MR ~ Year,
  data = unicef_long
)

mod2 <- lm(
  U5MR ~ Year + Continent,
  data = unicef_long
)

mod3 <- lm(
  U5MR ~ Year * Continent,
  data = unicef_long
)

summary(mod1)
summary(mod2)
summary(mod3)

#mod3 is the best model because it has the highest adjusted R-squared (0.6399) and the lowest residual standard error (49.96)
#This suggests that allowing the relationship between Year and U5MR to vary among continents provides the best fit to the data.

unicef_model <- unicef_long %>%
  filter(!is.na(U5MR))

pred1 <- unicef_model %>%
  mutate(
    pred = predict(mod1),
    model = "mod1"
  )

pred2 <- unicef_model %>%
  mutate(
    pred = predict(mod2),
    model = "mod2"
  )

pred3 <- unicef_model %>%
  mutate(
    pred = predict(mod3),
    model = "mod3"
  )

all_preds <- bind_rows(pred1, pred2, pred3)

pred_plot <- all_preds %>%
  ggplot(aes(x = Year,
             y = pred,
             color = Continent)) +
  geom_line() +
  facet_wrap(~ model)

pred_plot

ggsave(
  "RODRIGUEZ_Plot_2.png",
  plot = plot2
)