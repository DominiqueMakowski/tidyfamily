#' Add Family Members
#'
#' Add family members.
#'
#' @param data X
#' @param id X
#' @param name X
#' @param text X
#' @param sex X
#' @param birth X
#' @param death X
#' @param father X
#' @param mother X
#' @param born_of X
#'
#' @examples
#' library(tidyfamily)
#'
#' family_member(id = "Louis XIV", birth = "1638-09-05", death = "1715-09-01")
#'
#' @export
family_member <- function(data = NULL, id = NULL, name = NULL, text = NA, sex = NA, birth = NA, death = NA, father = NA, mother = NA, born_of = "Wedding") {

  # Sanity checks
  if(is.character(data)) {
    id <- data
    data <- NULL
  }

  if(is.null(name)) {
    name <- id
  }

  if(is.null(id)) {
    stop("You must specify an 'id' for this member.")
  }

  # Sanitize dates
  birth <- .family_date(birth)
  death <- .family_date(death)

  # Create data
  member <- data.frame(id = as.character(id),
                       name = as.character(name),
                       text = text,
                       sex = sex,
                       birth_year = birth$year,
                       birth_month = birth$month,
                       birth_day = birth$day,
                       birth_text = birth$text,
                       death_year = death$year,
                       death_month = death$month,
                       death_day = death$day,
                       death_text = death$text,
                       father = father,
                       mother = mother,
                       born_of = born_of,
                       stringsAsFactors = FALSE)

  if(is.null(data)) {
    data <- member
  } else {
    data <- merge(data, member, all = TRUE)
  }
  data
}



# Children ----------------------------------------------------------------



#' @rdname family_member
#' @export
family_child <- family_member

#' @rdname family_member
#' @export
family_son <- function(data = NULL, id = NULL, name = NULL, text = NA, sex = "Male", birth = NA, death = NA, father = NA, mother = NA, born_of = "Wedding") {
  family_child(data = data, id = id, name = name, text = text, sex = sex, birth = birth, death = death, father = father, mother = mother, born_of = born_of)
}

#' @rdname family_member
#' @export
family_daughter <- function(data = NULL, id = NULL, name = NULL, text = NA, sex = "Female", birth = NA, death = NA, father = NA, mother = NA, born_of = "Wedding") {
  family_child(data = data, id = id, name = name, text = text, sex = sex, birth = birth, death = death, father = father, mother = mother, born_of = born_of)
}

