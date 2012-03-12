as.pstree <- function(object, L=NULL, verbose=FALSE) {

	if (is.null(L)) { L <- length(object)-1 }

	debut <- Sys.time()

	message(" [>] building PST, depth=", L)

	N0 <- object[[1]][["e"]]
	N0@alphabet <- alphabet(object)
	N0@labels <- stlab(object)
	N0@cpal <- cpal(object)

	for (i in 2:(L+1)) {
		id.comp <- names(object[[i]])
		id <- seqdecomp(id.comp)
		nbseg <- length(id.comp)

		if (nbseg>0) {
			node <- id[,ncol(id):1, drop=FALSE]
				
			for (j in 1:nbseg) {
				if (verbose) { message(" [>] adding node", rev(node[j,]))}
					## The node's parent is the longest suffix of the string
				N0[[node[j,]]] <- object[[i]][[id.comp[j]]]
			}
		}

	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(N0)
}

## setAs(from="PSTf.gr", to="PSTr.tv", def=function(from) as.pstree.gr(from))
setAs(from="PSTf", to="PSTr", def=function(from) as.pstree(from))
setAs(from="PSTf.mc", to="PSTr", def=function(from) as.pstree(from))


