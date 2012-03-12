## Computing sequence probability

setMethod("predict", signature=c(object="PSTf"), 
	def=function(object, seqdata, group, L=NULL, p1=NULL, output="prob", decomp=FALSE, base=2) {

	if (object@grouped) {
		sl <- seqlength(seqdata)
		if (decomp) {
			prob <- matrix(nrow=nrow(seqdata), ncol=max(sl))
			colnames(prob) <- colnames(seqdata)
		} else {
			prob <- matrix(nrow=nrow(seqdata), ncol=1)
			colnames(prob) <- output
		}

		rownames(prob) <- rownames(seqdata)

		nbgroup <- length(levels(object@group))
		group <- factor(group)
		if (length(group)!=nrow(seqdata)) {
			stop(" group must contain one value for each sequence in seqdata")
		}

		for (g in 1:nbgroup) {
			message(" [>] predicting states for group ", g)
			group.idx <- which(group==levels(group)[g])

			pst <- subtree(object, group=g)
			prob.tmp <- predict(pst, seqdata[group.idx,], L=L, p1=p1, output=output, decomp=decomp, base=base)
			prob[group.idx,] <- prob.tmp
		}
	
		return(prob)
	} else {
		if (any(as.data.frame(seqdata)==attr(seqdata,"nr"))) {
			message(" [>] found missing value in sequence data")
			if (!attr(seqdata, "nr") %in% object@alphabet) {
				message(" [>] PST built without missing value as additional state")
				if (!decomp) {
					message("    [>] sequence probabilities not calculated on the same number of values")
				}
			}
		}

		debut <- Sys.time()

		A <- alphabet(object)
		n <- nrow(seqdata)
		sl <- seqlength(seqdata)

		message(" [>] ", n, " sequence(s) - min/max length: ", min(sl),"/",max(sl))

		if (min(sl)!=max(sl) & output=="prob" & !decomp) {
			message(" [!] sequences have unequal lengths")
		}

		if (is.null(L)) {
			L <- length(object)-1
		}

		message( " [>] max. depth: L=", L)

		message(" [>] extracting node labels from PST")
		prefix.table <- unlist(lapply(object[1:(L+1)], names))
		pruned.nodes <- unlist(lapply(object[1:(L+1)], pruned.nodes))
		if (any(pruned.nodes)) { 
			message(" [>] removing ", sum(pruned.nodes), " nodes tagged as pruned from node list")
			prefix.table <- prefix.table[!pruned.nodes] 
		}

		## getting prefixes of max length L for each state
		prefixes <- as.vector(prefix(seqdata, L=L))
		states <- as.vector(as.matrix(seqdata))
		prob <- vector("numeric", length=length(states))
		prob[] <- NA
		unique.prefixes <- unique(prefixes)

		prefix.idx <- match(prefixes, unique.prefixes)

		## taking longest suffix until prefix found in PST
		message(" [>] searching for context(s) in PST")
		unmatched <- !unique.prefixes %in% prefix.table
		while (sum(unmatched>0)) {
			tmp <- seqdecomp(unique.prefixes[unmatched])
			if (ncol(tmp)>1) {
				unique.prefixes[unmatched] <- seqconc(tmp[,2:ncol(tmp), drop=FALSE])
				unique.prefixes[unique.prefixes==""] <- "e"
			} else { 
				unique.prefixes[unmatched] <- "e"
			}
	
			## we may have reduced the number of distinct prefixes
			tmp <- unique(unique.prefixes)
			unique.match <- match(unique.prefixes, tmp)
			prefix.idx <- unique.match[prefix.idx]

			##
			unique.prefixes <- tmp
			unmatched <- !unique.prefixes %in% prefix.table
			## print(unique.prefixes[unmatched])
		}
	
		message(" [>] computing prob., ", nrow(seqdata), " sequences, max. depth=", L, sep="")
		message(" [>] ", length(unique.prefixes), " distinct context(s)")
  
		for (p in 1:length(unique.prefixes)) {
			prefix <- unique.prefixes[p]
			prefix.eq <- which(prefix.idx==p)
      
			if (prefix=="e") {
				if (!is.null(p1)) {
					tmp <- p1
				} else {
					tmp <- object[[1]][["e"]]@prob
				}
			} else {
				sd <- unlist(strsplit(prefix, split="-"))
				idxl <- length(sd)+1	

				tmp <- object[[idxl]][[prefix]]@prob
			}

			tmp <- as.numeric(tmp)

			for (s in 1:length(tmp)) {
        			state.eq <- states[prefix.eq]==A[s]
				prob[prefix.eq][state.eq] <- tmp[s]
			}
		}
  
  		prob <- matrix(prob, ncol=ncol(seqdata))
		rownames(prob) <- rownames(seqdata)
		colnames(prob) <- colnames(seqdata)

		if (output=="logloss") {
			prob <- -log(prob, base=base)
		} else if (output=="SIMn") {
			prob <- log(prob, base=base)
		}

		if (!decomp) {
			if (output=="prob") {
				prob <- apply(prob,1, rowProds)
			} else if (output %in% c("logloss", "SIMn")) {
				prob <- rowSums(prob)/rowSums(!is.na(prob))
			}

			## if only one sequences we return a matrix as well 
			if (is.null(dim(prob))) { prob <- matrix(prob, nrow=nrow(seqdata)) }
			rownames(prob) <- rownames(seqdata)
			colnames(prob) <- output
		}

		fin <- Sys.time()
		message(" [>] total time: ", format(round(fin-debut, 3)))

		return(prob)
	}
}
)


rowProds <- function(x) {

	vpos <- which(!is.na(x))

	if (length(vpos)>0) {
		p <- 1		
		for (i in vpos) {
			p <- p*x[i]
		}
	} else {
		p <- NULL
	}

	return(p)
}








