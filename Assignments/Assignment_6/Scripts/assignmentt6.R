library(tidyverse)

dat <- read_csv("Data/BioLog_Plate_Data.csv")
View(dat)

dat_long <- dat %>%
  pivot_longer(
    cols = c(Hr_24, Hr_48, Hr_144),
    names_to = "Time",
    values_to = "Absorbance"
  )

dat_long <- dat_long %>%
  mutate(
    Type = case_when(
      `Sample ID` %in% c("Soil_1", "Soil_2") ~ "Soil",
      True ~ "Water"
    )
  )
View(dat_long)



names(dat_long)
unique(dat_long$`Sample ID`)

dat_long <- dat_long %>%
  mutate(
    Time = recode(
      Time,
      "Hr_24" = "24",
      "Hr_48" = "48",
      "Hr_144" = "144"
    ),
    Time = as.numeric(Time)
  ) 

plot1_data <- dat_long %>%
  group_by(Substrate, Type, Time) %>%
  summarise(
    Mean_Absorbance = mean(Absorbance),
    .groups = "drop"
  )
plot1 <- ggplot(
  plot1_data,
  aes(
    x = Time,
    y = Mean_Absorbance,
    color = Type,
    group = Type
  )
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ Substrate) +
  scale_x_continuous(
    breaks = c(24, 48, 144)
  ) +
  theme_bw()

plot1


ggsave(
  "Figures/Plot1.png",
  plot1,
  width = 12,
  height = 8
) 

library(gganimate)
anim_data <- dat_long %>%
  group_by(
    Substrate,
    Dilution,
    `Sample ID`,
    Time
  ) %>%
  summarise(
    Mean_Absorbance = mean(Absorbance),
    .groups = "drop"
  )

anim_plot <- ggplot(
  anim_data,
  aes(
    x = Time,
    y = Mean_Absorbance,
    color = `Sample ID`,
    group = `Sample ID`
  )
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ Dilution) +
  scale_x_continuous(
    breaks = c(24, 48, 144)
  ) +
  theme_bw() +
  transition_states(Substrate) +
  labs(
    title = "Substrate: {closest_state}"
  )

animate(anim_plot)
View(anim_data)
anim_save("Figures/Biolog_Animation.gif")
