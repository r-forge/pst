\name{pstree}
\alias{pstree}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Grow a Probabilistic Suffix Tree (PST)
}
\description{

}
\usage{
pstree(x, group, L, nmin = 1, ymin, weighted = TRUE, with.missing = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	a sequence object of class 'stslist' as defined with the seqdef function of the TraMineR library.
}
  \item{group}{
	a vector giving the group membership of each observation in x. If specified, a 'grouped' PST is produced containing one PST for each group. 
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
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
	an object of class 'PSTf', a list with L elements and following attributes 
	\item{data}{the sequence object x on which the PST is fitted}
	\item{alphabet}{the alphabet}
	\item{cpal}{color palette}
	\item{labels}{state long labels}
}
\references{
M\"{a}chler, M. & B\"{u}hlmann, P. Variable Length Markov Chains: Methodology, Computing, and Software \emph{Journal of Computational and Graphical Statistics}, 2004, 13, pp. 435-455

Ron, D.; Singer, Y. & Tishby, N. The power of amnesia: Learning probabilistic automata with variable memory length \emph{Machine Learning}, 1996, 25, 117-149

Bejerano, G. & Yona, G. Variations on probabilistic suffix trees: statistical modeling and prediction of protein families. \emph{Bioinformatics}, 2001, 17, 23-43
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
## Builds a PST on one single sequence
data(s1)
s1 <- seqdef(s1)
s1
S1 <- pstree(s1, L = 3)
print(S1, digits = 3)
S1
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
