#### Load Needed libraries ####
library(tidyverse) # Tidy data
library(magrittr)  # Pipes
library(readxl)    # Read data

#### Importing Data ####
p_vulgaris <- read_xlsx('data.xlsx', sheet = "all_data") %>% 
  # Change variables to categoric data
  mutate_if(is.character, factor) %>%
  # Grouping variables
  group_by(Group, Variable) %>% 
  # Make same sample size for every var
  sample_n(10)


#### Plots ####
p_vulgaris %>% ggplot(aes(Group, Value, fill = Group)) + geom_boxplot() +
  facet_wrap('Variable', scales = 'free_x', ncol = 2) + theme_bw() +
  coord_flip() 
