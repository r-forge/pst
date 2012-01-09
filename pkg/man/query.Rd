\name{query}
\alias{query}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Retrieve counts or next symbol probability distribution from a node in a Probabilistic Suffix Tree
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
query(object, string, state, output = "prob", exact = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A fitted PST, that is an object of class PST.list as returned by the pstree or prune function.

}
  \item{string}{
	Character. The string labelling the node to retrieve. States must be separated by '-' as for example in 'a-a-b'. If the node labelled with this string does not exist in the tree, the node labelled with the longest suffix is searched for, and so on until an existing node is  found.
}
  \item{state}{
%%     ~~Describe \code{state} here~~
}
  \item{output}{
%%     ~~Describe \code{output} here~~
}
  \item{exact}{
%%     ~~Describe \code{exact} here~~
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
