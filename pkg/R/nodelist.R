

nodelist <- function(seqdata, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE) {

	debut <- Sys.time()

	nodes.list <- vector("list", length=L+1)
	A <- alphabet(seqdata)
	StCol <- cpal(seqdata)
	names(StCol) <- A

	message(" [>] ", nrow(seqdata), " sequence(s)")
	message(" [>] L=", L, ", nmin=", nmin, if (!missing(ymin)) { paste(", ymin=", ymin, sep="") })

	for (i in 0:L) {
		tmp <- suppressMessages(seqcprob(seqdata, L=i, nmin=nmin, prob=FALSE, weighted=weighted, with.missing=with.missing))
		prob <- tmp[, A, drop=FALSE]/rowSums(tmp[,A, drop=FALSE])
		message(" [>] L=", i, ", adding ", nrow(tmp), " node(s)")
		
		## Smoothing
		if (!missing(ymin)) {
			prob <- ((1-(length(A)*ymin)) * prob) + ymin
		}

		nodes.path <- seqdecomp(rownames(tmp))
		nodes.parent <- if (i==0) { NA } else if (i==1) { "e" } else { seqconc(nodes.path[, 2:ncol(nodes.path)]) }
		nodes.id <- nodes.path[,1]
		
		nodes.list[[i+1]] <- data.frame(prob, tmp[,"n"], 
			tmp[,A, drop=FALSE], nodes.id, parent=nodes.parent, leaf=TRUE, pruned=FALSE, stringsAsFactors=FALSE)
		names(nodes.list[[i+1]]) <- c(A, "n", paste(A, "@wn", sep=""), "id", "parent", "leaf", "pruned")

		if (i>0) {
			nodes.list[[i]]$leaf[rownames(nodes.list[[i]]) %in% nodes.list[[i+1]]$parent] <- FALSE
		}
	}

	res <- new("PSTf", nodes.list, data=seqdata, alphabet=A, cpal=StCol, labels=stlab(seqdata))

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
