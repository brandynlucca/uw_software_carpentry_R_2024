# Hello! ✌(ツ)
# CONTROL FLOW ᕦ(ツ)ᕤ
library(gapminder)

x <- c(12,10,8)

# if
if (x >= 10) {
  print("x is greater than 10")
} else if( x > 5) {
  print("x is greater than 5 but less than 10")
} else {
  print("x is less than 5")
}

####
x <- 4 == 3

if(x) {
  "4 equals 3"
}else {
  "4 does not equal 3"
}

##
gapminder[(gapminder$year == 2002), ]
gapminder[(gapminder$year == 2002),]
rows2002_number <- nrow(gapminder[gapminder$year == 2002, ])
rows2002_number

if(nrow(gapminder[gapminder$year == 2052, ]) >= 1){
  print("Record(s) for 2052 detected.")
}else{
  print("No records deteced for 2052.")
}

##
y <- c(-1,2,3,4,5,6)
ifelse(any(y<0), "some y is negative", "some y is positive")

####
for (i in 1:10) {
  print(i)
}

for (i in 1:5) {
  for (j in c("a", "b", "c", "d", "e")) {
    print(paste(i,j))
  }
}

output_vector <- c()
for (i in 1:5) {
  for (j in c("a", "b", "c", "d", "e")) {
    temp_output <- paste(i,j)
    output_vector <- c(output_vector, temp_output)
  }
}

output_matrix <- matrix(nrow = 5, ncol = 5)
j_vector <- c("a", "b", "c", "d", "e")
for (i in 1:5) {
  for (j in 1:5) {
    temp_j_value <- j_vector[j]
    temp_output <- paste(i, temp_j_value)
    output_matrix[i, j] <- temp_output
  }
}

# WHILE LOOPS
while(this condition is true){
  do a thing
}

z <- 1
while(z > 0.1){
  z <- runif(1)
  cat(z, "\n")
}

output_vector2 <- as.vector(output_matrix)
all(output_vector == output_vector2)
as.vector(t(output_matrix))
output_vector2 <- as.vector(t(output_matrix))
all(output_vector == output_vector2)

any(output_vector != output_vector2)

all(output_vector %in% output_vector2) 


##
gapminder
unique(gapminder$continent)

for (iContinent in unique(gapminder$continent)) {
  tmp <- gapminder[gapminder$continent == iContinent, ]
  cat(iContinent, mean(tmp$lifeExp, na.rm = TRUE), "\n")
  rm(tmp)
}

thresholdValue <- 50

for (iContinent in unique(gapminder$continent)) {
  tmp_df <- gapminder[gapminder$continent == iContinent, ]
  tmp <- mean(tmp_df$lifeExp)
  
  if (tmp < thresholdValue){
    cat("Average Life Expectancy in", iContinent, "is less than", thresholdValue, "\n")
  } else {
    cat("Average Life Expectancy in", iContinent, "is greater than", thresholdValue, "\n")
  }
  rm(tmp_df)
  rm(tmp)
}

lowerThreshold <- 50
upperThreshold <- 70

for (iCountry in unique(gapminder$country)) {
  tmp_df <- gapminder[gapminder$country == iCountry, ]
  tmp <- mean(tmp_df$lifeExp)
  
  if(tmp < lowerThreshold) {
    cat("Average life expectancy in", iCountry, "is less than", lowerThreshold, "\n")
  } else if(tmp > lowerThreshold && tmp < upperThreshold) {
    cat("Average life exp. in", iCountry, "is greater than", lowerThreshold, "but lower than", upperThreshold, "\n")
  } else {
    cat("Average life exp. in", iCountry, "is greater than", upperThreshold, "\n")
  }
}














