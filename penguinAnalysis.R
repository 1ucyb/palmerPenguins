##### Setup and data cleaning
# Installing packages

library(tidyverse)
library(palmerpenguins)
library(here)
library(janitor)
library(ragg)
library(svglite)

# Accesses functions
source(here("functions", "cleaning.R"))

# Saving raw data as .csv

write_csv(penguins_raw, here("data", "penguins_raw.csv"))
penguins_raw <- read_csv(here("data", "penguins_raw.csv"))

# Cleaning data

penguins_clean <- penguins_raw %>%
  clean_column_names() %>%
  remove_columns(c("comments", "delta")) %>%
  shorten_species() %>%
  remove_empty_columns_rows()

# Writes clean output as .csv

write_csv(penguins_clean, here("data", "penguins_clean.csv"))

##### Now onto plotting

# Colour-blind friendly colour mappings

colourMappings = c("Adelie" = "darkorange",
                   "Chinstrap" = "purple",
                   "Gentoo" = "cyan4")
 
# Actual plotting

flipperBoxplot = ggplot(penguins_clean, aes(x = species,
                           y = flipper_length_mm,
                           col = species,
                           show.legend = FALSE)) +
  geom_boxplot() +
  geom_jitter(na.rm = TRUE, alpha = 0.3) +
  theme(legend.position = "none") +
  scale_colour_manual(breaks = "species",
                      values = c("Adelie" = "darkorange",
                                 "Chinstrap" = "purple", 
                                 "Gentoo" = "cyan4")) +
  theme_bw() +
  labs(x = "Species", y = "Flipper length (mm)")

##### Saving figures as pngs and svgs

# Using ragg

agg_png("figures/penguin_boxplot_vector.png",
        width = 20,
        height = 20,
        res = 300,
        units = "cm",
        scaling = 2)
print(flipperBoxplot)
dev.off()

# Using svglite

inchesConversion = 2.54

svglite("figures/penguin_boxplot_vector.svg",
        width = 20 / inchesConversion,
        height = 20 / inchesConversion,
        scaling = 2)
print(flipperBoxplot)
dev.off()
