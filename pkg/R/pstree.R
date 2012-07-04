## BUILDING A PROBABILISTIC SUFFIX TREE

setMethod("pstree", signature="stslist", 
	function(x, group, L, cdata=NULL, nmin=1, ymin=NULL, weighted=TRUE, with.missing=FALSE, nested.list=FALSE) {

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

	if (with.missing) { 
		A <- c(A, attr(x, "nr"))
		StCol <- c(StCol, attr(x, "missing.color"))
		StLab <- c(StLab, "missing")
	}
	names(StCol) <- A

	message(" [>] ", nrow(x), " sequence(s)")

	## Segmented PST
	if (!missing(group)) {
		if (!is.factor(group)) { group <- factor(group) }
		nbgroup <- length(levels(group))
		segmented <- TRUE
		message(" [>] ", nbgroup, " groups")
	} else {
		group <- factor(NULL)
		segmented <- FALSE
	}

	message(" [>] L=", L, ", nmin=", nmin, if (!is.null(ymin)) { paste(", ymin=", ymin, sep="") })

	for (i in 0:L) {
		if (segmented) {
			tmp <- NULL
			cprob.idx <- NULL
			for (g in 1:nbgroup) {
				data <- x[group==levels(group)[g],]
				tmp.cdata <- if (!is.null(cdata)) { cdata[group==levels(group)[1],] } else { NULL }
				ccounts <- suppressMessages(cprob(data, L=i, nmin=nmin, prob=FALSE, 
					weighted=weighted, with.missing=with.missing))
				cprob.idx <- rbind(cprob.idx, cbind(context=rownames(ccounts), group=g))
				tmp <- rbind(tmp, ccounts)
			}
		} else {
			tmp <- suppressMessages(cprob(x, L=i, nmin=nmin, prob=FALSE, weighted=weighted, with.missing=with.missing))
			cprob.idx <- cbind(context=rownames(tmp), group=1)
		}

		nodes.names <- unique(cprob.idx[, "context"])

		if (i==0) { 
			nodes.parents <- NA 
		} else if (i==1) {
			nodes.parents <- matrix("e")
		} else {
			nodes.parents <- seqdecomp(nodes.names)
			nodes.parents <- seqconc(nodes.parents[,2:ncol(nodes.parents), drop=FALSE])
		}

		tmp.list <- lapply(seq_len(length(nodes.names)), 
			function(idx) {
				node.inf <- which(cprob.idx==nodes.names[idx])
				new("PSTr", path=nodes.names[idx], counts=tmp[node.inf,A, drop=FALSE], n=tmp[node.inf,"n"], 
					order=i, ymin=ymin, group=cprob.idx[node.inf,"group"])
			}
		)
		nbnodes <- length(tmp.list)

		message(" [>] L=", i, ", adding ", nbnodes, " node(s)")

		names(tmp.list) <- nodes.names
		nodes.list[[i+1]] <- tmp.list
			
		if (i==0) { 
			nodes.parent <- NA 
		} else { 
			nodes.parents <- unique(nodes.parents)
			parents <- nodes.list[[i]]
			leaves <- which(!names(parents) %in% nodes.parents)

			if (length(leaves) > 0) {
				parents[leaves] <- lapply(parents[leaves], node.leaf)
				nodes.list[[i]] <- parents
			}
		}
	}

	## At max depth all nodes are leaves
	nodes.list[[L+1]] <- lapply(nodes.list[[L+1]], node.leaf)

	res <- new("PSTf", nodes.list, data=x, alphabet=A, cpal=StCol, labels=StLab, segmented=segmented, group=group)

	if (!is.null(cdata)) {
		c.A <- alphabet(cdata)
		c.cpal <- cpal(cdata)
		c.lab <- stlab(cdata)

		if (with.missing) { 
			c.A <- c(c.A, attr(cdata, "nr"))
			c.cpal <- c(c.cpal, attr(cdata, "missing.color"))
			c.lab <- c(c.lab, "missing")
		}

		names(c.cpal) <- alphabet(cdata)
		res <- new("PSTf.mc", res, c.data=cdata, c.alphabet=c.A, c.cpal=c.cpal)
	}
		
	if (nested.list) {
		res <- as.pstree(res)
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)





