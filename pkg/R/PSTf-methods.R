## TAKEN FROM dengrogram method
## The ``generic'' method for "[["  (identical to e.g., "[[.POSIXct"):
## --> subbranches are pstrees as well!

setMethod("summary", "PSTf", function(object, max.level) {

	if (missing(max.level)) { max.level <- length(object)-1 }

	stats <- PSTf.stats(object, max.level=max.level)
	res <- new("PST.summary",
		alphabet=object@alphabet,
		labels=object@labels,
		cpal=object@cpal,
		ns=as.integer(stats$ns),
		depth=as.integer(stats$depth),
		nodes=as.integer(stats$nodes),	
		leaves=as.integer(stats$leaves),
		freepar=as.integer((stats$nodes+stats$leaves)*(length(object@alphabet)-1))
	)

	res
}
)

## Stats and summary
PSTf.stats <- function(PST, max.level) {
	stats <- list(ns=as.integer(0), leaves=as.integer(0), nodes=as.integer(0), depth=as.integer(0))

	stats$ns <- PST[[1]][["e"]]@n
	for (i in (max.level+1):1) {
		pruned.nodes <- pruned.nodes(PST[[i]])
		if (any(pruned.nodes)) {
			PST[[i]] <- PST[[i]][!pruned.nodes]
			new.leaves <- !names(PST[[i-1]]) %in% lapply(PST[[i]], node.parent) 
			PST[[i-1]][new.leaves] <- lapply(PST[[i-1]][new.leaves], node.leaf)
		}

		if (length(PST[[i]])>0) {
			if (i==(max.level+1)) {
				PST[[i]] <- lapply(PST[[i]], node.leaf)
			}

			if (stats$depth==0) { stats$depth <- i-1 }
			stats$nodes <- stats$nodes+sum(nodes.count(PST[[i]]))
			stats$leaves <- stats$leaves+sum(leaves.count(PST[[i]]))
		}
	}

	return(stats)
}


## Plot method
setMethod("plot", "PSTf", function (x, y=missing, max.level=NULL,
	nodePar = list(), edgePar = list(), nodelab = c("perpendicular", "textlike", "none"), 
	dLeaf = NULL, axis=FALSE, xlab = "", ylab = if (axis) { "L" } else {""}, 
	xaxt = "n", yaxt = "n", horiz = FALSE, frame.plot = FALSE, 
	xlim=NULL, ylim=NULL, ...) {

	x <- as.pstree(x, L=max.level)

	plot(x, y=missing, max.level=max.level,
	nodePar = nodePar, edgePar = edgePar, nodelab = nodelab,
	dLeaf = dLeaf, axis=axis, xlab = xlab, ylab = ylab, 
	xaxt = xaxt, yaxt = yaxt, horiz = horiz, frame.plot = frame.plot, 
	xlim=xlim, ylim=ylim, ...)

}
)

setMethod("print", "PSTf", function (x, max.level = NULL, digits.d = 1, give.attr = FALSE, 
    wid = getOption("width"), nest.lev = 0, indent.str = "", 
    stem = "--"
	## , ...
	) {

	x <- as.pstree(x, L=max.level)

	print(x, max.level = max.level, digits.d = digits.d, give.attr = give.attr, 
    		wid = wid, nest.lev = nest.lev, indent.str = indent.str, 
    		stem = stem)
}
)
	


