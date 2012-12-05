\name{print-methods}
\docType{methods}
\alias{print-methods}
\alias{print,ANY-method}
\alias{print,PSTf-method}
\alias{print,PSTr-method}
\title{ Print method for objects of class \code{PSTf} and \code{PSTr} }

\description{
Display a probabilistic suffix tree
}

\usage{
\S4method{print}{stslist}(x, max.level = NULL, digits.d = 1, give.attr = FALSE, 
    wid = getOption("width"), nest.lev = 0, indent.str = "", 
    stem = "--")
}

\arguments{
  \item{x}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{max.level}{ 
	integer. The maximal depth for the display of the tree.
}

  \item{max.level}{ 
	integer. The maximal depth for the display of the tree.
}

}

\section{Methods}{
\describe{

\item{\code{signature(x = "ANY")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(x = "PSTf")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(x = "PSTr")}}{
%%  ~~describe this method here~~
}
}}
\keyword{methods}
\keyword{print}


