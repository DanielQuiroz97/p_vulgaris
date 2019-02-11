#### Load Needed libraries ####
library(tidyverse) # Tidy data
library(magrittr)  # Pipes
library(readxl)    # Read data
library(ggsignif) 
library(ggpubr)

#### Importing Data ####
p_vulgaris <- read_xlsx('data.xlsx', sheet = "all_data") %>% 
  # Change variables to categoric data
  mutate_if(is.character, factor) %>%
  # Grouping variables
  group_by(Group, Variable) %>% 
  # Make same sample size for every var
  sample_n(10)


#### Plots ####
p_vulgaris %>% ggplot(aes(Group, Value, color = Group)) + 
  geom_boxplot(alpha = 0.6) +
  geom_point(aes(color = Group), size = 0.8) +
  facet_wrap('Variable', scales = 'free_y', ncol = 2) + theme_cleveland() +
  stat_compare_means(method = "anova") +
  labs(color = "Tratamiento") +
  scale_color_discrete(labels=c("Control", "Treatment 1", "Treatment 2"))


