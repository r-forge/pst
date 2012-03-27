## Mining for contexts

setMethod("cmine", signature=c(object="PSTf"), 
	def=function(object, l, pmin, pmax, state) {

	if (missing(l)) { 
		l <- 1:length(object)
	}

	res <- list()
	for (i in l) {
		if (!missing(pmin)) { 
			tmp <- lapply(object[[i]], node.mine, pmin=pmin, state=state)
		} else if (!missing(pmax)) {
			tmp <- lapply(object[[i]], node.mine, pmax=pmax, state=state)
		}		
		tmp <- tmp[!unlist(lapply(tmp, is.null))]
		res <- c(res, tmp)
	}

	## sorting results
	p <- unlist(lapply(res, function(x) { rowSums(x@.Data[,state, drop=FALSE]) }))

	if (!missing(pmin)) {
		res <- res[order(p)]
	} else if (!missing(pmax)) {
		res <- res[order(p, decreasing=TRUE)]
	}

	res <- new("cprobd.list", res, alphabet=object@alphabet, cpal=object@cpal, labels=object@labels)

	return(res)
}
)

