\name{pqplot}
\alias{pqplot}
\alias{pqplot,PSTf,stslist-method}
\title{ 
	Prediction quality plot
}
\description{
	Plot the prediction of each state in a sequence
}

\usage{
\S4method{pqplot}{PSTf,stslist}(object, data, cdata, L, stcol, plotseq=FALSE, ptype="barplot", cex.plot=1, space=0, grid=TRUE, seqprob=TRUE,
	measure="prob", pqmax, seqscale, ...)
}

\arguments{
	\item{object}{
		a fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} function.
}
	\item{data}{ 
		a state sequence object created with the \code{\link{seqdef}} TraMineR function.
}
	\item{cdata}{
		Under development.
}
	\item{L}{
		integer. Maximal context length for sequence prediction. This is the same as pruning the PST by removing all nodes of depth<L before prediction. 
}
	\item{stcol}{
		color to use to represent the states in the plot of the prediction qualities. 
	}

	\item{plotseq}{ 
		logical. If TRUE, the sequence is displayed separately, and the prediction plot is plotted above.
}
	\item{ptype}{
}
	\item{cex.plot}{
}
	\item{space}{
}
	\item{grid}{
	logical
}	
	\item{seqprob}{
}
	\item{measure}{
	character. Measure used for prediction quality. Either \code{'prob'} or \code{'logloss'}.$
}
	\item{pqmax}{
		max coordinate for the prediction quality plot, i.e. the max of the y axis.
	}
	\item{seqscale}{
		numeric. If \code{plotseq=TRUE}, width of the bar representing the sequence as a proportion of the y axis range.
	}
	\item{\dots}{
		optional graphical parameters to be passed to the plot function.
	}
}

\details{
	The \code{pqplot()} function displays either the predicted probabilities or the log-loss for each position of a single sequence as a series of barplots.
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
pqplot(S1, z, measure="logloss", plotseq=TRUE)
}

\keyword{methods}
\keyword{ ~~ other possible keyword(s) ~~ }
