\name{cprob}
\alias{cprob}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Empirical conditional probability distributions
}
\description{
	Computes the empirical conditional probability distributions of order L from a set of sequences
}
\usage{
cprob(object, L, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	a sequence object, that is an object of class stslist as created by TraMineR \link{seqdef()} function.
}
  \item{L}{
	context length.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
	Returns a matrix whose rows correspond to each contexts of length L found at least nmin times in the sequence data and followed by a valid symbol. Columns are either the counts of symbols found after context or the probability distribution. 
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
	cprob(s1, L=3)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
