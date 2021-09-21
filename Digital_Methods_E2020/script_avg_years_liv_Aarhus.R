# I am going to start by running Tidyverse.

library(tidyverse)

# Then I'm am going to read my csv file, which I've edited using OpenRefine. For the operation history please check my GitHub repository: https://github.com/Digital-Methods-HASS/AU618755_Ferrari_Maria. 
# I'm going to create an object called "records".
# Please adjust the following command according to the name of your directory/file.

records <- read_csv("data/Aarhus_citizen_records_edited.csv")

# In order to make a more readable visualization, I'm going to calculate the yearly average lifespan.
# Firstly, I have to create a data frame containing the columns with year of death and years lived.
# To do this I'm first making the columns into objects.

year_death <- records$year_death
years_liv <- records$years_liv

# Next I make the data frame.

df_year_death_and_years_liv <- data.frame(year_death, years_liv)

# Now I can make a new table containing average years lived per year.

avg_years_liv_pr_year <- df_year_death_and_years_liv %>% 
  group_by(year_death) %>% 
  summarise(avg_years_liv = mean(years_liv, na.rm = TRUE))

# I'm making the average years lived into an object. This is going to be the x-axis of my visualization.

avg_years_liv <- avg_years_liv_pr_year$avg_years_liv

# From this data I can make the visualization. It is going to be a combination of the point plot and a smoothed out graph. 

avg_years_liv_pr_year %>% 
  ggplot(aes(x = year_death, y = avg_years_liv))+
  geom_point(color = "cornsilk4") +
  xlim(1749, 1862) +
  geom_smooth(method = "loess", color = "deepskyblue3")
