\name{predict}
\docType{methods}
\alias{predict,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Compute the probability of categorical sequences using a Probabilistic Suffix Tree
}
\description{
Compute the probability (likelihood) of categorical sequences using a Probabilistic Suffix Tree
}
\usage{
predict(object, data, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class PSTf as created by the pstree or prune functions.
}
  \item{data}{
	a sequence object, that is an object of class stslist as created by the \code{\link{seqdef}} TraMineR function. The sequence object contains the sequences to predict.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
A PST can be used to compute the probability of any sequence built on the same alphabet. For example 
the probability of the sequence a-b-a-a-b is the product of each state probability

\deqn{
P(abaab) = P(a) \times P(b|a) \times P(a|ab) \times P(a|aba) \times P(b|abaa)
}

}
\value{
	Either a vector of sequence probabilities (decomp=FALSE) or a matrix (if decomp=FALSE) containing for each sequence (row) the probability of each state in columns.   

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
predict(S1, s1, decomp=TRUE)
predict(S1, s1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
