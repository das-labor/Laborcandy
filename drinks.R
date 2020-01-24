d <- read.csv("drinks.csv")

ggplot(d, aes(x=pricekcal, y=kcalgramm))