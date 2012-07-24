\name{s1}
\alias{s1}
\docType{data}
\title{
Example sequence data set
}
\description{
Example data set containing one single sequence
}
\usage{data(s1)}
\format{
  The format is:
 chr "s1"
}
\details{
A sequence object can be created with the dedicated \code{TraMineR} \code{\link{seqdef}} function. State sequence objects are the main argument for the \code{\link{pstree}} method that creates Probabilistic Suffix Trees. See example below. 
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
## Loading the data
data(s1)

## Creating a state sequence object
s1.seq <- seqdef(s1)

## Building and plotting a PST
S1 <- pstree(s1.seq, L = 3)
plot(S1)
}
\keyword{datasets}
