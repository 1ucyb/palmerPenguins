# Cleans cases in column names
clean_column_names <- function(penguins_data) {
    penguins_data %>%
        clean_names()
}

# Removes columns based on a vector of column names
remove_columns <- function(penguins_data, column_names) {
    penguins_data %>%
        select(-starts_with(column_names))
}

# Shortens species names
shorten_species <- function(penguins_data) {
    penguins_data %>%
        mutate(species = case_when(
            species == "Adelie Penguin (Pygoscelis adeliae)" ~ "Adelie",
            species == "Chinstrap penguin (Pygoscelis antarctica)" ~ "Chinstrap",
            species == "Gentoo penguin (Pygoscelis papua)" ~ "Gentoo"
        ))
}

# Removes empties
remove_empty_columns_rows <- function(penguins_data) {
    penguins_data %>%
        remove_empty(c("rows", "cols"))
}


# Removes NAs
remove_NA <- function(penguins_data) {
    penguins_data %>%
        na.omit()
}