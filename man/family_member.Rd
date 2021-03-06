% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/family_member.R
\name{family_member}
\alias{family_member}
\alias{family_child}
\alias{family_son}
\alias{family_daughter}
\title{Add Family Members}
\usage{
family_member(
  data = NULL,
  id = NULL,
  name = NULL,
  text = NA,
  sex = NA,
  birth = NA,
  death = NA,
  father = NA,
  mother = NA,
  born_of = "Wedding"
)

family_child(
  data = NULL,
  id = NULL,
  name = NULL,
  text = NA,
  sex = NA,
  birth = NA,
  death = NA,
  father = NA,
  mother = NA,
  born_of = "Wedding"
)

family_son(
  data = NULL,
  id = NULL,
  name = NULL,
  text = NA,
  sex = "Male",
  birth = NA,
  death = NA,
  father = NA,
  mother = NA,
  born_of = "Wedding"
)

family_daughter(
  data = NULL,
  id = NULL,
  name = NULL,
  text = NA,
  sex = "Female",
  birth = NA,
  death = NA,
  father = NA,
  mother = NA,
  born_of = "Wedding"
)
}
\arguments{
\item{data}{X}

\item{id}{X}

\item{name}{X}

\item{text}{X}

\item{sex}{X}

\item{birth}{X}

\item{death}{X}

\item{father}{X}

\item{mother}{X}

\item{born_of}{X}
}
\description{
Add family members.
}
\examples{
library(tidyfamily)

family_member(id = "Louis XIV", birth = "1638-09-05", death = "1715-09-01")

}
