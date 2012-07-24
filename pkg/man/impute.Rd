\name{impute}
\docType{methods}
\alias{impute}
\alias{impute,PSTf,stslist-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Impute missing states in sequences using a Probabilistic Suffix Tree
}
\description{
	Missing states in a sequecne object are imputed by using the Probabilistic Suffix Tree. The context preceding the missing status is used to predict it.
}
\usage{
\S4method{impute}{PSTf, stslist}(object, data, method="pmax")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class \code{\PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{data}{
	a sequence object of class 'stslist' as defined with the \code{seqdef} function of the \code{\link{TraMineR}} library. The sequence object contains the sequences to impute. See details.
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}
\details{
A PST can be used to impute missing states in sequences built on the same alphabet. When a missing state occurs in a sequence the procedure searches in the PST for the context preceding the missing state and impute the state according to the conditional distribution associated with the context. The imputation can be done either randomly (method="prob") or with the state having the highest probability. However, more sophisticated modelling taking account of the non response mechanism could be required for imputing missing states.
}
\value{
	A sequence object (of class \code{stslist}) containing original sequences contained in \code{data} with missing states imputed.  
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
data(s1)
s1 <- seqdef(s1)
S1 <- pstree(s1, L=3)
predict(S1, s1, decomp=TRUE)
predict(S1, s1)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
