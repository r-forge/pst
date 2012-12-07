\name{predict}
\docType{methods}
\alias{predict}
\alias{predict,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Compute the probability of categorical sequences using a probabilistic suffix tree
}
\description{
Compute the probability (likelihood) of categorical sequences using a Probabilistic Suffix Tree
}
\usage{
\S4method{predict}{PSTf}(object, data, cdata, group, L=NULL, p1=NULL, output="prob", decomp=FALSE, base=2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	A probabilistic suffix tree, i.e., an object of class \code{"\linkS4class{PSTf}"} as returned by the \code{\link{pstree}}, \code{\link{prune}} or \code{\link{tune}} function.
}
  \item{data}{
	a sequence object, i.e., an object of class \code{'stslist'} as created by TraMineR \code{\link[TraMineR]{seqdef}} function, containing the sequences to predict.
}
  \item{cdata}{
	Not implemented yet.
}
  \item{group}{
	If \code{object} is a segmented PST, providing a vector of group membership so that each sequence probability will be predicted with the conditional probability distributions for the group it belongs to. If \code{object} is a segmented PST and \code{group} is not provided, each sequence will be predicted by each of the submodel, and the output will be a matrix with \code{nbgroup} columns, where \code{nbgroup} is the number of segments in the PST.
}
	\item{L}{
		integer. Maximal context length for sequence prediction. This is the same as pruning the PST by removing all nodes of depth<L before prediction.
}
	\item{p1}{
		vector. A probability distribution for the first position in the sequence that will be used instead of the root node of the tree.
	}
	\item{output}{
		character. One of \code{'prob'}, \code{'logloss'},  \code{'SIMn'} or \code{'SIMo'}. See details.
	}
	\item{decomp}{
		logical. If \code{TRUE} the predicted probability for each state in the sequence(s) is returned instead of the whole sequence probability.
	}
	\item{base}{
	integer. Base for the logarithm if a logarithm is used in the used prediction measure.
    }
}
\details{
A probabilistic suffix tree (PST) can be used to compute the probability of any sequence built on the same alphabet as the learning sample to which it was fitted. For example 
the probability of the sequence a-b-a-a-b is the product of each state probability

\deqn{
P(abaab) = P(a) \times P(b|a) \times P(a|ab) \times P(a|aba) \times P(b|abaa)
}

}
\value{
	Either a vector of sequence probabilities (decomp=FALSE) or a matrix (if decomp=FALSE) containing for each sequence (row) the probability of each state in columns.   

}

\author{
Alexis Gabadinho
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
\keyword{ models }

