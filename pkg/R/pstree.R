## BUILDING A PROBABILISTIC SUFFIX TREE

setMethod("pstree", "stslist", function(object, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, method="A", 
	verbose=FALSE, nested.list=FALSE) {

	if (missing(L)) { L <- max(seqlength(object))-1 }

	debut <- Sys.time()

	A <- alphabet(object)
	wn.names <- paste(A, "@wn", sep="")
	labels <- stlab(object)
	cpal <- cpal(object)

	if (with.missing) { 
		A <- c(A, attr(object, "nr"))
		cpal  <- c(cpal, attr(object, "missing.color"))
	}

	if (!weighted || is.null(attr(object, "weights"))) { attr(object, "weights") <- rep(1.0, nrow(object)) }
	## Also takes into account that in unweighted sequence objects created with 
	## older TraMineR versions the weights attribute is a vector of 1
	## instead of NULL  
	if (all(attr(object, "weights")==1)) { weighted <- FALSE }

	res <- nodelist(object, L=L, nmin=nmin, ymin=ymin, weighted=weighted, with.missing=with.missing)
	
	if (nested.list) {
		res <- as.pstree(nl)
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)





