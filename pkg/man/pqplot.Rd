\name{pqplot-methods}
\alias{pqplot-methods}
\alias{pqplot,PSTf,stslist-method}
\title{ 
	Prediction quality plot
}
\description{
 ~~ Methods for function \code{pqplot} in package \pkg{PST} ~~
}

\usage{
	pqplot(object, data, cdata, L, stcol=TRUE, plotseq=FALSE, ptype="barplot", cex.plot=1, space=0, grid=TRUE, seqprob=TRUE,
	measure="prob", pqmax, ...)
}

\arguments{
	\item{object}{
		a fitted PST, that is an object of class PSTf as returned by the \link{pstree} or \link{prune} function.
	}
	\item{data} { 
		a state sequence object created with the ‘seqdef’ TraMineR function.
	}
	\item{cdata} {
		Under development.
	}
	\item{plotseq} { 
		logical. If TRUE, the sequence is displayed separately, and the prediction plot is plotted above.
	}
}

\details{
}

\value{
}

\references{
}

\author{
	Alexis Gabadinho
}

\seealso{
}

\examples{
data(s1)
s1 <- seqdef(s1)
S1 <- pstree(s1, L=3)

z <- seqdef("a-b-a-a-b")
pqplot(S1, z)
}

\keyword{methods}
\keyword{ ~~ other possible keyword(s) ~~ }
