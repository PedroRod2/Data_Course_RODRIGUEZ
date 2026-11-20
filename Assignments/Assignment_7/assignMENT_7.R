library(tidyverse)
# Import the Utah religion dataset
religion <- read_csv("Utah_Religions_by_County.csv")

#Look at the first few rows
View(religion)

# Create a tidy version of the dataset
religion_long <- religion%>%
  pivot_longer(
    cols = c(
      "Assemblies of God",
      "Episcopal Church",
      "Pentecostal Church of God",
      "Greek Orthodox",
      "LDS",
      "Southern Baptist Convention",
      "United Methodist Church",
      "Buddhism-Mahayana",
      "Catholic",
      "Evangelical",
      "Muslim",
      "Non Denominational",
      "Orthodox"
    ),
    names_to = "Religion_Group",
    
    values_to = "Proportion"
    
  )

# The religion groups were stretched out horizontally and now they are stored as separate columns
# Using pivot_longer() creates a tidy dataset where religion becomes a variable and the proportion a value.

View(religion_long)

#Exploratory Figure 1 
# I want to see how county population varies across Utah.

ggplot(religion,
       aes(x = County,
           y = Pop_2010)) +
  geom_col() +
  
  coord_flip()

# Salt Lake County has the largest population by a wide margin.
# Utah County and Davis County also have relatively large populations.
# Several rural counties have much smaller populations. 

#Exploratory figure 2
# I want to compare the distribution of religious groups across Utah counties and identify which religions vary the most. 

ggplot(religion_long,
       aes(x = Religion_Group,
           y = Proportion)) +
  geom_boxplot() +
  
  coord_flip()

#LDS has the highest proportion across most counties and shows much larger values than other religious groups.

#Catholic and Evangelical groups appear to have modest proportions across many counties.

#Several religious groups such as Muslim, Orthodox, and Assemblies of God have proportions near zero in most counties.

#There is also variation among counties, as show by the spread and outliers within some religious groups. 

#Exploratory figure 3
#I want to examine whether larger counties tend to have different LDS proportion than smaller counties. 

ggplot(religion,
       aes(x = Pop_2010,
           y = LDS)) +
  
  geom_point() +
  
  geom_smooth(method = "lm")

#The trend line appears relatively flat, suggesting little relationship between county population and LDS proportion

#Counties of different population sizes often have similar LDS proportions. 

#Population alone may not be a strong predictor of LDS proportion. 

cor(religion$Pop_2010,
    religion$LDS)

#The correlation between population and LDS proportion is approximately -0.003

#This value is extremely close to zero, suggesting almost no linear relationship between county population and LDS proportion. 

#Based on this correlation, larger counties do not necessarily have higher or lower LDS proportion than smaller counties. 

#Explotary Figure 4
#I want to examine whether county population is related to Catholic proportion

ggplot(religion,
       aes(x = Pop_2010,
           y = Catholic)) +
  geom_point() +
  
  geom_smooth(method = "lm")

cor(religion$Pop_2010,
    religion$Catholic)

#The correlation between population and catholic proportion is approximately 0.159. 

#This suggests a weak positive relationship between county population and catholic proportion

#Larger counties may tend to have slightly higher catholic proportions, although the relationship appears weak. 

# From LDS and Catholic correlation we can conclude that county population appears to have little relationship with LDS proportion
# County population has a weak positive relationship with catholic proportion. 
#The effect of population on religious proportions does not appear particularly strong.

#Exploratory Figure 5
#I want to examine whether county population is related to evangelical proportion

ggplot(religion,
       aes(x = Pop_2010,
           y = Evangelical)) +
  geom_point() +
  
  geom_smooth(method = "lm")

cor(religion$Pop_2010,
    religion$Evangelical)

#The correlation between population and Evangelical proportion is approximately 0.038. 
#This value is very close to zero, suggesting little relationship between county population and Evangelical proportion. 
#Similar to LDS, population does not appear to strongly influence Evangelical proportion across counties. 

#Question 1
#Based on the LDS, Catholic, and Evangelical analyses, county population does not appear to have a strong relationship with religious proportions.
#Lds showed essentially no relationship with population, while Catholic and Evangelical showed only weak positive relationships. 
#Overall, county population does not appear to be a strong predictor of the proportion of a specific religious group. 

#Question 2
#I want to examine whether LDS proportion is related to the proportion of non-religious people. 

ggplot(religion,
       aes(x = LDS,
           y = `Non-Religious`)) +
  geom_point() +
  
  geom_smooth(method = "lm")

cor(religion$LDS,
    religion$`Non-Religious`)

#The correlation between LDS proportion and Non-Religious proportion is approximately -0.870. 
#This indicates a strong negative relationship between LDS proportion and Non-Religious proportion. 
#Counties with larger LDS populations tend to have smaller Non-Religious populations. 
#This is the strongest relationship observed so far in the analysis. 

#Question 2 conclusion
#The proportion of a specific religion can be strongly related to the proportion of Non-Religious people. 
#In particular, LDS proportion has a stron negative correlation with Non-Religious proportion. 
#Counties with higher LDS proportions generally have lower proportions of Non-Religious residents.



