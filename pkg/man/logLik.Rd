\name{logLik}
\docType{methods}
\alias{logLik}
\alias{logLik,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Log-Likelihood of a variable length Markov chain model
}
\description{
	Retrieve the log-likelihood of a fitted VLMC. This is the \code{\link{logLik}} method for objects of class \code{PSTf} returned by the \code{\link{pstree}} and \code{\link{prune}} functions.  
}
\usage{
\S4method{logLik}{PSTf}(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
a probabilistic suffix tree, i.e., an object of class \code{"\linkS4class{PSTf}"} as returned by the \code{\link{pstree}}, \code{\link{prune}} or \code{\link{tune}} function.
}
}
\details{
The likelihood of a learning sample containing \eqn{n} sequences, given a model \eqn{S} fitted to it, is
\deqn{
L(S)=\prod_{i=1}^{n} P^{S}(x^{i})
}
where \eqn{P^{S}(x^{i})} is the probability of the \eqn{i}th observed sequence predicted by \eqn{S}.
Note that the log-likelihood of a VLMC model is not used in the estimation of the model's parameters (see \code{\link{pstree}}). It is obtained once the model is estimated by calling the \code{\link{predict}} function. The value is stored in the \code{logLik} slot of the probabilistic suffix tree representing the model (a \code{PSTf} object returned by the \code{pstree} or \code{prune} function). 
	 The \code{AIC} and \code{BIC} values can also be obtained with the corresponding generic functions, which call \code{logLik} and use its result.
}
\value{
	An object of class \code{logLik}, a negative numeric value with the \code{df} (degrees of freedom) attribute containing the number of free parameters of the model.
}

\author{
	Alexis Gabadinho
}

\seealso{
	\code{\link[=stats4]{AIC}}, \code{\link[=stats4]{BIC}}
}

\examples{
## Loading the SRH.seq sequence object
data(SRH)

## Learning the model (the model includes missing states)
SRH.pst.L10m <- pstree(SRH.seq, nmin=2, ymin=0.001, with.missing=TRUE)
logLik(SRH.pst.L10m)

## Pruning the PST
C99m <- qchisq(0.99,6-1)/2
SRH.pst.L10m.C99 <- prune(SRH.pst.L10m, gain="G2", C=C99m)

## Comparing AIC
AIC(SRH.pst.L10m, SRH.pst.L10m.C99)
}

\keyword{models}

