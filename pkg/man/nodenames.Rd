\name{nodenames}
\docType{methods}
\alias{nodenames}
%% \alias{nodenames-methods}
\alias{nodenames,PSTf-method}
\title{
	Retrieve the node names of a PST
}
\description{
	Retrieve the node names of a PST 
}
\usage{
\S4method{nodenames}{PSTf}(object, L)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{L}{
	integer. Th depth of the tree for which the node names are retrieved. If missing the names of all the nodes in the tree are returned.
}

}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
	An object of class \code{cprobd}, with available \code{round} method.
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
s1 <- seqdef(s1)
S1 <- pstree(s1, L=3)

nodenames(S1, L=3)
nodenames(S1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
