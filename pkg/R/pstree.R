## BUILDING A PROBABILISTIC SUFFIX TREE

setMethod("pstree", signature="stslist", 
	function(x, group, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, nested.list=FALSE) {

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
	sl <- max(seqlength(x))

	wn.names <- paste(A, "@wn", sep="")

	if (with.missing) { 
		A <- c(A, attr(x, "nr"))
		StCol <- c(StCol, attr(x, "missing.color"))
		StLab <- c(StLab, "missing")
	}
	names(StCol) <- A

	message(" [>] ", nrow(x), " sequence(s)")

	## Grouped PST
	if (!missing(group)) {
		group <- factor(group)
		nbgroup <- length(levels(group))
		segmented <- TRUE
		message(" [>] ", nbgroup, " groups")
	} else {
		group <- factor(NULL)
		segmented <- FALSE
	}

	message(" [>] L=", L, ", nmin=", nmin, if (!missing(ymin)) { paste(", ymin=", ymin, sep="") })

	for (i in 0:L) {
		if (segmented) {
			tmp <- NULL
			for (g in 1:nbgroup) {
				data <- x[group==levels(group)[g],]
				ccounts <- suppressMessages(cprob(data, L=i, nmin=nmin, prob=FALSE, 
					weighted=weighted, with.missing=with.missing))
				ccounts <- cbind(ccounts, group=g)
				tmp <- rbind(tmp, ccounts)
			}
		} else {
			tmp <- suppressMessages(cprob(x, L=i, nmin=nmin, prob=FALSE, weighted=weighted, with.missing=with.missing))
			tmp <- cbind(tmp, group=1)
		}

		nodes.names <- rownames(tmp)
		rownames(tmp) <- tmp[,"group"]
		unique.names <- unique(nodes.names)
		nbnodes <- length(unique.names)

		message(" [>] L=", i, ", adding ", nbnodes, " node(s)")

		counts <- tmp[,A,drop=FALSE]
		nbdist <- nrow(counts)
		prob <- counts/rowSums(counts)
		if (!missing(ymin)) {
			prob <- ((1-(length(A)*ymin)) * prob) + ymin
		}

		## tmp.list <- vector("list", length=nbnodes)
		tmp.list <- vector("list", length=nbnodes)
		names(tmp.list) <- unique.names

		for (n in unique.names) {
			idx <- which(nodes.names==n)
			tmp.leaf <- rep(TRUE, length(idx))
			names(tmp.leaf) <- rownames(prob)[idx]
			tmp.pruned <- rep(FALSE, length(idx))
			names(tmp.pruned) <- rownames(prob)[idx]
			tmp.n <- as.numeric(tmp[idx,"n", drop=FALSE])
			names(tmp.n) <- rownames(prob)[idx]

			tmp.list[[n]] <- new("PSTr", list(), 
				counts=counts[idx, ,drop=FALSE], n=tmp.n, prob=prob[idx,,drop=FALSE],
				path=n, 
				order=as.integer(i),
				## alphabet=as.character(NULL), cpal=as.character(NULL), labels=as.character(NULL),
				leaf=tmp.leaf, pruned=tmp.pruned)
		}

		nodes.list[[i+1]] <- tmp.list
			
		nodes.path <- seqdecomp(nodes.names)
		nodes.parent <- if (i==0) { NA } 
			else if (i==1) { data.frame("e", tmp[,"group"], stringsAsFactors=FALSE)} 
			else { data.frame(seqconc(nodes.path[, 2:ncol(nodes.path), drop=FALSE]), tmp[,"group"],
				stringsAsFactors=FALSE) }
		nodes.parent <- unique(nodes.parent)

		if (i>0) {
			for (p in 1:nrow(nodes.parent)) {
				nodes.list[[i]][[nodes.parent[p,1]]]@leaf[as.character(nodes.parent[p,2])] <- FALSE
			}
		}
	}

	res <- new("PSTf", nodes.list, data=x, alphabet=A, cpal=StCol, labels=StLab, segmented=segmented, group=group)
	
	if (nested.list) {
		res <- as.pstree(res)
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)





