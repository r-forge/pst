## Frequent patterns

setMethod("pmine", signature=c(object="PSTf", data="stslist"), 
	def=function(object, data, l, pmin, pmax, lag, state, stprob=FALSE, output="sequences") {
	A <- alphabet(object)

	prob <- predict(object, data, decomp=TRUE)
	nbps <- rowSums(!is.na(prob))

	if (!stprob) {
		prob <- exp(rowSums(log(prob), na.rm=TRUE)/nbps)
		
		select.seq <- if (!missing(pmin)) { prob>=pmin } else if (!missing(pmax)) { prob < pmax }
		res <- unique(data[select.seq,])

	} else {

		prob.check <- if (!missing(pmin)) { prob>=pmin } else if (!missing(pmax)) { prob < pmax }
		select.seq <- vector(mode="logical", length=nrow(data))

		sl <- max(seqlength(data))

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
				tmp <- seqconc(data[fp,  1:(p+l-1)])
				patterns.list <- c(patterns.list, unique(tmp[!tmp %in% patterns.list]))
			}
		}

		if (output=="patterns") {
			nr <- if ("*" %in% A) { "#" } else { "*" }
			res <- seqdef(patterns.list, alphabet=A, labels=object@labels, cpal=cpal(object), nr=nr)
		} else {
			res <- unique(data[select.seq,])
		}
	}

	return(res)
}
)




