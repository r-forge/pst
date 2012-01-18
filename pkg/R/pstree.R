## BUILDING A PROBABILISTIC SUFFIX TREE

setMethod("pstree", signature="stslist", 
	function(x, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, nested.list=FALSE) {

	debut <- Sys.time()

	if (missing(L)) { L <- max(seqlength(x))-1 }

	if (!weighted || is.null(attr(x, "weights"))) { attr(x, "weights") <- rep(1.0, nrow(x)) }
	## Also takes into account that in unweighted sequence objects created with 
	## older TraMineR versions the weights attribute is a vector of 1
	## instead of NULL  
	if (all(attr(x, "weights")==1)) { weighted <- FALSE }

	nodes.list <- vector("list", length=L+1)
	A <- alphabet(x)
	StCol <- cpal(x)
	StLab <- stlab(x)

	if (with.missing) { 
		A <- c(A, attr(x, "nr"))
		StCol <- c(StCol, attr(x, "missing.color"))
		StLab <- c(StLab, "missing")
	}
	names(StCol) <- A

	message(" [>] ", nrow(x), " sequence(s)")
	message(" [>] L=", L, ", nmin=", nmin, if (!missing(ymin)) { paste(", ymin=", ymin, sep="") })

	for (i in 0:L) {
		tmp <- suppressMessages(seqcprob(x, L=i, nmin=nmin, prob=FALSE, weighted=weighted, with.missing=with.missing))
		prob <- tmp[, A, drop=FALSE]/rowSums(tmp[,A, drop=FALSE])
		message(" [>] L=", i, ", adding ", nrow(tmp), " node(s)")
		
		## Smoothing
		if (!missing(ymin)) {
			prob <- ((1-(length(A)*ymin)) * prob) + ymin
		}

		nodes.path <- seqdecomp(rownames(tmp))
		nodes.parent <- if (i==0) { NA } else if (i==1) { "e" } else { seqconc(nodes.path[, 2:ncol(nodes.path), drop=FALSE]) }
		nodes.id <- nodes.path[,1]
		
		nodes.list[[i+1]] <- data.frame(prob, tmp[,"n"], 
			tmp[,A, drop=FALSE], nodes.id, parent=nodes.parent, leaf=TRUE, pruned=FALSE, stringsAsFactors=FALSE)
		names(nodes.list[[i+1]]) <- c(A, "n", paste(A, "@wn", sep=""), "id", "parent", "leaf", "pruned")

		if (i>0) {
			nodes.list[[i]]$leaf[rownames(nodes.list[[i]]) %in% nodes.list[[i+1]]$parent] <- FALSE
		}
	}

	res <- new("PSTf", nodes.list, data=x, alphabet=A, cpal=StCol, labels=StLab)
	
	if (nested.list) {
		res <- as.pstree(res)
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)





