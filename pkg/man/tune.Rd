\name{tune}
\docType{methods}
\alias{tune}
\alias{tune,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	AIC/AICc based model selection 
}
\description{
	A PST is pruned with a series of pruning parameter and the pruned PST having the lowest AIC or AICc value is selected.
}
\usage{
\S4method{tune}{PSTf}(object, C, criterion = "AIC", output = "PST")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class 'PSTf' as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{C}{ 
	numeric. A vector of pruning parameters. See \code{\link{prune}} for details.
}
  \item{criterion}{
	The criterion used to select the model, either AIC or AICc. AICc should generally be used as with PST models the ratio between the number of observations and the number of estimated parameters is usually low. \cite{Burnham et al, 2004} suggests to use AICc instead of AIC when the ratio is lower than 40.
}
  \item{output}{
	If \code{output='PST'} the PST (an object of class 'PSTf') having the lowest AIC or AICc value. If \code{output='stats'}, a table with the statistics for each model obtained by pruning \code{object} with each of the parameters in \code{K}. 
}
}
\details{
The \code{tune} function selects among a series of PST pruned with different values of the \eqn{C} cutoff the model having the lowest \eqn{AIC} or \eqn{AIC_{c}} value. The function can return either the selected PST or a data frame containing the statistics for each model.
}
\value{
	If \code{output="PST"} a PST that is an object of class \code{PSTf}. If \code{output="stats"} a matrix with the results of the tuning procedure. The selected model is tagged with \code{*}, while models with \eqn{AIC < min(AIC)+2} or \eqn{AIC_{c} < min(AIC_{c})+2} are tagged with \code{**}, and models with \eqn{AIC < min(AIC)+10} or \eqn{AIC_{c} < min(AIC_{c})+10} are tagged with \code{***}.
}
\references{
Burnham, K. P. & Anderson, D. R. (2004) Multimodel Inference \emph{Sociological Methods & Research}, 33, pp. 261-304
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
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
