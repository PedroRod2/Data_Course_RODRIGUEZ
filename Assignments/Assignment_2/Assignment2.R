# 4 write a command that lists all csv files in the Data and stores that list in an object called csv_files

csv_files <- list.files(
  path = "Data",
  pattern = "\\.csv$",
  full.names = TRUE
)

csv_files

#5 Find how many files match that description using the length() function

length(csv_files)

#6 open the wingspan_vs_mass.csv file and store the contents as an R object name "df" using the read.csv() function

df <- read.csv("Data/wingspan_vs_mass.csv")

#7 inspect the first 5 lines of this data set using the head() function

head(df, 5)

#8 Find any files (recursively) in the Data/directory that begin with the letter "b" (lowercase)

b_files <- list.files(
  path = "Data",
  pattern = "^b",
  recursive = TRUE,
  full.names = TRUE
)

b_files

b_files

#9 Write a command that displays the first line of each of those "b" files (this is tricky..use a for-loop)

for(file in b_files)
{
  cat("\nFile:", file, "\n")
  
  tryCatch(
    {
      first_line <- readLines(file, n = 1)
      print(first_line)
    },
    error = function(e)
    {
      print("Could not read file")
    })
}
  
