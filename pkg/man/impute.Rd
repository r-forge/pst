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
\S4method{impute}{PSTf,stslist}(object, data, method="pmax")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A PST, that is an object of class \code{PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{data}{
	a sequence object of class 'stslist' as defined with the \code{seqdef} function of the \code{\link{TraMineR}} library. The sequence object contains the sequences to impute. See details.
}
  \item{method}{
	character. If \code{method='pmax'} the state having the highest probability according to the probability distribution associated with the context preceding the missing status is imputed. If \code{method='prob'} the imputation is done randomly by using this probability distribution.

}
}
\details{
A PST can be used to impute missing states in sequences built on the same alphabet. When a missing state occurs in a sequence the procedure searches in the PST for the context preceding the missing state and impute the state according to the conditional distribution associated with the context. The imputation can be done either randomly (method="prob") or with the state having the highest probability. However, more sophisticated modelling taking account of the non response mechanism could be required for imputing missing states.
}
\value{
	A sequence object (of class \code{stslist}) containing original sequences in \code{data} with missing states imputed.  
}

\author{
 Alexis Gabadinho
}
\examples{
## Preparing a sequence object with the SRH data set
data(SRH)
state.list <- levels(SRH$p99c01)
## sequential color palette
mycol5 <- rev(brewer.pal(5, "RdYlGn"))
SRH.seq <- seqdef(SRH, 5:15, alphabet=state.list, states=c("G1", "G2", "M", "B2", "B1"), 
	labels=state.list, weights=SRH$wp09lp1s, right=NA, cpal=mycol5)
names(SRH.seq) <- 1999:2009

## Learning the model
SRH.pst.L10 <- pstree(SRH.seq, nmin=2, ymin=0.001)

## Pruning
C99 <- qchisq(0.99,5-1)/2
SRH.pst.L10.C99 <- prune(SRH.pst.L10, gain="G2", C=C99)

## Imputing missing values in the SRH sequences
SRH.iseq <- impute(SRH.pst.L10, SRH.seq, method="prob")

## Non imputed and imputed sequence
SRH.seq[3,]
SRH.iseq[3,]
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ models }
\keyword{ datagen }
