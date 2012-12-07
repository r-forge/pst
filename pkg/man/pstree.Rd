\name{pstree}
\docType{methods}
\alias{pstree}
%% \alias{pstree-methods}
\alias{pstree,stslist-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Build a probabilistic suffix tree
}
\description{
Build a probabilistic suffix tree 
}
\usage{
\S4method{pstree}{stslist}(x, group, L, cdata=NULL, stationary=TRUE, 
	nmin = 1, ymin=NULL, weighted = TRUE, with.missing = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	a sequence object of class 'stslist' as defined with the seqdef function of the TraMineR library.
}
  \item{group}{
	a vector giving the group membership of each observation in x. If specified, a 'grouped' PST is produced containing one PST for each group. 
}
  \item{cdata}{ 
	Not implemented yet.
}
  \item{stationary}{ 
	Not implemented yet.
}
 \item{L}{
	maximal depth of the PST. Default to maximal length of the sequence(s) in object minus 1.
}
  \item{nmin}{
	minimum number of occurences of a string to add it in the tree 
}
  \item{ymin}{
	smoothing parameter for probabilities, so that no null probability is 
}
  \item{weighted}{
	logical. If TRUE, weights attached to the sequence object are used in the estimation of probabilities.
}
  \item{with.missing}{
	logical. If TRUE, the missing state is added to the alphabet
}
}
\details{
A PST is built by successively adding nodes corresponding to subsequences (contexts) \eqn{c} of increasing length \eqn{L}. Each node of the tree is labelled with a context \eqn{c} and stores the next symbol empirical probability distribution \eqn{\hat{P}(\sigma|c), \; \sigma \in A}. The root node stores the \eqn{0th} order probability \eqn{\hat{P}(\sigma), \; \sigma \in A} of oberving each symbol of the alphabet in the whole learning sample.\cr

The building algorithm calls the \code{\link{cprob}} function which returns the empirical next symbol counts observed after each context \eqn{c} and computes the corresponding empirical probability distribution. Each node in the tree is connected to its longest suffix, where the longest suffix of a string \eqn{c=c_{1},c_{2}, \ldots, c_{k}} of length \eqn{k} is \eqn{suffix(c)=c_{2}, \ldots, c_{k}}. 
}
\value{
	An object of class \code{"\linkS4class{PSTf}"}.
}
\references{
Maechler, M. & Buehlmann, P. Variable Length Markov Chains: Methodology, Computing, and Software \emph{Journal of Computational and Graphical Statistics}, 2004, 13, pp. 435-455

Ron, D.; Singer, Y. & Tishby, N. The power of amnesia: Learning probabilistic automata with variable memory length \emph{Machine Learning}, 1996, 25, 117-149

Bejerano, G. & Yona, G. Variations on probabilistic suffix trees: statistical modeling and prediction of protein families. \emph{Bioinformatics}, 2001, 17, 23-43
}
\author{
	Alexis Gabadinho
}

\seealso{
	\code{\link{prune}}
}
\examples{
## Builds a PST on one single sequence
data(s1)
s1.seq <- seqdef(s1)
s1.seq
S1 <- pstree(s1.seq, L = 3)
print(S1, digits = 3)
S1
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }

