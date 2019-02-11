#### Load Needed libraries ####
library(tidyverse) # Tidy data
library(magrittr)  # Pipes
library(readxl)    # Read data
library(ggsignif) 
library(ggpubr)

#### Importing Data ####
p_vulgaris <- read_xlsx('data.xlsx', sheet = "all_data") %>% 
  mutate(Group = ifelse(Group  %in% "Taty", "Tratamiento 1", 
                        ifelse(Group %in% "Daniel", "Tratamiento 2",
                               "Tratamiento 3"))) %>% 
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
  labs(color = "Tratamientos:") +
  scale_color_discrete(labels=c("Tratamiento 1",
                                "Tratamiento 2",
                                "Tratamiento 3")) +
  theme(legend.position="bottom")

#ggsave('plots/all_vars.png', height = 4, width = 4, scale = 1.75, dpi = 450)


#### Analysis ####
Pvulgaris_dt <- p_vulgaris %>%
  mutate(ID = row_number()) %>% spread(Variable, Value) %>% 
  select(-ID)
rownames(Pvulgaris_dt) <- make.unique(as.character(Pvulgaris_dt$Group))
Pvulgaris_dt %<>% select(-Group)
