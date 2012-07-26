## ==============
## Plotting nodes
## ==============
plotTree <- function(x1, x2, subtree, nPar, ePar, horiz = FALSE, gratio, max.level, group, cex, nc, cpal) {

	scale <- seq(0, 1, 0.2)

	## Retrieving requested attributes
	prob <- subtree@prob
	path <- subtree@path
	state <- seqdecomp(path)[1]
	alphabet <- colnames(prob)
	cpal <- Xtract("cpal", nPar, default = NULL)
	depth <- subtree@order
	pruned <- subtree@pruned
	if (is.null(pruned)) {pruned <- FALSE}

	children <- which.child(subtree)

	if (getOption("verbose")) { message(" [i] node:", path) }

	inner <- !length(children)==0 && x1 != x2 && !depth==max.level
	yTop <- subtree@order

	bx <- plotNodeLimit(x1, x2, subtree, max.level)
	xTop <- bx$x

	if (getOption("verbose")) {
        	cat(if (inner) { "inner node" } else { "leaf" } , ":" )
        	if (!is.null(nPar)) {
			cat(" with node pars\n")
			str(nPar)
		}
        	cat(if (inner) 
        	    paste(" height", formatC(yTop), "; "), "(x1,x2)= (", 
        	    formatC(x1, width = 4), ",", formatC(x2, width = 4), 
        		    ")", "--> xTop=", formatC(xTop, width = 8), "\n", 
        		    sep = "")
	}

	## If there are children, plotting edges and child nodes
	if (inner) {
		plotEdge(x1, x2, subtree, ePar, horiz, gratio, max.level, group, cex, nc, cpal)


		## Plotting edges and child nodes
		## Selecting non null child nodes only
		for (k in children) {
			child <- subtree[[k]]
			idx <- which(k==children)

			## Plotting the subtree
			plotTree(bx$limit[idx], bx$limit[idx+1], subtree = child, nPar=nPar, ePar=ePar, 
                		horiz=horiz, gratio=gratio, max.level=max.level, group=group, cex=cex, nc=nc)
		}
	} 

	plotNode(x1, x2, subtree, nPar, horiz, gratio, max.level, group, cex, nc, cpal)

}

