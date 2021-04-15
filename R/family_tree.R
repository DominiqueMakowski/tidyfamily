#' @importFrom tidyr pivot_longer
#' @importFrom dplyr transmute
.family_get_edges <- function(data) {

  unions <- tidyr::pivot_longer(family_get_unions(data), c("father", "mother"))
  unions <- data.frame(from = unions$value, to = unions$union, link = "Union")


  childrens <- family_get_children(data)
  childrens <- data.frame(from = childrens$union, to = childrens$id, link = "Child")

  rbind(unions, childrens)
}
