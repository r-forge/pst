## Frequent patterns

pmine <- function(PST, seqdata, l, pmin, lag, output="sequences") {
	A <- alphabet(PST)

	prob <- predict(PST, seqdata, decomp=TRUE)
	prob.check <- prob>=pmin
	select.seq <- vector(mode="logical", length=nrow(seqdata))

	sl <- max(seqlength(seqdata))

	patterns.list <- NULL

	if (missing(lag)) {
		lag <- 0
	}

	if (missing(l)) {
		l <- sl-lag
	}

	for (p in (1+lag):(sl-l+1)) {
		fp <- rowSums(prob.check[, p:(p+l-1)])==l
		select.seq[fp] <- TRUE
		if (output=="patterns") {
			tmp <- seqconc(seqdata[fp,  1:(p+l-1)])
			patterns.list <- c(patterns.list, unique(tmp[!tmp %in% patterns.list]))
		}
	}

	if (output=="patterns") {
		nr <- if ("*" %in% A) { "#" } else { "*" }
		res <- seqdef(patterns.list, alphabet=A, labels=PST@labels, cpal=cpal(PST), nr=nr)
	} else {
		res <- unique(seqdata[select.seq,])
	}

	return(res)
}





