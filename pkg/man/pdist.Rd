\name{pdist}
\alias{pdist}
\alias{pdist,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Compute probabilistic distance between two PST
}
\description{
Compute probabilistic distance between two PST
}
\usage{
\S4method{pdist}{PSTf,PSTf}(
pdist(x,y, method="cp", l, ns=5000, symetric=FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{y}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
} 
  \item{method}{
	character. Method for computing distances. So far only one method is available.
}
 \item{l}{
	integer. Length of the sequence(s) to generate.
}
  \item{ns}{
	integer. Number sequences to generate.
}
  \item{symetric}{
	logical. If \code{TRUE}, the symetric version of the measure is returned, see details.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
The function computes a probabilistic distance measure 
}
\value{
A state sequence object (an object of class \code{stslist}) containing \code{n} sequences. This object can be passed as argument to all the functions for visualization and analysis provided by the \code{\link{TraMineR}} package. 
}
\references{


}
\author{
%%  ~~who you are~~
}
\note{
Alexis Gabadinho
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
data(s1)
s1.seq <- seqdef(s1)
S1 <- pstree(s1.seq, L=3)
generate(S1, n=10, l=10, method="prob")
## First state is generated with p(a)=0.9 and p(b)=0.1
generate(S1, n=10, l=10, method="prob", p1=c(0.9, 0.1))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
