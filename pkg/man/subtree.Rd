\name{subtree}
\docType{methods}
\alias{subtree}
\alias{subtree,PSTf-method}
\title{ Extract a subtree from a segmented PST }
\description{
 Extract a subtree from a segmented PST
}

\usage{
\S4method{subtree}{PSTf}(object, group=NULL, position=NULL)
}

\arguments{
  \item{object}{
	A segmented probabilistic suffix tree, i.e an object of class \code{"\linkS4class{PSTf}"}) as returned by the \code{\link{pstree}}, \code{\link{prune}} or \code{\link{tune}} function.
}
\item{group}{ 
integer. Segment of the PST
}
\item{position}{ 
Not implemented yet. 
}
}

\examples{
## Loading the 'SRH' data frame and 'SRH.seq' sequence object
data(SRH)

## a factor with age group
gage10 <- cut(1999-SRH$birthy, c(20, 40, 60, 80), right=FALSE,
	labels=c("20-39", "40-59", "60-79"))
agemiss <- which(is.na(gage10))

## Removing cases where age is missing
SRH.anm.seq <- SRH.seq[-agemiss,]
gage10 <- gage10[-agemiss]

## segmented PST (including missing value)
SRH.psts <- pstree(SRH.anm.seq, group=gage10, with.missing=TRUE, nmin=2, ymin=0.001)
C99 <- qchisq(0.99,6-1)/2
SRH.psts.C99 <- prune(SRH.psts, gain="G2", C=C99)

## extracting the model for age group 1
g1.pst <- subtree(SRH.psts.C99, group=1)
summary(g1.pst)
}

\keyword{methods}
\keyword{models}
