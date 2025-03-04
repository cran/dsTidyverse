% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/filterDS.R
\name{filterDS}
\alias{filterDS}
\title{Performs dplyr filter}
\usage{
filterDS(tidy_expr, df.name, .by, .preserve)
}
\arguments{
\item{tidy_expr}{Diffused expression that return a logical value, and are defined in terms of the
variables in \code{df.name}.}

\item{df.name}{A data frame, data frame extension (e.g. a tibble), or a lazy data frame
(e.g. from dbplyr or dtplyr).}

\item{.by}{Optionally, a selection of columns to group by for just this operation, functioning as
an alternative to \code{group_by}.}

\item{.preserve}{Relevant when the df.name input is grouped. If .preserve = FALSE (the default),
the grouping structure is recalculated based on the resulting data, otherwise the grouping is kept as is.}
}
\value{
An object of the same type as \code{df.name}, typically a data frame or tibble.
}
\description{
DataSHIELD implentation of \code{dplyr::filter}.
}
