## ==============
## Plotting nodes
## ==============
plotNode <- function(x1, x2, subtree, dLeaf, nPar, 
    ePar, horiz = FALSE, gratio, max.level, group) {

	scale <- seq(0, 1, 0.2)
	vprob <- FALSE

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

	## Setting node parameters
	i <- if (inner) 1 else 2

	node.size <- Xtract("node.size", nPar, default = 0.6)
	pfactor <- Xtract("pfactor", nPar, default = 0)
	node.size <- node.size*(1+pfactor)^(max.level-depth)
	ns.adj <- ((node.size/2)*gratio)

	node.type <- Xtract("node.type", nPar, default = c("prob", "prob"), i)
	pch <- Xtract("pch", nPar, default = 1L:2, i)
	cex <- Xtract("cex", nPar, default = c(1, 1), i)
	pruned.col <- Xtract("pruned.col", nPar, default = "red")
	root.col <- Xtract("root.col", nPar, default = "grey")
	bg <- Xtract("bg", nPar, default = par("bg"), i)
	pform <- Xtract("pform", nPar, default = "SPS")

	lab.col <- Xtract("lab.col", nPar, default = par("col"), i)
	lab.cex <- Xtract("lab.cex", nPar, default = c(1, 1), i)
	lab.font <- Xtract("lab.font", nPar, default = par("font"), i)
	lab.type <- Xtract("lab.type", nPar, default = "n", i)
	lab.srt <- Xtract("lab.srt", nPar, default = 0, i)
	lab.pos <- Xtract("lab.pos", nPar, default = NULL, i)
	lab.offset <- Xtract("lab.offset", nPar, default = 0.5, i)

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
		X <- yTop + dLeaf * lab.cex
		Y <- xTop
		tmp <- yTop
		yTop <- xTop
		xTop <- tmp
		offset <- nchar(nodeText)/2
		inches <- node.size/2
        } else {
		Y <- yTop - dLeaf * lab.cex
		X <- xTop
		offset <- nchar(nodeText)/2
		inches <- FALSE
        }

	## Setting edge parameters
	type <- Xtract("type", ePar, default = "rectangle", 1)
	col <- Xtract("col", ePar, default = "grey", 1)
	lty <- Xtract("lty", ePar, default = par("lty"), 1)
	lwd <- Xtract("lwd", ePar, default = 3, 1)
	c.size <- Xtract("c.size", ePar, default = if (horiz) { node.size*0.66*gratio } else { (node.size/2)*0.66 } )

	## If there are children, potting edges and child nodes
	if (inner) {
		stcol <- Xtract("stcol", ePar, default = cpal)

		if (type == "rectangle") {
			## Bare verticale en dessous du rectangle
			if (horiz) {			
				segments(xTop+((node.size/2)*gratio), yTop, xTop+0.5, yTop, 
					col=col, lty=lty, lwd=lwd)
			} else {
				segments(X, yTop+ns.adj, X, yTop+0.5, 
					col=col, lty=lty, lwd=lwd)
			}
		}

		## Plotting edges and child nodes
		## Selecting non null child nodes only
		for (k in children) {
			child <- subtree[[k]]
			idx <- which(k==children)

			yBot <- child@order
			if (getOption("verbose")) { cat("ch.", k, "@ h=", yBot, "; ") }
			xBot <- mean(bx$limit[idx:(idx + 1)])

			## REECRIRE UNE FONCTION is.leaf CORRRECTE PAR LA SUITE
			leaf <- length(which.child(child))==0

            		i <- if (!leaf && child@order<max.level) 1 else 2

			## edge parameters
            		col <- Xtract("col", ePar, default = "grey", i)
            		lty <- Xtract("lty", ePar, default = par("lty"), i)
            		lwd <- Xtract("lwd", ePar, default = 3, i)
			c.col <- Xtract("c.col", ePar, default = "state", i)
			c.border <- Xtract("c.border", ePar, default = par("fg"), i)
			p.lwd <- Xtract("p.lwd", ePar, default = lwd, i)
			p.lty <- Xtract("p.lty", ePar, default = lty, i)
			t.col <- Xtract("t.col", ePar, default = "black", i)
			t.cex <- Xtract("t.cex", ePar, default = lab.cex, i)
			t.font <- Xtract("t.font", ePar, default = par("font"), i)
			## Color from circle to prob barplot
			ctp.col <- Xtract("ctp", ePar, default = "edge", i)

			if (type == "triangle") {
				if (horiz) {
					## slope <- (xBot-xTop)/(yBot-yTop)/gratio
					## xadj <- (slope*((yTop+(node.radius))-yBot))+xBot
					## xadj <- yTop
					## tmp <- xBot+((node.size/2)*gratio)
					## xBot <- yBot-((node.size/2)*gratio)
					tmp <- xBot
					xBot <- yBot
					yBot <- tmp
					yNode.bottom <- yTop
					xadj <- xTop+((node.size/2)*gratio) 
				} else {
					xadj <- if (xTop>xBot) xTop-((node.size/2)*gratio) 
						else if (xTop<xBot) xTop+((node.size/2)*gratio)
						else xTop
				}
				if (node.type=="prob") {
					segments(xadj, yNode.bottom, xBot, yBot-((node.size/2)*gratio), 
						## col=if (path=="e") {col} else {cpal[which(state==alphabet)]},
						col=col,
						lty=lty, lwd=lwd)
				} else {
					## segments(xadj, yTop+((node.size/2)*gratio), xBot, 
					##	yBot-((node.size/2)*gratio), col=col, lty=lty, lwd=lwd)
					segments(xTop, yTop, xBot, yBot, col=col, lty=lty, lwd=lwd)
				}
			} else {
				## The color of the edge
				ecol <- if (ctp.col=="state" & k %in% names(stcol)) { stcol[k] } else { col }
				ccol <- if (c.col=="state" & k %in% names(stcol)) { stcol[k] } else { col }

				if (horiz) {
					if (getOption("verbose")) { 
						cat("Child:", child@path, "yTop=", yTop, "xBot=", xBot, "xTop=", xTop)
					}
					## Bare horizontale du rateau
					segments(xTop+0.5, xBot, xTop+0.5, yTop, col=col, lty=lty, lwd=lwd)

					## Middle of the edge stemming from children
					yMid <- (xTop+0.5+xTop+1-((node.size/2)*gratio))/2

					## Edge from the node to edge from parent
					segments(xTop+0.5, xBot, yMid, xBot, col=col, lty=lty, lwd=lwd)
					segments(yMid, xBot, xTop+1, xBot, col=ecol, lty=lty, lwd=lwd)

					if (node.type=="prob") {
						symbols(yMid, xBot, circles=c.size, bg=ccol, fg=col, add=TRUE, inches=FALSE)
						text(yMid, xBot, asTxt(k), cex=t.cex, font=t.font, col=t.col)
					}
					
				} else {
					segments(xTop, yTop+0.5, xBot, yTop+0.5, col=col, lty=lty, lwd=lwd)

					## Middle of the edge stemming from children
					yMid <- (yTop+0.5+yBot-((node.size/2)*gratio))/2

					segments(xBot, yTop+0.5, xBot, yMid, col=col, lty=lty, lwd=lwd)
                			segments(xBot, yMid, xBot, yTop+1, col=ecol, lty=lty, lwd=lwd)

					if (node.type=="prob") {
						symbols(xBot, yMid, circles=c.size, bg=ccol , fg=col, add=TRUE, inches=FALSE)
						text(xBot, yMid, asTxt(k), cex=t.cex, font=t.font, col=t.col)
					}
				}
			}

			## Plotting the node
			plotNode(bx$limit[idx], bx$limit[idx+1], subtree = child, dLeaf, nPar=nPar, ePar=ePar, 
                		horiz=horiz, gratio=gratio, max.level=max.level, group=group)
		}
	} else if (node.type=="prob") {
		leave.lh <- Xtract("leave.lh", ePar, default=0.1)
		leave.lw <- Xtract("leave.lw", ePar, default=node.size)
		leave.csize <- Xtract("leave.csize", ePar, default=c.size*0.5)

		## Bare verticale en dessous du rectangle
		if (horiz) {
			segments(xTop, yTop, xTop+leave.lh, yTop, col=col, lty=lty, lwd=lwd)
		} else {
			segments(X, yTop, X, yTop+leave.lh, col=col, lty=lty, lwd=lwd)
		}

		if (all(subtree@leaf, na.rm=TRUE)) {
		## Leave indicator
			if (horiz) {
				## Bare horizontale du rateau
				segments(xTop+leave.lh, yTop-(leave.lw/2), xTop+leave.lh, yTop+(leave.lw/2), 
					col=col, lty=lty, lwd=lwd)
			} else {
				## Bare horizontale du rateau
				segments(X-(leave.lw/2), yTop+leave.lh, X+(leave.lw/2), 
					yTop+leave.lh, col=col, lty=lty, lwd=lwd)
			}
		} else {
			if (horiz) {
				symbols(xTop+leave.lh, yTop, circles=leave.lw/2, inches=leave.csize*gratio, add=TRUE,
					fg=col, bg=col)
			} else {
				symbols(X, yTop+leave.lh, circles=leave.csize, inches=FALSE, add=TRUE,
					fg=col, bg=col)
			}
		}
	}

	## Plotting the probability distribution or the circle representing the node
	if (node.type=="prob") {
		Node.ytop <- if (horiz) {yTop-(node.size/2)} else { yTop-ns.adj }
		Node.ybottom <- if (horiz) {yTop+(node.size/2)} else { Node.ytop+(ns.adj*2) }
		Node.xleft <- if (horiz) {xTop+(node.size/2)*gratio} else {X-(node.size/2)}
		Node.xright <- if (horiz) {Node.xleft-(node.size*gratio)} else { Node.xleft+node.size }

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

		plotNodeProb(Node.xleft, Node.ybottom, Node.xright, Node.ytop, prob=prob, state=NULL, 
				cpal=cpal, pruned=pruned, group=group, axes=probAxes)
	} else if (node.type=="path") {
		state <- seqdecomp(path)[1]
		col.node <- if (path=="e") root.col else cpal[which(state==alphabet)]
		symbols(xTop, if (horiz) Y else yTop, circles=node.size/2, inches=inches, add=TRUE, 
			fg=if (pruned) pruned.col else par("col"), bg=col.node)
	}

	## The node label
	## text(X, Y+((node.size/4)*gratio), nodeText, xpd = TRUE, srt = srt, adj = adj, pos=pos,
        ## cex = lab.cex, col = lab.col, font = lab.font)
	text(xTop, yTop, nodeText, xpd = TRUE, srt = lab.srt, pos=lab.pos, offset=lab.offset,
		cex = lab.cex, col = lab.col, font = lab.font)

	if (vprob) {
		text(X, Y+0.2+ns.adj, 
			paste("(", paste(round(prob,2), collapse=","),")", sep=""),
			xpd = TRUE, srt = srt, pos=pos, offset=offset, cex = lab.cex, col = lab.col, font = lab.font)
	}
}

