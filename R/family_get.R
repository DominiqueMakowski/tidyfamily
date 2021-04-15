#' Get links of family
#'
#' @param data Family data.
#'
#' @export
family_get_unions <- function(data) {
  unions <- na.omit(data[c("father", "mother")])
  unions <- unions[!duplicated(unions), ]
  unions$union <- paste(unions$father, "+", unions$mother)
  unions
}

#' @rdname family_get_unions
#' @export
family_get_children <- function(data) {
  childrens <- na.omit(data[c("id", "father", "mother", "born_of")])
  childrens$union <- paste(childrens$father, "+", childrens$mother)
  childrens
}


