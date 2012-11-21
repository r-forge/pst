\name{logLik}
\docType{methods}
\alias{logLik}
\alias{logLik,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Log Likelihood of a VLMC model
}
\description{
	Compute the log likelihood of a fitted VLMC stored in a probabilistic suffix tree. This the generic \code{\link{logLik}} method for objects of class \code{PSTf} returned by the \code{\link{pstree}} and \code{\link{prune}} methods.  
}
\usage{
\S4method{logLik}{PSTf}
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
}
\details{
	To compute the log lokelihood the method calls the \code{\link{predict}} method to compute the probability of the sequences stored in the \code{\link{data}} slot of \code{object}, i.e. the learning sample to which the PST was fittted.
	 The \code{AIC} and \code{BIC} generic functions are also available as they call \code{logLik} and use its results.
}
\value{
	An object of class \code{logLik}, a negative numeric value with the \code{df} (degrees of freedom) attribute containing the number of free parameters in the PST and a \code{nobs} attribute containing the number of symbols in the learning sample.
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
data(s1)
s1.seq <- seqdef(s1)
S1 <- pstree(s1.seq, L=3)
logLik(S1)	
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
