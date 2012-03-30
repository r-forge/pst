## Mining for contexts

setMethod("cmine", signature=c(object="PSTf"), 
	def=function(object, l, pmin, pmax, state, as.tree=FALSE) {

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
	if (length(res)> 0) {
		p <- unlist(lapply(res, function(x) { rowSums(x@.Data[,state, drop=FALSE]) }))

		if (!missing(pmin)) {
			res <- res[order(p)]
		} else if (!missing(pmax)) {
			res <- res[order(p, decreasing=TRUE)]
		}
	}

	if (as.tree) {
		res <- prune(object, keep=names(res))
	} else {
		res <- new("cprobd.list", res, alphabet=if (class(object)=="PSTf.mc") { object@c.alphabet } else { object@alphabet }, 
			cpal=if (class(object)=="PSTf.mc") { object@c.cpal } else { object@cpal }, 
			labels=if (class(object)=="PSTf.mc") { object@c.labels } else { object@labels }
			)
	}

	return(res)
}
)

