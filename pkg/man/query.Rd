\name{query}
\docType{methods}
\alias{query}
%% \alias{query-methods}
\alias{query,PSTf-method}
\title{
	Retrieve counts or next symbol probability distribution from a Probabilistic Suffix Tree
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
query(object, context, state, output = "prob", exact = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} method.

}
  \item{context}{
	Character. The string labelling the node to retrieve. States must be separated by '-' as for example in 'a-a-b'. If the node labelled with this string does not exist in the tree, the node labelled with the longest suffix is searched for, and so on until an existing node is  found.
}
  \item{state}{
	character. If specified the probability of the specified state is returned instead of the whole distribution.
}
  \item{output}{
	character. If output="prob" the probability distribution (or a single symbol distribution if state is specified) is returned. If output="counts" the counts on which the probability distribution is calculated are returned. If output="all" the node itself is returned, that is an object of class PSTr.
}
  \item{exact}{
	logical. If TRUE, the information is returned only if the node labelled with context is present in the tree. That is, the longest suffix of context is not searched for if context is not in the tree.
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
data(s1)
s1 <- seqdef(s1)
S1 <- pstree(s1, L=3)
## Retrieving from the node labelled 'a-a-a'
query(S1, "a-a-a")

## The node 'a-b-b-a' is not presetnin the tree, and the next symbol
## probability is retrieved from the node labelled 'b-b-a' (the longest
## suffix
query(S1, "a-b-b-a")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
