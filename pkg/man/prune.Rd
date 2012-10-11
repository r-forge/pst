\name{prune}
\docType{methods}
% \alias{prune-methods}
\alias{prune}
\alias{prune,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Prune a PST
}
\description{
Prune an existing PST, using one or several pruning parameters.
}
\usage{
\S4method{prune}{PSTf}(object, nmin, L, gain, C, keep, drop, state, delete = TRUE)
}

\arguments{
  \item{object}{
	A PST, that is an object of class \code{PSTf} as created with the \code{\link{pstree}} function.
}
  \item{nmin}{
	integer. All strings having counts less than nmin are removed.
}
  \item{L}{
	integer. If specified the the tree is cut at depth L., that is all nodes with depth > L are removed.
}
  \item{gain}{
	character. Function for measuring information gain. If gain="G1", the gain function is the one described in Ron et al. (1996) and later in Bejerano et al. (2001). A node is pruned if for any symbol 
\eqn{\sigma \in A}
\deqn{
\frac{\tilde{P}(\sigma |s)}{\tilde{P}(\sigma | suf(s))} \leq r
}
or
\deqn{
\frac{\tilde{P}(\sigma |s)}{\tilde{P}(\sigma | suf(s))} \geq \frac{1}{r}
}
If gain="G2" the gain function is the one described in M\"{a}chler et B\"{u}hlmann (2004). The node labelled \eqn{wu} is pruned if
\deqn{
\Delta_{wu}=\sum_{x \in A} \hat{P}(x|wu)\log \left( \frac{\hat{P}(x|wu)}{\hat{P}(x|u)} \right) N(wu) < K
}

where the C \eqn{K} is specified on the scale of \eqn{\chi^{2}}-quantiles (percentages) 

\deqn{
c=c(\alpha)=\frac{1}{2}qchisq(1-\alpha,v), v=card(\chi)-1
}
}
 \item{C}{
	numeric. Cutoff value to use with the gain function
}
  \item{keep}{
	character. A vector of character strings containing the names of the nodes to keep in the tree. All nodes that are not a suffix of contexts in keep are removed from the tree.
}

  \item{drop}{
	character. A vector of character strings containing the names of the nodes to remove from the tree. All nodes that are a suffix of contexts in drop are removed from the tree as weel.
}
  \item{state}{
%%     ~~Describe \code{topdown} here~~
}
  \item{delete}{
	Logical. If FALSE, the pruned nodes are not removed from the tree but tagged as pruned=FALSE, so that when plotting the pruned tree these nodes wil appear surrounded with red (can be set to another color) lines.
}
}

\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
	a PST, i.e. an object of class \code{PSTf}.
}
\references{
Ron, D.; Singer, Y. & Tishby, N. The power of amnesia: Learning probabilistic automata with variable memory length \emph{Machine Learning}, 1996, 25, 117-149

Bejerano, G. & Yona, G. Variations on probabilistic suffix trees: statistical modeling and prediction of protein families. \emph{Bioinformatics}, 2001, 17, 23-43

M\"{a}chler, M. & B\"{u}hlmann, P. Variable Length Markov Chains: Methodology, Computing, and Software \emph{Journal of Computational and Graphical Statistics}, 2004, 13, pp. 435-455
}
\author{
Alexis Gabadinho
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{tune}}
}
\examples{
data(s1)
s1.seq <- seqdef(s1)
S1 <- pstree(s1.seq, L=3, nmin=2, ymin=0.001)

## --
S1.p1 <- prune(S1, gain="G1", C=1.20, delete=FALSE)
summary(S1.p1)
plot(S1.p1)

## --
C95 <- qchisq(0.95,1)/2
S1.p2 <- prune(S1, gain="G2", C=C95, delete=FALSE)
plot(S1.p2)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
