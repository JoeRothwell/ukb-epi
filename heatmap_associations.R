# Association plots for digestive cancers manuscript

library(readxl)
library(tidyverse)
t2 <- read_xlsx("digestive_cancers.xlsx", sheet = 1)
ly <- read_xlsx("digestive_cancers.xlsx", sheet = 2)

# Discrete associations only
t2a <- t2 %>% filter(subsite != "subsite") %>%
  mutate(Association = ifelse(ci.low > 1, "Positive", ifelse(ci.high < 1, "Inverse", "None"))) 

expnames <- rep(c("All_diabet" , "F_diabet" ,  "M_diabet" , "All_pre_diabet" ,
            "F_pre_diabet" ,"M_pre_diabet", "All_metS_harm", "All_metS_ncep" ,
            "All_metS_IDF2" ,"F_metS_harm" ,"F_metS_ncep" ,"F_metS_IDF2",
            "M_metS_harm" ,"M_metS_ncep", "M_metS_IDF2", "Ob_harm" ,
            "Ob_ncep", "HDL", "hbA1c", "BP", "TG"), 11)

t2a$exposure <- expnames

ggplot(t2a, aes(x = fct_inorder(subsite), y = fct_rev(fct_inorder(exposure)), 
               fill = Association)) + 
  geom_tile(colour = "grey", size = 0.5) + theme_minimal() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  scale_fill_manual(values = c("#6BAED6", "#FFFFFF", "#FB6A4A")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        strip.text.y.right = element_text(angle = 0, hjust = 0),
        panel.spacing = unit(1, "lines")) +
  xlab("GI cancer") + ylab("Metabolic disorder") +
  facet_grid(fct_inorder(category) ~ ., scales = "free", space = "free")
#scale_fill_manual(values = c("#6BAED6", "white", "#FB6A4A")) #+
#scale_fill_fermenter()



# Strength of associations
t2b <- t2 %>% filter(subsite != "subsite") %>%
  #filter(analysis == "Diabetes incl") %>%
  mutate(Assoc = ifelse(ci.low > 1, estimate, ifelse(ci.high < 1, -(1/estimate), NA)))
t2b$exposure <- expnames

# Function to transform HRs to heatmap scale
#heatmap.hr <- function(x) ifelse(x > 1, x, ifelse(x < 1, -(1 / x), NA))


ggplot(t2b, aes(x = fct_inorder(subsite), y = fct_rev(fct_inorder(exposure)), 
                fill = Assoc)) + 
  geom_tile(colour = "grey", size = 0.5) + theme_minimal() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  #scale_fill_gradient2(low="red", high="blue", midpoint = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        strip.text.y.right = element_text(angle = 0, hjust = 0),
        panel.spacing = unit(1, "lines"),
        axis.title = element_blank()) +
  #xlab("GI cancer") + ylab("Metabolic disorder") +
  facet_grid(fct_inorder(category) ~ ., scales = "free", space = "free") +
  #scale_fill_manual(values = c("#6BAED6", "white", "#FB6A4A")) #+
  scale_fill_gradient2(na.value = "white") 


# 4 analyses as facets
t2c <- t2 %>% filter(subsite != "subsite") %>%
  mutate(Assoc = ifelse(ci.low > 1, estimate, ifelse(ci.high < 1, -(1/estimate), NA)))
t2c$exposure <- rep(expnames, 4)

# Function to transform HRs to heatmap scale
#heatmap.hr <- function(x) ifelse(x > 1, x, ifelse(x < 1, -(1 / x), NA))


ggplot(t2c, aes(x = fct_inorder(subsite), y = fct_rev(fct_inorder(exposure)), 
                fill = Assoc)) + 
  geom_tile(colour = "grey", size = 0.5) + theme_minimal() +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) +
  #scale_fill_gradient2(low="red", high="blue", midpoint = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        strip.text.y.right = element_text(angle = 0, hjust = 0),
        panel.spacing = unit(1, "lines"),
        axis.title = element_blank()) +
  #xlab("GI cancer") + ylab("Metabolic disorder") +
  facet_grid(fct_inorder(category) ~ analysis, scales = "free", space = "free") +
  #scale_fill_gradient() #+
  scale_fill_gradient2(na.value = "white", low = "blue", high = "red") 



