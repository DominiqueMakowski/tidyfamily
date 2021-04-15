#' Create family graph
#'
#' @inheritParams family_get_unions
#'
#' @examples
#' library(tidyfamily)
#' library(tidygraph)
#'
#' data <- dynasty_capetian()
#'
#' family_graph(data)
#' @export
family_graph <- function(data) {

  edges <- .family_get_edges(data)
  nodes <- .family_get_nodes(data)

  tidygraph::tbl_graph(nodes = nodes, edges = edges)
}



# Get nodes and edges -----------------------------------------------------





#' @importFrom tidyr pivot_longer
#' @importFrom dplyr transmute
.family_get_edges <- function(data) {

  unions <- tidyr::pivot_longer(family_get_unions(data), c("father", "mother"))
  unions <- data.frame(from = unions$value, to = unions$union, link = "Union", stringsAsFactors = FALSE)


  childrens <- family_get_children(data)
  childrens <- data.frame(from = childrens$union, to = childrens$id, link = "Child", stringsAsFactors = FALSE)

  rbind(unions, childrens)
}




.family_get_nodes <- function(data) {

  temp <- family_get_children(data)
  nodes <- unique(c(temp$id, temp$father, temp$mother))

  nodes <- data[data$id %in% nodes,]
  nodes$is_union <- FALSE

  nodes <- merge(nodes,
                 data.frame(id = unique(temp$union),
                            name = "Union",
                            is_union = TRUE),
                 all = TRUE)

  # Replace
  nodes$label <- nodes$name
  nodes$name <- nodes$id
  nodes
}
