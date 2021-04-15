#' Dynasties
#'
#'
#'
#' @examples
#' library(tidyfamily)
#'
#' dynasty_capetian()
#'
#'
#' @export
dynasty_capetian <- function(){
  family_member("Louis XIV", birth = "1638-09-05", death = "1715-09-01", sex = "Male") %>%
    family_member("Marie-Thérèse d'Autriche", birth = "1638-10-10", death = "1683-07-30", sex = "Female") %>%
    family_son("Louis1661", name = "Louis de France", birth = "1661-11-01", death = "1711-04-14", father = "Louis XIV", mother = "Marie-Thérèse d'Autriche") %>%
    family_daughter("Marie-Thérèse de France", text = "La Petite Madame", birth = 1667, death = 1672, father = "Louis XIV", mother = "Marie-Thérèse d'Autriche") %>%
    family_son("Philippe-Charles de France", text = "Duc d'Anjou", birth="1668-08-05", death = "1671-07-10", father = "Louis XIV", mother = "Marie-Thérèse d'Autriche") %>%
    # Louis1661's unit
    family_member("Marie Anne Christine de Bavière", birth = 1660, sex = "Female") %>%
    family_son("Louis1682", name = "Louis de France", text = "Duc de Bourgogne", birth=1682, death = 1712, father = "Louis1661", mother = "Marie Anne Christine de Bavière") %>%
    family_son("Philippe V", name = "Philippe V d'Espagne", birth=1683, death = 1746, father = "Louis1661", mother = "Marie Anne Christine de Bavière") %>%
    family_son("Charles", birth="1686-07-31", father = "Louis1661", mother = "Marie Anne Christine de Bavière") %>%
    # Louis1682's unit
    family_member("Marie-Adélaïde de Savoie", birth = "1685-12-06", death = "1712-02-12", sex = "Female") %>%
    family_son("Louis XV", birth = "1710-02-15", death = "1774-05-10", father = "Louis1682", mother = "Marie-Adélaïde de Savoie")
}

