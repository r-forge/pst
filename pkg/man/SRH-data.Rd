\name{SRH}
\alias{SRH}
\docType{data}
\title{
Sequence data on self rated health from the Swiss household panel
}
\description{
Sequence data on self rated health from the Swiss household panel
}
\usage{data(SRH)}
\format{
  A data frame with 2612 observations on the following 15 variables.
  \describe{
    \item{\code{idpers}}{a numeric vector}
    \item{\code{sex}}{a factor with levels \code{man} \code{woman}}
    \item{\code{birthy}}{a numeric vector}
    \item{\code{wp09lp1s}}{a numeric vector}
    \item{\code{p99c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p00c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p01c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p02c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p03c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p04c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p05c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p06c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p07c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p08c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
    \item{\code{p09c01}}{a factor with levels \code{other error} \code{filter error} \code{inapplicable} \code{no answer} \code{does not know} \code{very well} \code{well} \code{so, so (average)} \code{not very well} \code{not well at all}}
  }
}
\details{
A sequence object can be built by using the seqdef function of the TraMineR package.
}
\source{
Swiss Household Panel \url{www.swisspanel.ch}
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(SRH)
state.list <- levels(SRH$p99c01)[10:6]
SRH.seq <- seqdef(SRH, 5:15, alphabet=state.list, states=c("B2", "B1", "M", "G1", "G2"), weights=SRH$wp09lp1s)
}
\keyword{datasets}
