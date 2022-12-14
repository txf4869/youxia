% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/config.R
\name{config_data}
\alias{config_data}
\title{Config data of 'NHANES' database}
\usage{
config_data(data)
}
\arguments{
\item{data}{data of 'NHANES' database. If data is missing, Demographics,
Dietary, Examination, Laboratory and Questionnaire will be used.}
}
\value{
add "data.nhanes" file to "nhanesR" directory
}
\description{
Config data of 'NHANES' database
}
\examples{
\donttest{
config_data(c("Demographics", "Dietary", "Examination",  "Laboratory", "Questionnaire"))
}
}
