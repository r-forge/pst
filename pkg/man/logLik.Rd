\name{logLik}
\alias{logLik}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Log Likelihood of a PST
}
\description{
	Compute the log likelihood of a fitted PST object. This the generic \code{\link{logLik}} method for objects of class \code{\link{PSTf}}.  
}
\usage{
logLik(object, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class \code{\link{PSTf}} as returned by \code{\link{pstree}} or \code{\link{prune}}.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
	To compute the log lokelihood the method calls the \code{\link{predict}} method to compute the proability of the sequences stored in the \code{\link{data}} slot of \code{\link{object}} (the data on which the PST was fittted).
}
\value{
	An object of class \code{logLik}, a negative numeric value with the \code{df} (degrees of freedom) attribute contining the number of free parameters in the PST. 
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
	Alexis Gabadinho
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
structure(function (object, ...) 
standardGeneric("logLik"), generic = structure("logLik", package = "stats"), package = "stats", group = list(), valueClass = character(0), signature = "object", default = structure(function (object, 
    ...) 
UseMethod("logLik"), target = structure("ANY", class = structure("signature", package = "methods"), .Names = "object", package = "methods"), defined = structure("ANY", class = structure("signature", package = "methods"), .Names = "object", package = "methods"), generic = structure("logLik", package = "stats"), class = structure("derivedDefaultMethod", package = "methods")), skeleton = structure(function (object, 
    ...) 
UseMethod("logLik"), target = structure("ANY", class = structure("signature", package = "methods"), .Names = "object", package = "methods"), defined = structure("ANY", class = structure("signature", package = "methods"), .Names = "object", package = "methods"), generic = structure("logLik", package = "stats"), class = structure("derivedDefaultMethod", package = "methods"))(object, 
    ...), class = structure("standardGeneric", package = "methods"))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
