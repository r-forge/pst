\name{pqplot}
\alias{pqplot-methods}
\alias{pqplot,PSTf,stslist-method}
\title{ 
	Prediction quality plot
}
\description{
	Plot the prediction of each state in a sequence
}

\usage{
	pqplot(object, data, cdata, L, stcol=TRUE, plotseq=FALSE, ptype="barplot", cex.plot=1, space=0, grid=TRUE, seqprob=TRUE,
	measure="prob", pqmax, ...)
}

\arguments{
	\item{object}{
		a fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} function.
}
	\item{data} { 
		a state sequence object created with the \code{\link{seqdef}} TraMineR function.
}
	\item{cdata} {
		Under development.
}
	\item{plotseq} { 
		logical. If TRUE, the sequence is displayed separately, and the prediction plot is plotted above.
}
}

\details{
	The \code{pqplot()} function displays either the predicted probabilities or the log-loss for each position of a single sequence as a series of barplots.
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
