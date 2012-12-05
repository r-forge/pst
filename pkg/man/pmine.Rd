\name{pmine}
\docType{methods}
\alias{pmine}
%% \alias{pmine-methods}
\alias{pmine,PSTf,stslist-method}
\title{ PST based pattern mining }
\description{
Mine for (sub)sequences in a state sequence object satisfying user defined criteria
}

\usage{
\S4method{pmine}{PSTf,stslist}(object, data, l, pmin, pmax, lag, state, average=FALSE, output="sequences")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}

  \item{data}{
	a sequence object of class 'stslist' as defined with the \code{seqdef} function of the \code{\link{TraMineR}} library.
}
  \item{l}{
	length of the subsequence to search for.
}
  \item{pmin}{
	numeric. Minimal probability for selecting the (sub)sequence.
}
  \item{pmax}{
	numeric. Maximal probability for selecting the (sub)sequence.
}
  \item{lag}{
	integer. The \code{lag} first states in the sequence are omitted. 
}
  \item{state}{
}
  \item{average}{
	logical. If \code{TRUE}, the \code{pmin} or \code{pmax} probability is supposed to be the average state probability in the (sub)sequences. If \code{FALSE} (sub)sequences having every state probability less than \code{pmax} or greater than \code{pmin} are selected.
}
  \item{output}{
	character. If \code{output='sequences'} the whole sequence(s) where the user defined criteria is satisfied are returned. If \code{output='patterns'} only the (sub)sequences satisfying the user defined criteria are returned.
}
}
\details{
The likelihood \eqn{P^{S}(x)} of a whole sequence \eqn{x} is computed from the state probabilities at each position in the sequence. However, the likelihood of the first states is usually lower than at higher position due to a reduced memory available for prediction. A sequence may not appear as very likely if its first state has a low relative frequency, even if the model predicts high probabilities for the states at higher positions. 

The \code{pmine} function allows for advanced pattern mining with user defined parameters. It is controlled by the \code{lag} and \code{pmin} arguments. For example, by setting \code{lag=2} and \code{pmin=0.40} (example 1), we select all sequences with average (the geometric mean is used) state probability from position \eqn{lag+1, \ldots, \ell} above \code{pmin}. Instead of considering the average state probability at positions \eqn{lag+1, \ldots, \ell}, it is also possible to select frequent patterns that do not contain any state with probability below the threshold. This prevents from selecting sequences having many states with high probability but one ore several states with a low probability. 

It is also possible to mine the sequence data for frequent patterns of length \eqn{\ell_{j} < \ell}, regardless of the position in the sequence where they occur. By using the \code{output="patterns"} argument, the \code{pmine} function returns the patterns (as a sequence object) instead of the whole set of distinct sequences containing the patterns. Since the probability of a pattern can be different depending on the context (previous states) the returned subsequences also contain the context preceding the pattern.
}

\value{
	A state sequence object, that is an object of class \code{stslist} 
}
\author{
Alexis Gabadinho
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
 \code{\link{cmine}} for context mining
}
\examples{
## Preparing a sequence object with the SRH data set
data(SRH)
state.list <- levels(SRH$p99c01)
## sequential color palette
mycol5 <- rev(brewer.pal(5, "RdYlGn"))
SRH.seq <- seqdef(SRH, 5:15, alphabet=state.list, states=c("G1", "G2", "M", "B2", "B1"), 
	labels=state.list, weights=SRH$wp09lp1s, right=NA, cpal=mycol5)
names(SRH.seq) <- 1999:2009

## Learning the model (the model includes missing states)
SRH.pst <- pstree(SRH.seq, nmin=2, ymin=0.001, with.missing=TRUE)

## Pruning the PST
C99m <- qchisq(0.99,6-1)/2
SRH.pst.C99 <- prune(SRH.pst, gain="G2", C=C99m)

## Example 1
pmine.A <- pmine(SRH.pst.C99, SRH.seq, pmin=0.40, lag=2, average=FALSE)

## Example 2: Extract all patterns of length l=6 with pmin=0.6
pmine.B <- pmine(SRH.pst.C99, SRH.seq, l=6, pmin=0.6, output="patterns")
}
\keyword{ misc }
