\name{cplot}
\alias{cplot}
\alias{cplot,PSTf-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Plot single nodes
}
\description{
Plot the next symbol probability distribution associated with a particular node in a PST
}
\usage{
	\S4method{cplot}{PSTf}(object, context, state, all=FALSE, x.by=1, y.by=0.2, ...)
}
%% ============================================
\arguments{
  \item{object}{ a PST as created by the \code{\link{pstree}} function. }
  \item{context}{ the label of the node to plot, provided as a string where states are separated by '-', see examples.}
  \item{state}{logical. Under development.}
  \item{all}{logical.}
  \item{x.by}{numeric. Interval for the ticks on the x axis (segments).}
  \item{y.by}{numeric. Interval for the ticks on the y axis (probability).}
  \item{\dots}{ arguments to be passed to the plot function or other graphical parameters. }
}
%%  ============================================
\details{
	The \code{cplot()} function displays a single node labelled with \code{context} of the tree where one or mode barplots (if \code{object} is a segmented PST) represent the probability distribution(s) stored in the node.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
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

cplot(S1, "a-b")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }
