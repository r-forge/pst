## For ppplot

plotProb <- function(x0, y0, x1, y1, prob, state, cpal) {

	ytmp <- y0
	for (s in 1:length(prob)) {
		ytop <- ytmp+prob[s]
		rect(x0, ytmp, x1, ytop, col=cpal[s], border=NA)
		ytmp <- ytop
	}
}

