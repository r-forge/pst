## Plotting probability distribution as a stacked bar

plotNodeProb <- function(x0, y0, x1, y1, prob, state, cpal, pruned, horiz=TRUE, axes=FALSE) {
	## message(" x0=", x0, ",y0=", y0, ",x1=", x1, ",y1=", y1)

	A <- colnames(prob)
	xsize <- x1-x0
	ysize <- y1-y0

	rect(x0, y0, x1, y1, col="lightgray", border=NA)

	if (!horiz) {
		pdim <- ysize/nrow(prob)
		ybot <- y0

		for (pos in 1:nrow(prob)) {
			ytop <- ybot+pdim

			xtmp <- x0
			if (!any(is.na(prob[pos,]))) {
				for (s in 1:length(A)) {
					xright <- xtmp+(prob[pos, s]*xsize)

					rect(xtmp, ybot, xright, ytop, col=cpal[s], border=NA)
					xtmp <- xright
				}
			
				if (pruned[pos]) {
					segments(x0, y0, x1, y1,
						col = "red", ## lty = lty, lwd = lwd
					)
				}
			}
			ybot <- ytop
		}
	} else {
		pdim <- xsize/nrow(prob)
		xleft <- x0

		for (pos in 1:nrow(prob)) {
			xright <- xleft+pdim

			ytmp <- y0
			if (!any(is.na(prob[pos,]))) {
				for (s in 1:length(A)) {
					ybot <- ytmp+(prob[pos, s]*ysize)

					rect(xleft, ytmp, xright, ybot, col=cpal[s], border=NA)
					ytmp <- ybot
				}
			
				if (pruned[pos]) {
					segments(x0, y0, x1, y1,
						col = "red", ## lty = lty, lwd = lwd
					)
				}
			}
			xleft <- xright
		}
		if (axes) {
			segments(x0, y0-0.1, x1, y0-0.1)
			segments(x0, y0-0.1, x0, y0-0.125)
			segments(x1, y0-0.1, x1, y0-0.125)
		}
	}

	rect(x0, y0, x1, y1)

}


 
