## Mining for contexts

setMethod("cmine", signature=c(object="PSTf"), 
	def=function(object, l, pmin, pmax, state) {

	if (missing(l)) { 
		l <- 1:length(object)
	}

	res <- list()
	for (i in l) {
		tmp <- lapply(object[[i]], node.mine, pmin=pmin, pmax=pmax, state=state)
		tmp <- tmp[!unlist(lapply(tmp, is.null))]
		res <- c(res, tmp)
	}

	## sorting results
	p <- unlist(lapply(res, function(x) { x@.Data }))

	if (!missing(pmin)) {
		res <- res[order(p)]
	} else if (!missing(pmax)) {
		res <- res[order(p, decreasing=TRUE)]
	}

	return(res)
}
)

