\name{tune}
\alias{tune}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	AIC/AICc based model selection 
}
\description{
	A PST is pruned with a series of pruning parameter and the pruned PST having the lowest AIC or AICc value
}
\usage{
tune(object, K, criterion = "AIC", output = "PST")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class 'PSTf' 
}
  \item{K}{
	a vector of pruning parameters. See \code{\link{prune}} for details.
}
  \item{criterion}{
	The criterion used to select the model, either AIC or AICc. AICc should generally be used as with PST models the ratio between the number of observations and the number of estimated parameters is usually low. \cite{Burnham et al, 2004} suggests to use AICc instead of AIC when the ratio is lower than 40.
}
  \item{output}{
	If \code{output='PST'} the PST (an object of class 'PSTf') having the lowest AIC or AICc value. If \code{output='stats'}, a table with the statistics for each model obtained by pruning \code{object} with each of the parameters in \code{K}. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
Burnham, K. P. & Anderson, D. R. (2004) Multimodel Inference \emph{Sociological Methods & Research}, 33, pp. 261-304
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

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
