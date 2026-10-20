library(tidyverse)
##1 Question1: Read the cleaned COVID data
df <- read_csv("cleaned_covid_data.csv")

names(df)

##2 Question2: Create A_states containing states beginning with A
A_states <- df %>%
  filter(grepl("^A", Province_State))

##3 Question3: Scatterplot of deaths over time with LOESS curve and separate faces for each state
ggplot(A_states,
       aes(x = Last_Update,
           y = Deaths)) +
  geom_point() +
  geom_smooth(method = "loess",
              se = FALSE) +
  facet_wrap(~ Province_State,
             scales = "free")

##4 Question4: Create state_max_fatality_rate dataframe

state_max_fatality_rate <- df%>%
  group_by(Province_State) %>%
  summarize(
    Maximum_Fatality_Ratio =
      max(Case_Fatality_Ratio,
          na.rm = TRUE)
  ) %>%
  arrange(desc(Maximum_Fatality_Ratio))


##5 Question5: Bar plot of maximum fatality ratio by state

ggplot(state_max_fatality_rate,
       aes(x = reorder(Province_State,
                       -Maximum_Fatality_Ratio),
           y = Maximum_Fatality_Ratio)) +
  geom_col() +
  theme(axis.text.x =
          element_text(angle = 90))
