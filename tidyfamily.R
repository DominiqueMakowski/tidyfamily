library(lubridate)

# https://github.com/adrienverge/familytreemaker

# Utilities ---------------------------------------------------------------


.family_date <- function(date, format = "%d %b %Y"){
  if(is.numeric(date)) {
    year <- date
    month <- NA
    day <- NA
    text <- as.character(year)
  } else {
    date <- lubridate::as_date(date)
    year <- lubridate::year(date)
    month <- lubridate::month(date)
    day <- lubridate::day(date)
    text <- format(date, format)
  }
  list(year = year, month = month, day = day, text = text)
}


family_add_person <- function(data = NULL, id = NULL, name = id, text = NA, sex = NA, birth = NA, death = NA, father = NA, mother = NA, born_of = "Mariage") {
  person <- data.frame(id = id, name = name, text = text, sex = sex, birth = lubridate::ymd(birth), death = lubridate::ymd(death), father = father, mother = mother, born_of = born_of)
}







family_add_parent <- function(data, parent_of, id, name = id, text = NA, sex = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {

  # Assign parent
  data[data$ID == parent_of, ifelse(sex == "Male", "Father", "Mother")] <- id

  # Add person
  person <- data.frame(
    ID = id,
    Name = name,
    Text = text,
    Sex = sex,
    Birth = lubridate::ymd(birth),
    Death = lubridate::ymd(death),
    Father = father,
    Mother = mother,
    Union = union
  )
  rbind(data, person)
}

family_add_father <- function(data, parent_of, id, name = id, text = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {
  family_add_parent(data, parent_of, id, name, text, sex = "Male", birth = birth, death = death, father = father, mother = mother, union = union)
}

family_add_mother <- function(data, parent_of, id, name = id, text = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {
  family_add_parent(data, parent_of, id, name, text, sex = "Female", birth = birth, death = death, father = father, mother = mother, union = union)
}



family_add_child <- function(data, id, name = id, text = NA, sex = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {

  # Add person
  person <- data.frame(
    ID = id,
    Name = name,
    Text = text,
    Sex = sex,
    Birth = lubridate::ymd(birth),
    Death = lubridate::ymd(death),
    Father = father,
    Mother = mother,
    Union = union
  )
  rbind(data, person)
}

family_add_son <- function(data, id, name = id, text = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {
  family_add_child(data, id, name, text, sex = "Male", birth = birth, death = death, father = father, mother = mother, union = union)
}

family_add_daugther <- function(data, id, name = id, text = NA, birth = NA, death = NA, father = NA, mother = NA, union = "Mariage") {
  family_add_child(data, id, name, text, sex = "Female", birth = birth, death = death, father = father, mother = mother, union = union)
}

# Generate data ----------------------------------------------------------------
library(dplyr)
library(ggraph)
library(tidygraph)

# Create data
data <- data.frame(
  ID = "Louis XIV",
  Name = "Louis XV",
  Text = "Roi de France",
  Sex = "Male",
  Birth = lubridate::ymd("1710-02-15"),
  Death = lubridate::ymd("1774-05-10"),
  Father = NA,
  Mother = NA,
  Union = "Mariage"
)



data <- data.frame(
  ID = "Louis XV",
  Name = "Louis XV",
  Text = "Roi de France",
  Sex = "Male",
  Birth = lubridate::ymd("1710-02-15"),
  Death = lubridate::ymd("1774-05-10"),
  Father = NA,
  Mother = NA,
  Union = "Mariage"
)

data <- data %>%
  family_add_father("Louis XV", id = "Louis1682", name = "Louis de France") %>%
  family_add_mother("Louis XV", id = "Marie-Adélaïde de Savoie", death = "1712-02-12") %>%
  family_add_father("Louis1682", id = "Louis1661", name = "Louis de France") %>%
  family_add_mother("Louis1682", id = "Marie-Anne Christine de Bavière") %>%
  family_add_son(father = "Louis1661", mother = "Marie-Anne Christine de Bavière", id = "Philippe", birth = "1683-01-01", death = "1746-01-01", text = "Roi d'Espagne") %>%
  family_add_son(father = "Louis1661", mother = "Marie-Anne Christine de Bavière", id = "Charles", birth = "1686-07-31") %>%
  family_add_father("Louis1661", id = "Louis XIV", birth = "1638-09-05", death = "1715-09-01") %>%
  family_add_mother("Louis1661", id = "Marie-Thérèse d'Autriche")

# Plot --------------------------------------------------------------------


# Get unions
unions <- na.omit(data[c("Father", "Mother", "Union")])
unions <- unions[!duplicated(unions), ]
unions$Union_ID <- paste(unions$Father, "+", unions$Mother)

edges <- unions %>%
  tidyr::pivot_longer(c("Father", "Mother")) %>%
  transmute(from = Union_ID, to = value, Link = Union)

nodes <- data[data$ID %in% unique(c(edges$from, edges$to)), ] %>%
  merge(data.frame(ID = unions$Union_ID, Union = unions$Union, Name = unions$Union, Sex = "Union"), all = TRUE) %>%
  rename(name = ID)


# Get Children
childrens <- na.omit(data[c("ID", "Father", "Mother", "Union")])
childrens$Union_ID <- paste(childrens$Father, "+", childrens$Mother)

edges <- childrens %>%
  transmute(from = Union_ID, to = ID, Link = "Child") %>%
  rbind(edges)

nodes <- data[data$ID %in% childrens$ID, ] %>%
  rename(name = ID) %>%
  merge(nodes, all = TRUE)





# Aesthetics

tbl_graph(nodes = nodes, edges = edges) %>%
  ggraph(layout = "nicely") +
  geom_edge_link(aes(color = Link)) +
  geom_node_label(aes(label = Name))




