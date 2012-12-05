\name{pmine}
\docType{methods}
\alias{pmine}
%% \alias{pmine-methods}
\alias{pmine,PSTf,stslist-method}
\title{ PST based pattern mining }
\description{
Mine for (sub)sequences in a state sequence object satisfying user defined criteria
}

\usage{
\S4method{pmine}{PSTf,stslist}(object, data, l, pmin, pmax, lag, state, average=FALSE, output="sequences")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A fitted PST, that is an object of class PSTf as returned by the \code{\link{pstree}} or \code{\link{prune}} method.

}

  \item{data}{
	a sequence object of class 'stslist' as defined with the \code{seqdef} function of the \code{\link{TraMineR}} library.
}
  \item{l}{
	length of the subsequence to search for.
}
  \item{pmin}{
	numeric. Minimal probability for selecting the (sub)sequence.
}
  \item{pmax}{
	numeric. Maximal probability for selecting the (sub)sequence.
}
  \item{lag}{
	integer. The \code{lag} first states in the sequence are omitted. 
}
  \item{state}{
}
  \item{average}{
	logical. If \code{TRUE}, the \code{pmin} or \code{pmax} probability is supposed to be the average state probability in the (sub)sequences. If \code{FALSE} (sub)sequences having every state probability less than \code{pmax} or greater than \code{pmin} are selected.
}
  \item{output}{
	character. If \code{output='sequences'} the whole sequence(s) where the user defined criteria is satisfied are returned. If \code{output='patterns'} only the (sub)sequences satisfying the user defined criteria are returned.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
	A state sequence object, that is an object of class \code{stslist} 
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
}
\keyword{ ~~ other possible keyword(s) ~~ }
