\name{PSTr-class}
\Rdversion{1.1}
\docType{class}
\alias{PSTr-class}
\alias{[[,PSTr-method}
%\alias{plot,PSTr,ANY-method}
%\alias{print,PSTr-method}
\alias{summary,PSTr-method}

\title{Class \code{"PSTr"}}
\description{
This is the nested representation of a probabilistic suffix tree (PST). The \code{.Data} slot is a list whose elements are children nodes of class \code{"PSTr"}. This representation is used for printing and plotting PST, in which case the flat representation of a PST, i.e., an object of class \code{"\linkS4class{PSTf}"} is turned into an object of class \code{"PSTr"} by using the \code{as} function.
}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("PSTr", path, counts, n, order, ymin, index, ...)}.
%%  ~~ describe objects here ~~ 
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"list"} ~~ }
    \item{\code{alphabet}:}{Object of class \code{"character"} ~~ }
    \item{\code{labels}:}{Object of class \code{"character"} ~~ }
    \item{\code{cpal}:}{Object of class \code{"character"} ~~ }
    \item{\code{index}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{counts}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{n}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{prob}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{path}:}{Object of class \code{"character"} ~~ }
    \item{\code{order}:}{Object of class \code{"integer"} ~~ }
    \item{\code{leaf}:}{Object of class \code{"matrix"} ~~ }
    \item{\code{pruned}:}{Object of class \code{"matrix"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{list}"}, from data part.
Class \code{"\linkS4class{vector}"}, by class "list", distance 2.
}
\section{Methods}{
  \describe{
    \item{[[}{\code{signature(x = "PSTr")}: ... }
    \item{plot}{\code{signature(x = "PSTr", y = "ANY")}: plot a PST, see \code{\link{plot,PSTr,ANY-method}}.}
    \item{print}{\code{signature(x = "PSTr")}: print a PST, see \code{\link{print,PSTr-method}}.}
    \item{summary}{\code{signature(object = "PSTr")}: ... }
	 }
}

\author{
Alexis Gabadinho
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%%  ~~objects to See Also as \code{\link{~~fun~~}}, ~~~
%%  ~~or \code{\linkS4class{CLASSNAME}} for links to other classes ~~~
}
\examples{
showClass("PSTr")
}
\keyword{classes}
