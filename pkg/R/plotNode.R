## ==============
## Plotting nodes
## ==============
plotNode <- function(x1, x2, subtree, nPar, horiz = FALSE, gratio, max.level, group, cex, nc, cpal) {

	scale <- seq(0, 1, 0.2)

	## Retrieving requested attributes
	prob <- subtree@prob
	path <- subtree@path
	state <- seqdecomp(path)[1]
	alphabet <- colnames(prob)
	depth <- subtree@order
	pruned <- subtree@pruned
	if (is.null(pruned)) {pruned <- FALSE}
	node.id <- seqdecomp(path)[1]

	children <- which.child(subtree)

	if (getOption("verbose")) { message(" [i] node:", path) }

	inner <- !length(children)==0 && x1 != x2 && !depth==max.level

	bx <- plotNodeLimit(x1, x2, subtree, max.level)
	xTop <- bx$x
	yTop <- subtree@order
	xBot <- mean(x1, x2)

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

	## Setting node parameters
	i <- if (inner) 1 else 2

	node.type <- Xtract("node.type", nPar, default = c("prob", "prob"), i)
	node.size <- Xtract("node.size", nPar, default = 0.6)
	Node.lim <- ((node.size/2)*gratio)
	pfactor <- Xtract("pfactor", nPar, default = 0)
	node.size <- node.size*(1+pfactor)^(max.level-depth)
	ns.adj <- ((node.size/2)*gratio)


	pch <- Xtract("pch", nPar, default = 1L:2, i)
	pruned.col <- Xtract("pruned.col", nPar, default = "red")
	root.col <- Xtract("root.col", nPar, default = "grey")
	bg <- Xtract("bg", nPar, default = par("bg"), i)
	pform <- Xtract("pform", nPar, default = "SPS")
	fg.col <- Xtract("fg.col", nPar, default = "grey")

	lab.col <- Xtract("lab.col", nPar, default = par("col"), i)
	lab.cex <- Xtract("lab.cex", nPar, default = cex)
	lab.font <- Xtract("lab.font", nPar, default = par("font"), i)
	lab.type <- Xtract("lab.type", nPar, default = "n", i)
	lab.srt <- Xtract("lab.srt", nPar, default = 0, i)
	lab.pos <- Xtract("lab.pos", nPar, default = NULL, i)
	lab.offset <- Xtract("lab.offset", nPar, default = 0.5, i)
	c.size <- Xtract("c.size", nPar, default = (node.size/2)*0.66)

	t.col <- Xtract("t.col", nPar, default = "black", i)
	t.cex <- Xtract("t.cex", nPar, default = cex)
	t.font <- Xtract("t.font", nPar, default = par("font"), i)

	leave.csize <- Xtract("leave.csize", nPar, default=c.size*0.5)
	leave.lh <- Xtract("leave.lh", nPar, default=0.1)
	leave.lw <- Xtract("leave.lw", nPar, default=node.size)
    lty <- Xtract("lty", nPar, default = par("lty"), i)
    lwd <- Xtract("lwd", nPar, default = 3, i)

	## TEXT APPEARING in THE NODE
	nodeText <- NULL
		
	if (!is.null(lab.type)) {
		nodeText <- vector("character", length=length(lab.type))
		for (ltidx in 1:length(lab.type)) {
			if (lab.type[ltidx]=="path") {
				if (pform=="SPS" & depth>1) path <- suppressMessages(seqformat(path, from="STS", to="SPS", 
					SPS.out=list(xfix="", sdsep="/"), compressed=TRUE))
				nodeText[ltidx] <- path
			} else if (lab.type[ltidx]=="state") { nodeText[ltidx] <- state }
			else if (lab.type[ltidx]=="n") { nodeText[ltidx] <- round(sum(subtree@n, na.rm=TRUE),1) }
			else if (lab.type[ltidx]=="prob") { 
				nodeText[ltidx] <- paste("(",paste(round(prob,2),collapse=","),")",sep="") 				}
		}
		nodeText <- paste(nodeText, collapse="\n")
	}

	## 
	if (horiz) {
		X <- yTop
		Y <- xTop
		tmp <- yTop
		yTop <- xTop
		xTop <- tmp
		offset <- nchar(nodeText)/2
		inches <- node.size/2
	} else {
		Y <- yTop
		X <- xTop
		offset <- nchar(nodeText)/2
		inches <- FALSE
	}
	
	if (node.type=="prob") {
		## Converting into inches otherwise for unknown reason symbols is not working
		## iconv <- -strwidth("x")/strwidth("x", units="inches")/max.level
		## message("iconv:", iconv)

		ccol <- cpal[which(node.id==names(cpal))]

		if (horiz) {
			## Middle of the edge stemming from children
			yMid <- (xTop-((node.size/2)*gratio)+xTop-0.5)/2
			symbols(yMid, yTop, circles=c.size, bg=ccol, fg=fg.col, inches=nc/4, add=TRUE)
			text(yMid, yTop, asTxt(node.id), cex=t.cex, font=t.font, col=t.col)
		} else {
			yMid <- (yTop-((node.size/2)*gratio)+yTop-0.5)/2
			symbols(xTop, yMid, circles=c.size, bg=ccol , fg=fg.col, add=TRUE, inches=FALSE)
			text(xTop, yMid, asTxt(node.id), cex=t.cex, font=t.font, col=t.col)
		}

		Node.ytop <- if (horiz) {yTop-(node.size/2)} else { yTop-ns.adj }
		Node.ybottom <- if (horiz) {yTop+(node.size/2)} else { yTop+ns.adj }
		Node.xleft <- if (horiz) {xTop+((node.size/2)*gratio) } else {X-(node.size/2)}
		Node.xright <- if (horiz) {xTop-((node.size/2)*gratio)} else { Node.xleft+node.size }

		if (nrow(prob)>1) {
			if (path=="e") {
				if (horiz) { probAxes <- c("bottom", "right") } else { probAxes <- c("top", "left") }
			} else if (!inner) {
				if (horiz) { probAxes <- c("no", "no") } else { probAxes <- c("bottom", "no") }
			} else { probAxes <- c("no", "no") }
		} else {
			probAxes <- if (path=="e") {
				if (horiz) { c("no", "right") } else { c("no", "left") } } 
				else {c("no", "no")}
		}

		## 
		if (!inner) {
			## Bare verticale en dessous du rectangle
			if (horiz) {
				segments(xTop, yTop, xTop+Node.lim+leave.lh, yTop, col=fg.col, lty=lty, lwd=lwd)
			} else {
				segments(xTop, yTop, xTop, yTop+Node.lim+leave.lh, col=fg.col, lty=lty, lwd=lwd)
			}

			if (all(subtree@leaf, na.rm=TRUE)) {
			## Leave indicator
				if (horiz) {
					## Bare horizontale du rateau
					segments(xTop+Node.lim+leave.lh, yTop-(leave.lw/4), 
						xTop+Node.lim+leave.lh, yTop+(leave.lw/4), 
						col=fg.col, lty=lty, lwd=lwd)
				} else {
					## Bare horizontale du rateau
					segments(xTop-(leave.lw/4), yTop+Node.lim+leave.lh, xTop+(leave.lw/4), 
						yTop+Node.lim+leave.lh, col=fg.col, lty=lty, lwd=lwd)
				}
			} else {
				if (horiz) {
					symbols(xTop+Node.lim+leave.lh, yTop, circles=1, inches=(nc/4)*0.5, add=TRUE,
						fg=fg.col, bg=fg.col)
				} else {
					symbols(xTop, yTop+Node.lim+leave.lh, circles=leave.csize, inches=FALSE, add=TRUE,
						fg=fg.col, bg=fg.col)
				}
			}
		}

		plotNodeProb(Node.xleft, Node.ybottom, Node.xright, Node.ytop, prob=prob, state=NULL, 
			cpal=cpal, pruned=pruned, group=group, axes=probAxes)
	} else if (node.type=="path") {
		state <- seqdecomp(path)[1]
		node.ccol <- Xtract("c.col", nPar, default="white")
		
		if (node.ccol=="state") {
			node.ccol <- if (path=="e") root.col else cpal[which(state==alphabet)]
		}
		symbols(xTop, if (horiz) Y else yTop, circles=node.size/2, inches=inches, add=TRUE, 
			fg=if (pruned) pruned.col else par("col"), bg=node.ccol)
		## State
		text(xTop, yTop, state, xpd = TRUE, 
			## srt = lab.srt, pos=lab.pos, offset=lab.offset,
			cex = lab.cex, col = lab.col, font = lab.font)
	}

	## The node label
	text(xTop, yTop, nodeText, xpd = TRUE, srt = lab.srt, pos=lab.pos, offset=lab.offset,
		cex = lab.cex, col = lab.col, font = lab.font)

}

