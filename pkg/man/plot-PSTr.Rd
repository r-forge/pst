\name{plot-PSTr}
\alias{plot,PSTf,ANY-method}
\alias{plot,PSTr,ANY-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
	Plot a PST
}
\description{
	Plot a PST either under a flat representation or nested representation
}
\usage{
	\S4method{plot}{PSTr,ANY}(x, y=missing, max.level=NULL,
		nodePar = list(), edgePar = list(), dLeaf = NULL, 
		axis=FALSE, xlab = "", ylab = if (axis) { "L" } else {""}, 
		xaxt = "n", yaxt = "n", horiz = FALSE, frame.plot = FALSE, 
		xlim, ylim, withlegend=TRUE, ltext=NULL, cex.legend=1, use.layout=withlegend!=FALSE, legend.prop=NA, ...)
}

\arguments{
  \item{x}{
	A PST, that is an object of class \code{\PSTf} as returned by the \code{\link{pstree}} or \code{\link{prune}} method.
}
  \item{max.level}{ 
	integer. The maximal depth for the display of the tree.
}
  \item{nodePar}{ 
	list. A list of parameters for tuning the node representation.
}
  \item{edgePar}{ 
	list. A list of parameters for tuning the edges representation.
}
  \item{axis}{ 
	logical. If TRUE the axes are displayed on the plot.
}
  \item{xlab}{ 
	character. Label for the x axis.
}
  \item{ylab}{ 
	character. Label for the y axis representing the tree depth.
}
  \item{horiz}{ 
	logical. If FALSE, the tree is represented vertically. The root node at depth L=0 is plotted on the top, and the nodes of maximal depth are plotted on the bottom of the plot. If TRUE, the tree is represented horizontally. The root node at depth L=0 is plotted on the right, and the nodes of maximal depth are plotted on the left of the plot.
}
  \item{withlegend}{ 
	defines if and where the legend of the state colors is plotted. The default value \code{TRUE} sets the position of the legend automatically. Other possible value is \code{"right"}.
}
  \item{ltext}{
	optional description of the states to appear in the legend. Must be a vector of character strings with number of elements equal to the size of the alphabet. If unspecified, the \code{label} attribute of the \code{seqdata} sequence object is used (see \code{\link{seqdef}}).
}
	\item{cex.legend}{
	expansion factor for setting the size of the font for the labels in the legend. The default value is 1. Values lesser than 1 will reduce the size of the font, values greater than 1 will increase the size.
}
 \item{use.layout}{
	if \code{TRUE}, \code{\link[graphics]{layout}} is used to arrange plots when using the group option or plotting a legend. When layout is activated, the standard '\code{\link[graphics]{par}(mfrow=....)}' for arranging plots does not work. With \code{withlegend=FALSE} and \code{group=NULL}, layout is automatically deactivated and '\code{par(mfrow=....)}' can be used.
}
 \item{legend.prop}{
	sets the proportion of the graphic area used for plotting the legend when \code{use.layout=TRUE} and \code{withlegend=TRUE}. Default value is set according to the place (bottom or right of the graphic area) where the legend is plotted. Values from 0 to 1.
}
  \item{\dots}{
	arguments to be passed to the plot function or graphical parameters
}
}

\details{
	The graphical representation of a PST uses a recursive function. Hence the main argument of the function is a tree represented as a nested list (an object of class \code{PSTr}.
}
\value{
	Either a vector of sequence probabilities (decomp=FALSE) or a matrix (if decomp=FALSE) containing for each sequence (row) the probability of each state in columns.   
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
	Alexis Gabadinho, code from ....
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
plot(S1)
plot(S1, horiz=TRUE)
plot(S1, nodePar=list(node.type="path", lab.type="prob", lab.pos=1, lab.offset=2, lab.cex=0.7), edgePar=list(type="triangle"), withlegend=FALSE)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ methods }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
