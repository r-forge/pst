\name{ppplot}
\docType{methods}
\alias{ppplot}
\alias{ppplot,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Plotting a branch of a PST
}
\description{
 The \code{ppplot} function displays the probability distributions of a context all its parent nodes (suffixes) in the tree. One can give a vector of pruning cutoffs as optional argument to this function, either for \eqn{r} or \eqn{C} or both, and the graphic will display the outcome of the gain function. 
}
\usage{
ppplot(object, path, state, r, C, cex.plot = 1, seqscale = 0.3, node.type = "circle", 
	pscale = seqscale/2, pruned.col = "red", div.col = "green", ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST
}
  \item{path}{
%%     ~~Describe \code{path} here~~
}
  \item{state}{
%%     ~~Describe \code{state} here~~
}
  \item{r}{
%%     ~~Describe \code{r} here~~
}
  \item{C}{
%%     ~~Describe \code{C} here~~
}
  \item{cex.plot}{
%%     ~~Describe \code{cex.plot} here~~
}
  \item{seqscale}{
%%     ~~Describe \code{seqscale} here~~
}
  \item{node.type}{
%%     ~~Describe \code{node.type} here~~
}
  \item{pscale}{
%%     ~~Describe \code{pscale} here~~
}
  \item{pruned.col}{
%%     ~~Describe \code{pruned.col} here~~
}
  \item{div.col}{
%%     ~~Describe \code{div.col} here~~
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
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
Alexis Gabadinho
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{prune}}
}
\examples{
data(s1)
s1.seq <- seqdef(s1)
S1 <- pstree(s1.seq, L=5)
ppplot(S1, "a-a-b-b-a")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }
