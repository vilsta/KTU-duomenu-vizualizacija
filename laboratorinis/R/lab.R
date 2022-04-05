#16 variantas
library(dplyr)
library(tidyverse)
library(readr)
library(ggplot2)
data1 <- read.csv("data/lab_sodra.csv")
summary(data1)
#1
data2 <- data1 %>%
  filter(ecoActCode == 460000)
data2 %>%
  ggplot(aes(x=avgWage)) +
  geom_histogram(bins = 100, col ="lightcoral", fill = "lightseagreen") + theme_minimal() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(size = 0.5),
        axis.ticks = element_line(color = "black", size = 1)) 
#2
data3 <- data1 %>%
  filter(ecoActCode == 460000) %>% group_by(code) %>% 
  summarise(suma = sum(avgWage)) %>% 
  arrange(desc(suma)) %>% head(5)
merged <- merge(data3, data1, by = "code")
merged %>% 
  ggplot(aes(x = month, y = avgWage, group = name)) +
  geom_line(aes(colour = name)) +
  theme_minimal() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(size = 0.5),
        axis.ticks.y = element_line(colour = "black", size = 1))
#3
merged %>% group_by(name) %>% 
  summarise(maxim = max(numInsured)) %>% 
  ggplot(aes(x = reorder(name, -maxim), y = maxim, fill = name)) +
  geom_col() + ylab("apdraustieji") + xlab("name") +
  theme_light() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), 
        axis.line = element_line(size = 0.5), 
        axis.ticks = element_line(color = "black", size = 1))
