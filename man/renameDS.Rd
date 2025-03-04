% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/renameDS.R
\name{renameDS}
\alias{renameDS}
\title{Rename columns}
\usage{
renameDS(tidy_expr, df.name)
}
\arguments{
\item{tidy_expr}{list containing diffused expression.}

\item{df.name}{A data frame or tibble.}
}
\value{
An object of the same type as \code{df.name}, typically a data frame or tibble.
}
\description{
DataSHIELD implentation of\code{dplyr::rename}.
}
