as.pstree <- function(object, L=NULL, verbose=FALSE) {

	if (is.null(L)) { L <- length(object)-1 }

	debut <- Sys.time()

	message(" [>] building PST, depth=", L)

	A <- alphabet(object)
	wn.names <- paste(A, "@wn", sep="")
	labels <- stlab(object)
	cpal <- cpal(object)

	nbstate <- length(A)

	proto <- vector("list", length=length(A))
	names(proto) <- A

	## Root node
	K0 <- object[[1]]

	N0 <- new("PSTr", proto, counts=as.matrix(K0[,wn.names])[1,], n=K0[1,"n"],  prob=as.matrix(K0[,A])[1,],
		path=rownames(K0)[1], order=as.integer(0), 
		alphabet=A, cpal=cpal, labels=labels, leaf=K0[1,"leaf"], pruned=K0[1,"pruned"])

	for (i in 2:(L+1)) {
		id.comp <- rownames(object[[i]])
		prob <- as.matrix(object[[i]][,A])
		counts <- as.matrix(object[[i]][, wn.names])
		n <- as.matrix(object[[i]]$n)
		leaf <-  object[[i]]$leaf
		pruned <- object[[i]]$pruned
		if (i==(L+1)) { leaf[] <- TRUE }
		nbseg <- nrow(prob)

		if (nbseg>0) {
			id <- seqdecomp(id.comp)
			node <- id[,ncol(id):1, drop=FALSE]
				
			for (j in 1:nbseg) {

				if (verbose) { message(" [>] adding node", rownames(Ki)[j]) }
				## The node's parent is the longest suffix of the string
				N0[[node[j,]]] <- new("PSTr", proto, 
					counts=counts[j, ], n=n[j], prob=prob[j,],
					path=id.comp[j], 
					order=as.integer(i-1),
					## alphabet=as.character(NULL), cpal=as.character(NULL), labels=as.character(NULL),
					leaf=leaf[j], pruned=pruned[j])
			} 
		}
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(N0)
}


