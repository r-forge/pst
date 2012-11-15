\name{pdist}
\docType{methods}
\alias{pdist}
\alias{pdist,PSTf,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Compute probabilistic divergence between two PST
}
\description{
Compute probabilistic divergence between two PST
}
\usage{
\S4method{pdist}{PSTf}(x,y, method="cp", l, ns=5000, symetric=FALSE, output="values", ...)
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
  \item{output}{
	character. See \code{value}.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
The function computes a probabilistic distance measure between PST $S_{1}$ and $S_{2}$ based on the measure originally proposed in \cite{Juang-1985, Rabiner-1989}.
}
\value{
If \code{ouput='values'}, a vector containing the distance value of the for each generated sequence, if \code{output="mean"}, the mean, i.e. expected value which is the distance between models.
}
\references{
Juang, B. H. and Rabiner, L. R. (1985). A probabilistic distance measure for hidden Markov models. \emph{ATT Technical Journal} \bold{64}(2), 391-408.
Rabiner, L. R. (1989). A tutorial on hidden Markov models and selected applications in speech recognition. \emph{Proceedings of the IEEE} \bold{77}(2), 257-286.
}
\author{
Alexis gabadinho
}
\note{
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
