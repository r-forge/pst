\name{tune}
\docType{methods}
\alias{tune}
\alias{tune,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	AIC, AICc or BIC based model selection 
}
\description{
	Prune a probabilistic suffix tree with a series of cut-offs and select the model having the lowest value of the selected information criterion. Available information criterion are Akaike information criterion (AIC), AIC with a correction for finite sample sizes (AICc) and Bayesian information criterion (BIC).
}
\usage{
\S4method{tune}{PSTf}(object, gain="G2", C, criterion = "AIC", output = "PST")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	a probabilistic suffix tree, i.e., an object of class \code{"\linkS4class{PSTf}"} as returned by the \code{\link{pstree}}, \code{\link{prune}} or \code{\link{tune}} function.
}
  \item{gain}{ 
	character. The gain function used for pruning decisions. See \code{\link{prune}} for details.
}

  \item{C}{ 
	numeric. A vector of cutoff values. See \code{\link{prune}} for details.
}
  \item{criterion}{
	The criterion used to select the model, either AIC, AICc or BIC. AICc should be used when the ratio between the number of observations and the number of estimated parameters is usually low, which is often the case with VLMC models. \cite{Burnham et al, 2004} suggest to use AICc instead of AIC when the ratio is lower than 40.
}
  \item{output}{
	If \code{output='PST'} the PST (an object of class \code{"\linkS4class{PSTr}"}) having the lowest AIC, AICc or BIC value. If \code{output='stats'}, a table with the statistics for each model obtained by pruning \code{object} with the cut-offs in \code{C}. 
}
}
\details{
The \code{tune} function selects among a series of PST pruned with different values of the \eqn{C} cutoff the model having the lowest \eqn{AIC} or \eqn{AIC_{c}} value. The function can return either the selected PST or a data frame containing the statistics for each model.
}
\value{
	If \code{output="PST"} a PST that is an object of class \code{PSTf}. If \code{output="stats"} a matrix with the results of the tuning procedure.\cr 
The selected model is tagged with \code{***}, while models with \eqn{IC < min(IC)+2} are tagged with \code{**}, and models with \eqn{IC < min(IC)+10} are tagged with \code{**}.
}
\references{
Burnham, K. P. & Anderson, D. R. (2004) Multimodel Inference \emph{Sociological Methods & Research}, 33, pp. 261-304
}
\author{
Alexis Gabadinho
}

\seealso{
\code{\link{prune}}
}
\examples{
## Loading the SRH.seq sequence object
data(SRH)

## Working with a random sample of 500 sequences to
## reduce computing time of the example
subs <- sample(1:nrow(SRH.seq), size=500)
SRHsub.seq <- SRH.seq[subs,]

## Building a PST including missing state
SRH.pst <- pstree(SRHsub.seq, L=10, nmin=2, ymin=0.001, with.missing=TRUE)

## Cut-off list
alpha <- c(0.05, 0.01)
cutoffs <- qchisq(1-alpha, df=6-1)/2

tune(SRH.pst, gain="G2", C=cutoffs, output="stats", criterion="AICc")
}
\keyword{models}

