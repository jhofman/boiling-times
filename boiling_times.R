library(tidyverse)
library(modelr)

theme_set(theme_minimal())

# read in data
measurements <- read_csv('boiling_times.csv') %>%
  mutate(Temperature = as.numeric(Temperature))

# plot temperature over time
measurements %>%
  filter(Trial == 1) %>%
  mutate(Cups = as.factor(Cups)) %>%
  ggplot(aes(x = Time, y = Temperature, color = Cups)) +
  geom_point() +
  geom_line() +
  labs(x = 'Time (minutes)',
       y = 'Temperature (F)',
       color = 'Cups of water',
       title = 'Temperature over time for different amounts of water') +
  scale_x_continuous(breaks = 1:12)
ggsave('temp_over_time.png', width = 6, height = 4)

# plot boiling times and best fit line
measurements %>%
  filter(is.na(Temperature)) %>%
  ggplot(aes(x = Cups, y = Time)) +
  stat_smooth(method = "lm", fullrange = T, color = "grey50") +
  geom_point() +
  xlim(c(0,5)) +
  labs(x = 'Cups of water',
       y = 'Time to boil (minutes)',
       title = 'Boiling time for different amounts of water')
ggsave('boiling_times.png', width = 6, height = 4)
