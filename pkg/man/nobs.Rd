\name{nobs}
\docType{methods}
\alias{lnobs}
\alias{nobs,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Extract the number of observations to which a VLMC model is fitted
}
\description{
	The number of observations to which a VLMC model is fitted is notably used for computing the Bayesian Information Criterion \code{BIC}.
}
\usage{
\S4method{nobs}{PSTf}(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
}
\details{
This is the method for the generic \code{nobs} function provided by the \code{stats4} package. The number of observations to which a VLMC model is fitted is the total number of symbols in the learning sample. If the learning sample contains missing values and the model is learned without including missing values (see \code{\link{pstree}}), the total number of symbols is the number of non-missing states in the sequence(s). This information is used to compute the Bayesian information criterion of a fitted VLMC model. The \code{BIC} generic function calls the \code{\link{logLik}} and \code{nobs} methods for class \code{PSTf}.
}
\value{
	An integer containing the number of symbols in the learning sample.
}
\author{
	Alexis Gabadinho
}

\seealso{
	\code{\link[=stats4]{BIC}}
}
\examples{
data(s1)
s1.seq <- seqdef(s1)
S1 <- pstree(s1.seq, L=3)
nobs(S1)


## self rated health sequences
data(SRH)
state.list <- levels(SRH$p99c01)

## A custom color palette from red to green: self rated health is 'ordinal'
mycol5 <- rev(brewer.pal(5, "RdYlGn"))

SRH.seq <- seqdef(SRH, 5:15, alphabet=state.list, states=c("G1", "G2", "M", "B2", "B1"), 
	labels=state.list, weights=SRH$wp09lp1s, right=NA, cpal=mycol5)
names(SRH.seq) <- 1999:2009

## without considering missing states
m1 <- pstree(SRH.seq, L=4, nmin=2, ymin=0.001)
nobs(m1)

## considering missing states
m2 <- pstree(SRH.seq, L=4, nmin=2, ymin=0.001, with.missing=TRUE)
nobs(m2)
}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{models}