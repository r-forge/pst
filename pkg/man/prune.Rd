\name{prune}
\alias{prune}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Prune a PST
}
\description{
Prune an existing PST, with either the method proposed in or in Maechler-2004
}
\usage{
prune(object, nmin, L, r, K, topdown = TRUE, delete = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class PST.list as created with the pstree function.
}
  \item{nmin}{
	Integer. All strings having counts less than nmin are removed.
}
  \item{L}{
	Integer. If specified the the tree is cut at depth L., that is all nodes with depth > L are removed.

}
  \item{r}{
	Numeric. The pruning parameter 
}
  \item{K}{
	Numeric. The pruning parameter described in Maechler
}
  \item{topdown}{
%%     ~~Describe \code{topdown} here~~
}
  \item{delete}{
	Logical. If FALSE, the pruned nodes are not really removed from the tree but tagged as pruned=FALSE, so that when plotting the pruned tree these nodes wil appear surrounded with red (can be set to another color) lines.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
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
