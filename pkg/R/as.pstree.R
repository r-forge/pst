as.pstree <- function(object, L=NULL, verbose=FALSE) {

	if (is.null(L)) { L <- length(object)-1 }

	debut <- Sys.time()

	message(" [>] building PST, depth=", L)

	A <- alphabet(object)
	wn.names <- paste(A, "@wn", sep="")
	labels <- stlab(object)
	cpal <- cpal(object)

	nbstate <- length(A)

	proto <- if (is(object, "PSTf.mc")) {
		vector("list", length=length(object@context.alphabet))
	} else { vector("list", length=length(A)) }

	names(proto) <- if (is(object, "PSTf.mc")) {object@context.alphabet} else {A}

	if (object@grouped) {
		nbpos <- length(object[[1]])

		## Root node
		K0 <- NULL
		for (pos in 1:nbpos) {
			K0 <- rbind(K0, object[[1]][[pos]])
		}
		rownames(K0) <- 1:nbpos
	} else {
		K0 <- object[[1]]
	}

	N0 <- new("PSTr", proto, counts=as.matrix(K0[,wn.names]), n=K0[,"n"],  prob=as.matrix(K0[,A]),
		path="e", order=as.integer(0), 
		alphabet=A, cpal=cpal, labels=labels, leaf=K0[,"leaf"], pruned=K0[,"pruned"])

	for (i in 2:(L+1)) {
		if (object@grouped) {
			plist <- unique(unlist(lapply(object[[i]], rownames)))
			id <- seqdecomp(plist)
			node <- id[,ncol(id):1, drop=FALSE]
			j <- 1

			for (p in plist) {
				Kp <- NULL
				for (pos in 1:nbpos) {
					Kp <- rbind(Kp, object[[i]][[pos]][p,])
				}
				rownames(Kp) <- 1:nbpos

				if (i==(L+1)) { Kp[,"leaf"] <- TRUE }
		
				if (verbose) { message(" [>] adding node ", p) }
				## The node's parent is the longest suffix of the string
				N0[[node[j,]]] <- new("PSTr", proto, 
					counts=as.matrix(Kp[,wn.names]), n=Kp[,"n"], prob=as.matrix(Kp[,A]),
					path=p, 
					order=as.integer(i-1),
					## alphabet=as.character(NULL), cpal=as.character(NULL), labels=as.character(NULL),
					leaf=Kp[,"leaf"], pruned=Kp[,"pruned"])
				j <- j+1
			}
		} else {
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
						counts=counts[j, ,drop=FALSE], n=n[j], prob=prob[j,,drop=FALSE],
						path=id.comp[j], 
						order=as.integer(i-1),
						## alphabet=as.character(NULL), cpal=as.character(NULL), labels=as.character(NULL),
						leaf=leaf[j], pruned=pruned[j])
				} 
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


