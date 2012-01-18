## Plotting probability distribution as a stacked bar

plotProb <- function(x0, y0, x1, y1, prob, state, cpal) {
	
	ptmp <- y0
	
	if (!missing(state)) {
		rect(x0, ptmp, x1, ptmp+prob[state], col=cpal[state])
	} else {
		rect(x0, y0, x1, y1)

		for (s in 1:length(prob)) {
			rect(x0, ptmp, x1, ptmp+prob[s], col=cpal[s])
			ptmp <- ptmp+prob[s]
		}
	}
}
 
