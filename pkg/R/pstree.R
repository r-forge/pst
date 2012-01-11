## BUILDING A PROBABILISTIC SUFFIX TREE

setMethod("pstree", signature="stslist", 
	function(x, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, nested.list=FALSE) {

	if (missing(L)) { L <- max(seqlength(x))-1 }

	debut <- Sys.time()

	if (!weighted || is.null(attr(x, "weights"))) { attr(x, "weights") <- rep(1.0, nrow(x)) }
	## Also takes into account that in unweighted sequence objects created with 
	## older TraMineR versions the weights attribute is a vector of 1
	## instead of NULL  
	if (all(attr(x, "weights")==1)) { weighted <- FALSE }

	res <- nodelist(x, L=L, nmin=nmin, ymin=ymin, weighted=weighted, with.missing=with.missing)
	
	if (nested.list) {
		res <- as.pstree(res)
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)





