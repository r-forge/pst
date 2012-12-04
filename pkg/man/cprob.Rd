\name{cprob}
\docType{methods}
\alias{cprob}
%% \alias{cprob-methods}
\alias{cprob,stslist-method}

\title{
	Empirical conditional probability distributions of order \code{L}
}
\description{
	Compute the empirical conditional probability distributions of order L from a set of sequences
}
\usage{
\S4method{cprob}{stslist}(object, L, cdata=NULL, context, stationary=TRUE, nmin=1, prob=TRUE, 
weighted=TRUE, with.missing=FALSE, to.list=FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	a sequence object, that is an object of class stslist as created by TraMineR \code{\link[=TraMineR]{seqdef}} function.
}
\item{L}{ 
integer. Context length.
}
\item{cdata}{ 
under development 
}
\item{context}{
	character. An optional subsequence (a character string where symbols are separated by '-') for which the conditional probability distribution is to be computed.
}
\item{stationary}{
   logical. If \code{FALSE} probability distributions are computed for each sequence position L+1 ... l where l is the maximal sequence length. If \code{TRUE} the probability distributions are  stationary that is time homogenous. 
}
\item{nmin}{
	integer. Minimal frequency of a context. See details.
}
\item{prob}{
	logical. If \code{TRUE} the probability are returned. If \code{FALSE} the counts are returned.
}
\item{weighted}{
	logical. If \code{TRUE} case weights attached to the sequence object are used in the computation of the probabilities. 
}
\item{with.missing}{
	logical. If \code{FALSE} only contexts contining no missing status are considered. 
}
\item{to.list}{
	logical. If \code{TRUE} and \code{stationary=TRUE}, a list instead of a matrix is returned. See \code{value}.
}
}
\details{
	The \code{cprob()} function returns either the empiral probability distributions of order \code{L} or the counts on which the probabilities are computed. The empirical conditional probability \eqn{\hat{P}(\sigma | x)} of observing a symbol \eqn{\sigma \in A} after the subsequence \eqn{x} of length \eqn{l=L} is computed as 
\deqn{
\hat{P}(\sigma | x) = \frac{N(x\sigma)}{\sum_{\sigma \in A} N(x\sigma)}
}
where \eqn{N(x\sigma)} is the observed frequency of the subsequence \eqn{x\sigma}, that is the concatenation of the subsequence \eqn{x} and the symbol \eqn{\sigma}. The empirical probability \eqn{\hat{P}(\sigma | x)} is the maximal likelihood estimator of the probability \eqn{P(\sigma | x)}.
}
\value{
	Either a matrix if \code{stationary=FALSE} with one row for each subsequence of length $L$ and minimal frequency $nmin$ appearing in \code{object}, or a list where each element corresponds to one subsequence and contains a matrix whith the probability distribution at each position \eqn{p} where a state is preceded by the subsequence.  
}

\author{
Alexis Gabadinho
}

\examples{
	data(s1)
	s1 <- seqdef(s1)
	cprob(s1, L=0, prob=FALSE)
	cprob(s1, L=1, prob=TRUE)
	cprob(s1, L=1, prob=FALSE)
	cprob(s1, L=1, prob=TRUE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
