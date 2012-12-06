\name{PSTf-class}
\Rdversion{1.1}
\docType{class}
\alias{PSTf-class}
\alias{cmine,PSTf-method}
\alias{cplot,PSTf-method}
\alias{generate,PSTf-method}
\alias{impute,PSTf,stslist-method}
\alias{logLik,PSTf-method}
\alias{nobs,PSTf-method}
\alias{nodenames,PSTf-method}
\alias{pdist,PSTf,PSTf-method}
\alias{plot,PSTf,ANY-method}
\alias{pmine,PSTf,stslist-method}
\alias{ppplot,PSTf-method}
\alias{pqplot,PSTf,stslist-method}
\alias{predict,PSTf-method}
\alias{print,PSTf-method}
% \alias{prune,PSTf-method}
\alias{query,PSTf-method}
\alias{subtree,PSTf-method}
\alias{summary,PSTf-method}
% \alias{tune,PSTf-method}

\title{Class \code{"PSTf"}}
\description{
This is the flat representation of a probabilistic suffix tree (PST) storing the parameters of a variable length Markov chain model. The flat representation is a list where each element corresponds to a given depth. It is the prefered representation and is used by all functions for model fitting and sequence analysis with PST. The nested representation \code{"\linkS4class{PSTr}"} is used only for printing and plotting PSTs. 
}
\section{Objects from the Class}{
Objects of class \code{"PSTf"} are returned by the \code{\link{pstree}}, \code{\link{prune}} and \code{\link{tune}} functions.
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"list"} ~~ }
    \item{\code{data}:}{Object of class \code{"stslist"}. The learning sample to which the PST is fitted, i.e., a sequence object created with the \code{\link[=TraMineR]{seqdef}} function.}
    \item{\code{cdata}:}{Object of class \code{"stslist"}  }
    \item{\code{alphabet}:}{Object of class \code{"character"} Alphabet on which the sequences, and the PST are built.}
    \item{\code{labels}:}{Object of class \code{"character"} containing the long state labels.}
    \item{\code{cpal}:}{Object of class \code{"character"}, containing the color palette used to represent each state of the alphabet.}
    \item{\code{segmented}:}{Object of class \code{"logical"} indicating whether the tree is segmented. See \code{\link{pstree}}.}
    \item{\code{group}:}{Object of class \code{"factor"} containing the group membership for each sequence in \code{data}.}
    \item{\code{call}:}{Object of class \code{"call"} ~~ }
    \item{\code{logLik}:}{Object of class \code{"numeric"}, containing the log-likelihood of the VLMC model represented by the PST.}
  }
}
\section{Extends}{
Class \code{"\linkS4class{list}"}, from data part.
Class \code{"\linkS4class{vector}"}, by class "list", distance 2.
}
\section{Methods}{
  \describe{
    \item{cmine}{\code{signature(object = "PSTf")}: ... }
    \item{cplot}{\code{signature(object = "PSTf")}: ... }
    \item{generate}{\code{signature(object = "PSTf")}: ... }
    \item{impute}{\code{signature(object = "PSTf", data = "stslist")}: ... }
    \item{logLik}{\code{signature(object = "PSTf")}: ... }
    \item{nobs}{\code{signature(object = "PSTf")}: ... }
    \item{nodenames}{\code{signature(object = "PSTf")}: ... }
    \item{pdist}{\code{signature(x = "PSTf", y = "PSTf")}: ... }
    \item{plot}{\code{signature(x = "PSTf", y = "ANY")}: ... }
    \item{pmine}{\code{signature(object = "PSTf", data = "stslist")}: ... }
    \item{ppplot}{\code{signature(object = "PSTf")}: ... }
    \item{pqplot}{\code{signature(object = "PSTf", data = "stslist")}: predict the likelihood of sequences, see \code{\link{predict,PSTf-method}}.}
    \item{predict}{\code{signature(object = "PSTf")}: ... }
    \item{print}{\code{signature(x = "PSTf")}: print a PST, see \code{\link{print,PSTf-method}}.}
    \item{prune}{\code{signature(object = "PSTf")}: prune a PST, see \code{\link{prune,PSTf-method}}. }
    \item{query}{\code{signature(object = "PSTf")}: ... }
    \item{subtree}{\code{signature(object = "PSTf")}: ... }
    \item{summary}{\code{signature(object = "PSTf")}: ... }
    \item{tune}{\code{signature(object = "PSTf")}: AIC, AICc and BIC based model selection, see \code{\link{tune,PSTf-method}}. }
	 }
}
\references{
%%  ~~put references to the literature/web site here~~
}
\author{
Alexis Gabadinho
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\linkS4class{PSTr}}
}
\examples{
showClass("PSTf")
}
\keyword{classes}
