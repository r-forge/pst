## Plotting probability distribution as a stacked bar

plotProb <- function(x0, y0, x1, y1, prob, cpal) {
	
	rect(x0, y0, x1, y1)

	ptmp <- y0
	for (s in 1:length(prob)) {
		rect(x0, ptmp, x1, ptmp+prob[s], col=cpal[s])
		ptmp <- ptmp+prob[s]
	}
}
 
