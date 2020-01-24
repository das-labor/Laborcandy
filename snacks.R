library(ggplot2)

# Daten vorbereiten
laborcandy <- data.frame(read.csv("candy.csv"))

# Neue Informationen aus vorhandenen Daten erstellen
laborcandy$kcalportion <- laborcandy$kcal100g/(100/laborcandy$gramm)
laborcandy$pricekcal <- laborcandy$price/laborcandy$kcalportion
laborcandy$priceperg <- laborcandy$price/laborcandy$gramm
laborcandy$kcalgramm <- laborcandy$kcalportion/laborcandy$gramm
laborcandy$grammkcal <- laborcandy$gramm/laborcandy$kcalportion

# Barplots für neue Informationen
barplot(laborcandy$pricekcal, names=laborcandy$name, main="Preis (in ct) pro kcal") # man bezahlt viel für eine kcal
barplot(laborcandy$priceperg, names=laborcandy$name, main="Preis (in ct) pro gramm")
#barplot(laborcandy.kcalportion, names=laborcandy$name, main="kcal pro Portion")
barplot(laborcandy$kcalgramm, names=laborcandy$name, main="kcal pro gramm")
barplot(laborcandy$kcal100g, names=laborcandy$name, main="kcal pro 100g")
barplot(laborcandy$grammkcal, names=laborcandy$name, main="gramm pro kcal")

# Verhältnis von Gramm-Preis zu kcal-Preis
kcalgramm.mean <- mean(laborcandy$kcalgramm)
pricekcal.mean <- mean(laborcandy$pricekcal)

## Daten in ggplot
ggplot(laborcandy, aes(x=pricekcal, y=kcalgramm)) +
  #annotate("rect", xmin=c(0,0), xmax=c(0,kcalgramm.mean), ymin=c(0,0), ymax=c(0,pricekcal.mean),alpha=0.1, color="blue", fill="blue")+
  geom_hline(yintercept=kcalgramm.mean, color="orange", size=1) + 
  geom_vline(xintercept=pricekcal.mean, color="orange", size=1) +
  geom_point(alpha=0.5) +
  annotate("text", x = c(0.25), y = c(4), label = c("wenig Geld,\nfür wenig kcal") , color="orange", size=5, fontface="bold", alpha=0.7) +
  annotate("text", x = c(0.25), y = c(5.95), label = c("viel Geld,\nfür wenig kcal") , color="orange", size=5, fontface="bold", alpha=0.7) +
  annotate("text", x = c(0.4), y = c(5.7), label = c("viel Geld,\nfür viel kcal") , color="orange", size=5, fontface="bold", alpha=0.7) +
  annotate("text", x = c(0.5), y = c(4), label = c("wenig Geld,\nfür viel kcal") , color="orange", size=5, fontface="bold", alpha=0.7) +
  geom_label(label=laborcandy$name, col="black") +
  labs(x="kcal pro Gramm", y="ct(€) pro Gramm") +
  ggtitle("Wie viel Cents zahle ich für wie viele kcal?")

