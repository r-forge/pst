## =======================================
## Plot method for objects of class pstree 
## =======================================

setMethod("plot", "PSTr", function (x, y=missing, max.level=NULL,
	nodePar = list(), edgePar = list(), nodelab = c("perpendicular", "textlike", "none"), 
	dLeaf = NULL, axis=FALSE, xlab = "", ylab = if (axis) { "L" } else {""}, 
	xaxt = "n", yaxt = "n", horiz = FALSE, frame.plot = FALSE, 
	xlim, ylim, withlegend=TRUE, ltext=NULL, cex.legend=1, use.layout=withlegend!=FALSE, legend.prop=NA, ...) {

	Lmar <- if (axis) { 4 } else { 2 }

	if (horiz) { par(mar=c(Lmar,2,4,2)) } else { par(mar=c(2,Lmar,4,2)) }

	if (use.layout) {
		## Saving graphical parameters
		savepar <- par(no.readonly = TRUE)

		lout <- PST.setlayout(nplot=1, prows=NA, pcols=NA, withlegend, axes="all", legend.prop)
	  	layout(lout$laymat, heights=lout$heights, widths=lout$widths)

		legpos <- lout$legpos
	} else {
		legpos <- NULL
	}

	nodelab <- match.arg(nodelab)

	## ORDER AT WHICH THE TREE STARTS
	k <- x@order
	stats <- summary(x, max.level=max.level)
	
	if (missing(max.level) | is.null(max.level)) { max.level <- stats@depth }
	if (!"cpal" %in% names(nodePar)) { nodePar[["cpal"]] <- attr(x, "cpal") }

	hgt <- max.level
	mem.x <- stats@leaves
	
	node.size <- Xtract("node.size", nodePar, default = 0.6)
	gratio <- Xtract("gratio", nodePar, default=(((hgt-k)+1)/mem.x))

	yTop <- k
	x1 <- 0.5
	x2 <- mem.x + 0.5
	xl. <- if (horiz) { c(x1 -((node.size/2)*gratio), x2 + ((node.size/2)*gratio)) } 
		else { c(x1 -(node.size/2), x2 + (node.size/2)) }
	yl. <- if (horiz) { c(k-(node.size/2), hgt+(node.size/2)) } else { c(k-((node.size/2)*gratio), hgt+((node.size/2)*gratio)) }
	yl. <- rev(yl.)

	## If horiz=TRUE, x and y are inverted
	if (horiz) {
		tmp <- xl.
		xl. <- yl.
		yl. <- rev(tmp)
		tmp <- xaxt
		xaxt <- yaxt
		yaxt <- tmp
		tmp <- xlab
		xlab <- ylab
		ylab <- tmp
	}
	if (missing(xlim) || is.null(xlim)) { xlim <- xl. }
	if (missing(ylim) || is.null(ylim)) { ylim <- yl. }

	plot(0, xlim = xlim, ylim = ylim, type = "n", xlab = xlab,
		ylab = ylab, frame.plot = frame.plot, xaxt=xaxt, yaxt=yaxt, ...)

	if (axis) {
		if (horiz) {
			axis(1, at=0:hgt)
		} else {
			axis(2, at=0:hgt)
		}		
	}

	if (is.null(dLeaf)) 
		dLeaf <- 0.75 * (if (horiz) 
			{strwidth("w")}
        else {strheight("x")})

	plotNode(x1, x2, x, nodelab = nodelab, 
		dLeaf = dLeaf, nPar = nodePar, ePar = edgePar, 
		horiz = horiz, gratio=gratio, max.level=max.level)


	## Plotting the legend
	if (!is.null(legpos)) {
		## Extracting some sequence characteristics
		if (is.null(ltext)) ltext <- x@labels

		cpal <- Xtract("cpal", nodePar, default = x@cpal)

		PST.legend(legpos, ltext, cpal, cex=cex.legend)
	}

	## Restoring graphical parameters
	if (use.layout) {par(savepar)}
}
)


##
.midDend <- function (x) {
	if (is.null(mp <- attr(x, "midpoint"))) 0.5 else mp
}


##
plotNodeLimit <- function (x1, x2, subtree, max.level) {
	inner <- !all(subtree@leaf) && x1 != x2 && !subtree@order==max.level

	if (inner) {
	        ## K <- length(subtree)
		K <- which.child(subtree)
        	mTop <- summary(subtree, max.level=max.level)@leaves
        	limit <- integer(length(K))
		names(limit) <- K
        	xx1 <- x1

        	for (k in K) {
            		m <- summary(subtree[[k]], max.level=max.level)@leaves
            		xx1 <- xx1 + ((x2 - x1) * m/mTop)
			limit[k] <- xx1
		}
		limit <- c(x1, limit)
	} else {
		limit <- c(x1, x2)
	}
	## mid <- attr(subtree, "midpoint")
	mid <- length(subtree)/2

    x <- mean(c(x1, x2))
    list(x = x, limit = limit)
}


## 
Xtract <- function(nam, L, default, indx) {
	rep(if (nam %in% names(L)) L[[nam]] else default, length.out = indx)[indx]
}

##
asTxt <- function(x) {
	if (is.character(x) || is.expression(x) || is.null(x)) {x}
    		else {as.character(x)}
}





