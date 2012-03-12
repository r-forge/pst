## Plotting probability distribution as a stacked bar

plotNodeProb <- function(x0, y0, x1, y1, prob, state, cpal, pruned, group, horiz=TRUE, axes=c("no", "no"), 
	bgcol="grey90", pruned.col="red", cex.axes=0.6) {
	if (getOption("verbose")) {
		message(" x0=", x0, ", y0=", y0, ", x1=", x1, ", y1=", y1)
		message(" Prob:", prob)
	}

	A <- colnames(prob)
	xsize <- x1-x0
	ysize <- abs(y1-y0)
	nbgroup <- length(group)

	rect(x0, y0, x1, y1, col=bgcol, border=NA)

	if (!horiz) {
		pdim <- ysize/nbgroup
		ybot <- y0

		for (g in 1:nbgroup) {
			ytop <- ybot+pdim

			xtmp <- x0
			if (group[g] %in% rownames(prob)) {
				for (s in 1:length(A)) {
					xright <- xtmp+(prob[group[g], s]*xsize)

					rect(xtmp, ybot, xright, ytop, col=cpal[s], border=NA)
					xtmp <- xright
				}
			
				if (pruned[group[g]]) {
					segments(x0, y0, x1, y1,
						col = "red", ## lty = lty, lwd = lwd
					)
				}
			}
			ybot <- ytop
		}
	} else {
		pdim <- xsize/nbgroup
		xleft <- x0

		for (g in 1:nbgroup) {
			xright <- xleft+pdim

			ytmp <- y0
			if (group[g] %in% rownames(prob)) {
				for (s in 1:length(A)) {
					ybot <- ytmp-(prob[group[g], s]*ysize)

					rect(xleft, ytmp, xright, ybot, col=cpal[s], border=NA)
					ytmp <- ybot
				}
			}
			xleft <- xright
		}
		if (axes[1]=="bottom") {
			axe.offset <- if (nbgroup>1 && any(pruned, na.rm=TRUE)) { ysize*0.3 } else {0}
			## x axis
			segments(x0, y0+(0.1*ysize)+axe.offset, x1, y0+(0.1*ysize)+axe.offset)
			segments(x0, y0+(0.1*ysize)+axe.offset, x0, y0+(0.2*ysize)+axe.offset)
			segments(x1, y0+(0.1*ysize)+axe.offset, x1, y0+(0.2*ysize)+axe.offset)
			text(x=c(x0,x1), y=c(y0+(0.25*ysize)+axe.offset, y0+(0.25*ysize)+axe.offset), 
				labels=rownames(prob)[c(1, nbgroup)], cex=0.6)
		} else if (axes[1]=="top") {
			segments(x0, y1-(0.1*ysize), x1, y1-(0.1*ysize))
			segments(x0, y1-(0.1*ysize), x0, y1-(0.2*ysize))
			segments(x1, y1-(0.1*ysize), x1, y1-(0.2*ysize))
			text(x=c(x0,x1), y=c(y1-(0.25*ysize), y1-(0.25*ysize)), labels=c(1, nbgroup), cex=cex.axes)
		}


		if (axes[2]=="left") {
			## y axis
			segments(x0-(0.1*xsize), y0, x0-(0.1*xsize), y1)
			segments(x0-(0.1*xsize), y0, x0-(0.15*xsize), y0)
			segments(x0-(0.1*xsize), y1, x0-(0.15*xsize), y1)
			text(x=c(x0-(0.25*xsize),x0-(0.25*xsize)), y=c(y0, y1), labels=c(0,1), cex=cex.axes, srt=90)
		}

		## A bar showing the pruned and unpruned nodes
		if (nbgroup>1 && any(pruned, na.rm=TRUE)) {
			rect(x0, y0+(ysize*0.1), x1, y0+(ysize*0.3), col=bgcol, border=NA)
			xleft <- x0
			for (g in 1:nbgroup) {
				xright <- xleft+pdim
				if (group[g] %in% rownames(prob)) {
					if (pruned[group[g]]) {
						rect(xleft, y0+(ysize*0.1), xright, y0+(ysize*0.3),
							col=pruned.col, border=NA)
					} else if (!pruned[group[g]]) {
						rect(xleft, y0+(ysize*0.1), xright, y0+(ysize*0.3), 
							col="green", border=NA)
					}
				}
				xleft <- xright
			}
			rect(x0, y0+(ysize*0.1), x1, y0+(ysize*0.3))
		} else if (nbgroup==1 && pruned[group[g]]) {
			segments(x0, y0, x1, y1, col = pruned.col)
		}
	}

	rect(x0, y0, x1, y1)
}


 
