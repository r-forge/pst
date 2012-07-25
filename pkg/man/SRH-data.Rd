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
A sequence object can be built by using the seqdef function of the TraMineR package. Respondant's self rated health is collected at each yearly wave of the SHP with the following question: \emph{How do you feel right now?}. Possible answers are: very well; well; so, so (average), not very well and not well at all. The sequences are made of an individual's responses over 11 yearly waves of the SHP, starting with wave 1 in 1999. Variable p99c01 contains the self rated health at wave 1, p00c01 contains the self rated health at wave 2, etc... Note that sequences may contain missing values due to wave or item non response. 
}
\source{
Swiss Household Panel \url{www.swisspanel.ch}
}
\references{
%%  ~~ possibly secondary sources and usages ~~
}
\examples{
data(SRH)
state.list <- levels(SRH$p99c01)
SRH.seq <- seqdef(SRH, 5:15, alphabet=state.list, states=c("G1", "G2", "M", "B2", "B1"), weights=SRH$wp09lp1s)
}
\keyword{datasets}
