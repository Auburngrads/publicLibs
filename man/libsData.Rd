% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/libsData.R
\name{libsData}
\alias{libsData}
\title{Build data sets for US Public Libraries}
\usage{
libsData(state = NULL, geocode = TRUE, ...)
}
\arguments{
\item{state}{Which state}

\item{geocode}{Should geocode data be provided?}

\item{...}{more options for ggmap::geocode}
}
\description{
Build data sets for US Public Libraries
}
\details{
This functions scrapes data from http://www.publiclibraries.com, recording the name, address, zipcode, latitude, and longitude for each public library in \code{state}.

The resulting data is stored as a .txt file in the extdata directory and an .rda file in the data/ directory.
}

