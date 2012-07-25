\name{cmine}
\docType{methods}
\alias{cmine}
\alias{cmine,PSTf-method}
\alias{'[',cprobd.list-method}
\alias{plot,cprobd.list,ANY-method}

\title{ Mining contexts }
\description{
 Extracting contexts in a PST satisfying user defined criterion
}
\usage{
	\S4method{cmine}{PSTf}(object, l, pmin, pmax, state, as.tree=FALSE)
}

\arguments{
  \item{object}{
	A fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}

  \item{l}{
	length of the context to search for.
}
  \item{pmin}{
	numeric. Minimal probability for selecting the (sub)sequence.
}
  \item{pmax}{
	numeric. Maximal probability for selecting the (sub)sequence.
}

  \item{state}{
	character. One or several states of the alphabet for which the (cumulated) probability is greater than \code{pmin} or less than \code{pmax}.
}

}

\section{details}{
}

\value{
	If \code{as.tree=TRUE} a PST, that is an object of class \code{PSTf} than can be printed and plotted; if \code{as.tree=FALSE} a list of contexts with their associated next symbol probability distribution, that is an object of class \code{cprobd.list} for which a \code{plot} method is available. Subscripts can be used to select subsets of the contexts, see examples. 
}

\author{
Alexis Gabadinho
}

\keyword{methods}
\keyword{ ~~ other possible keyword(s) ~~ }
