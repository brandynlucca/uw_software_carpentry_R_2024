# Vectorizing your R code
# ᕕ(⌐■_■)ᕗ ♪♬

x <- 1:4
x * 2
y <- 6:9

# --- equivalent for loop
output_vector <- c()
for (i in 1:4) {
  output_vector[i] <- x[i] + y[i]
}
output_vector

sum_xy <- x + y
sum_xy

# example in gapminder
library(gapminder)

gapminder$pop_millions <- gapminder$pop / 1e6

ggplot(data = gapminder, aes( x = year, y = pop_millions)) +
  geom_point( )

# vectorized booleans
a <- x > 2
a

# applying vectorized functions
log(x)

# matrices
m <- matrix(1:12, nrow=3 , ncol=4)
m * -1
log(m)

# matrix math
m2 <- matrix(1, nrow=4, ncol=1)
m %*% m2

###
# x = 1/(1^2) + 1/(2^2) + 1/(3^2) + ... + 1/(n^2)
x <- sum(1/(1:1e6)^2)
x

# example function
inverse_sum_of_squares <- function(n) {
  sum(1/(1:n)^2)
}
inverse_sum_of_squares(1e6)

## things of unequal thing -- this will trigger an warning
x <- c(1, 2, 3)
y <- c(1, 2, 3, 4, 5, 6, 7)
x + y

### FUNCTIONS
my_function <- function(parameters) {
  # performing an action
  # returning a result
}

fahr_to_kelvin <- function(temp) {
  # perform action
  kelvin <- ((temp - 32) * (5/9)) + 273.15
  # return result
  return(kelvin)
}

fahr_to_kelvin(100)

kelvin_to_celsius <- function(temp) {
  # perform action
  celsius <- temp - 273.15
  # return result
  return(celsius)
}

kelvin_to_celsius(100)

fahr_to_celsius <- function(temp) {
  temp_kelvin <- fahr_to_kelvin(temp)
  temp_celsius <- kelvin_to_celsius(temp_kelvin)
  return(temp_celsius)
}

fahr_to_celsius(temp=200)
 
# Defensive programming
fahr_to_celsius <- function(temp) {
  if (!is.numeric(temp)) {
    stop("Temperature (`temp`) must be a numeric vector.")
  }
  
  temp_kelvin <- fahr_to_kelvin(temp)
  temp_celsius <- kelvin_to_celsius(temp_kelvin)
  return(temp_celsius)
}

fahr_to_celsius(temp=200)
fahr_to_celsius(temp="200")

fahr_to_celsius <- function(temp) {
  stopifnot(is.numeric(temp))
  
  temp_kelvin <- fahr_to_kelvin(temp)
  temp_celsius <- kelvin_to_celsius(temp_kelvin)
  return(temp_celsius)
}

fahr_to_celsius(temp=as.factor(200))

# Applying to the gapminder dataset
calcGDP <- function(dat) {
  gdp <- dat$pop * dat$gdpPercap
  return(gdp)
}

calcGDP(head(gapminder))

gapminder$GDP <- calcGDP(gapminder)
gapminder


### WRITING / SAVING DATA
# ---- saving ggplot plot -> ggsave(...)
africa_subset <- gapminder[gapminder$continent == "Africa", ]
africa_subset
# --- write.table
write.table(x=africa_subset,
            file="C:/Users/Brandyn/Documents/gapminder_africa_subset.csv",
            sep=",",
            row.names=FALSE)
# --- write.csv
write.csv(x=africa_subset,
          file="C:/Users/Brandyn/Documents/gapminder_africa_subset.csv",
          row.names=FALSE)

# RDS
saveRDS(africa_subset, 
        file="C:/Users/Brandyn/Documents/gapminder_africa_subset.rds")
# --- read it in
readRDS(file="C:/Users/Brandyn/Documents/gapminder_africa_subset.rds")

# RData
save(tmp_df, africa_subset, file="C:/Users/Brandyn/Documents/gapminder_bundled.RData")
## --- read it in
load("C:/Users/Brandyn/Documents/gapminder_bundled.RData")

### DATAFRAME MANIPULATION 
library(dplyr)

mean(gapminder$gdpPercap[gapminder$continent == "Africa"])
mean(gapminder$gdpPercap[gapminder$continent == "Americas"])
mean(gapminder$gdpPercap[gapminder$continent == "Asia"])

# in a tidy way
gapminder %>% 
  group_by(continent) %>% 
  summarize(mean_gdp_percap=mean(gdpPercap),
            sd_gdp_percap=sd(gdpPercap),
            max_gdp_percap=max(gdpPercap))
gapminder %>% 
  group_by(continent) %>% 
  reframe(mean_gdp_percap=mean(gdpPercap),
          sd_gdp_percap=sd(gdpPercap),
          max_gdp_percap=max(gdpPercap))
# --- multiple outputs
gapminder %>% 
  group_by(continent) %>% 
  reframe(quants=quantile(gdpPercap, c(0.25, 0.75)))

# selecting data
gapminder %>% select(continent, year, lifeExp)
dataframe2 <- gapminder %>% select(-GDP)

# renaming
gapminder %>% rename(population=pop)

# filtering
gapminder[gapminder$year == 2002, ]
gapminder %>% 
  filter(year == 2002, continent=="Americas", country=="Brazil") %>%
  select(country, continent, year, lifeExp)

gapminder %>% 
  filter(GDP == min(GDP))

gapminder %>% 
  group_by(continent, country) %>% 
  filter(GDP == min(GDP))

# arranging
gapminder %>% 
  arrange(desc(lifeExp)) %>% 
  slice(1:10)

gapminder %>% 
  arrange(desc(lifeExp)) %>% 
  head(10)

# some additional aggregation functions
gapminder %>% 
  filter(year == 2002) %>% 
  count(continent)

# mutate data
gapminder %>% 
  mutate(pop_billions = pop / 1e9) %>% 
  group_by(country) %>% 
  mutate(country_mean_pop = mean(pop))
