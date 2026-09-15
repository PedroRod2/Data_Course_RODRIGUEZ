csv_files<- list.files( 
  path = "Data",
  pattern = "\\.csv$",
  full.names = TRUE
) 

csv_files


#1.Read 'wingspan_vs_mass.csv' using relative path and 
##save as an object
#2.what type of obj is this?
#3. how many rows and columns in the file?

#Relative Path
Data/wingspan_vs_mass.csv
Read.csv('Data/winspan_vs_mass.csv')

#save as object
filepath = 'Data/winspan_vs_mass.csv'
hahaha= read.csv(filepath)
str(hahaha)  #what kind of file it is
class(hahaha)  #what kind of file it is

#how many rows and columns
nrow(hahaha)
ncol(hahaha)
#other function for this is dimension
dim(hahaha) #[row, col]

#Read the top of the file
head(hahaha)
#Read the bottom of the file
tail(hahaha)

#Pop up the columns and rows file
View(hahaha)

#list of files
list.file('Data/')

#See what is inside each folder
list.files('Data/', recursive = F)
list.files('Data/', recursive = T)

#list all csv files
list.files('Data/', pattern = 'csv')

list.files('Data/', pattern = '.csv$')
list.files('Data/',pattern = '^s')

#lets you make your own function
my_fun = function(x, y){
  out = x + y 
  print(out)
}

source('my_fun')

##loop
i like apple
i like orange
i like banana
i like pear

fruit = c('apple', 'orange', 'banana', 'pear')

for (variable in fruit) {
  out = paste ('i like', variable)
  print(out)
} 

##try to write a for loop
song1
song2
song3
song4
music = c('song1', 'song2', 'song3', 'song4')
for (variable in music) {
  print(variable)
}

While loop 


my_fun(1,2)
my_fun(33,13748)

#1. create a data frame contains your favorite fruits (at least 3)
#and their calories
#3.After crearting the df, add a new col called calories_100'
# the value = original cal + 100
# 4. write a loop to print out 'calories_100'
#5. save the data frame to local 

df_fruit = data.frame(
  fruite = c('apple', 'orange', 'banana', 'pear'),
  cal = c(1,22,33,44)
)

df_fruit$fruit
df_fruit$calories_100 =1 
df_fruit$calories_100 = df_fruit$cal + 100
df_fruit



for (variable in df_fruit$calories_100) {
  print(variable)
}

write.csv(df_fruit, 
          "Favorite_fruits.csv",
          row.names = FALSE)

## 1. Save mtcars to a new obj
## 2. examine the obje. (ex: row, sols, col names...)

df_cars = mtcars

str(mtcars)
dim(mtcars)
names(df_cars)



## 3. What's max, min, average of mpg? 
max(df_cars$mpg)
min(df_cars$mpg)
mean(df_cars$mpg)

## 4. save cars with mpg> average to new obj

df_cars$mpg > 20
df_cars[df_cars$mpg > 20, ]
good_car = df_cars[df_cars$mpg > 20, 1:3]

## 5. save cars with mpg > average and cyl equal tp 4 to new object



#1 Read the file and save it as an object
df <-read.csv("Data/wingspan_vs_mass.csv")
#2 What type of object is this?
class(df)
#3 How many rows and columns?

dim(df)