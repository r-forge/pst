## ==============================
## Computing sequence probability
## ==============================

setMethod("predict", signature=c(object="PSTf"), 
	def=function(object, data, group, L=NULL, p1=NULL, output="prob", decomp=FALSE, base=2) {

	mlist <- c("prob", "SIMn", "logloss", "SIMo")

	if (!output %in% mlist) {
		stop(" output must be one of: ", mlist)
	}

	if (object@segmented) {
		sl <- seqlength(data)
		nbgroup <- length(levels(object@group))
		
		if (missing(group)) {
			prob <- matrix(nrow=nrow(data), ncol=nbgroup)
			colnames(prob) <- levels(object@group)
			rownames(prob) <- rownames(data)
			message(" [>] cross prediction for ", nrow(data), " sequence(s) - ", nbgroup, " models")
		} else {
			group <- factor(group)
			if (length(group)!=nrow(data)) {
				stop(" group must contain one value for each sequence in data")
			}
			if (decomp) {
				prob <- matrix(nrow=nrow(data), ncol=max(sl))
				colnames(prob) <- colnames(data)
			} else {
				prob <- matrix(nrow=nrow(data), ncol=1)
				colnames(prob) <- output
			}
			rownames(prob) <- rownames(data)
		}

		for (g in 1:nbgroup) {
			message(" [>] predicting states for group ", g)
			pst <- subtree(object, group=g)

			if (!missing(group)) {
				group.idx <- which(group==levels(group)[g])
				prob.tmp <- predict(pst, data[group.idx,], L=L, p1=p1, output=output, decomp=decomp, base=base)
				prob[group.idx,] <- prob.tmp

			} else {
				prob[,g] <- predict(pst, data, L=L, p1=p1, output=output, decomp=decomp, base=base)
			}
		}
	
		return(prob)
	} else {
		if (any(as.data.frame(data)==attr(data,"nr"))) {
			message(" [>] found missing value in sequence data")
			if (!attr(data, "nr") %in% object@alphabet) {
				message(" [>] PST built without missing value as additional state")
				if (!decomp) {
					message("    [>] sequence probabilities not calculated on the same number of values")
				}
			}
		}

		debut <- Sys.time()

		A <- alphabet(object)
		n <- nrow(data)
		sl <- seqlength(data)

		message(" [>] ", n, " sequence(s) - min/max length: ", min(sl),"/",max(sl))

		if (min(sl)!=max(sl) & output=="prob" & !decomp) {
			message(" [!] sequences have unequal lengths")
		}

		if (is.null(L)) {
			L <- length(object)-1
		} 
		
		if (output=="SIMo") {
			P0 <- predict(object, data, L=0, output="prob", decomp=TRUE)
		}

		message( " [>] max. depth: L=", L)

		message(" [>] extracting node labels from PST")
		context.table <- unlist(lapply(object[1:(L+1)], names))
		pruned.nodes <- unlist(lapply(object[1:(L+1)], pruned.nodes))
		if (any(pruned.nodes)) { 
			message(" [>] removing ", sum(pruned.nodes), " nodes tagged as pruned from node list")
			context.table <- context.table[!pruned.nodes] 
		}

		## getting contexts of max length L for each state
		contexts <- as.vector(context(data, L=L))
		states <- as.vector(as.matrix(data))
		prob <- vector("numeric", length=length(states))
		prob[] <- NA
		unique.contexts <- unique(contexts)

		context.idx <- match(contexts, unique.contexts)

		## taking longest suffix until context found in PST
		message(" [>] searching for context(s) in PST")
		unmatched <- !unique.contexts %in% context.table
		while (sum(unmatched>0)) {
			tmp <- seqdecomp(unique.contexts[unmatched])
			if (ncol(tmp)>1) {
				unique.contexts[unmatched] <- seqconc(tmp[,2:ncol(tmp), drop=FALSE])
				unique.contexts[unique.contexts==""] <- "e"
			} else { 
				unique.contexts[unmatched] <- "e"
			}
	
			## we may have reduced the number of distinct contexts
			tmp <- unique(unique.contexts)
			unique.match <- match(unique.contexts, tmp)
			context.idx <- unique.match[context.idx]

			##
			unique.contexts <- tmp
			unmatched <- !unique.contexts %in% context.table
			## print(unique.contexts[unmatched])
		}
	
		message(" [>] computing prob. - ", nrow(data), " sequence(s) - max. depth=", L, sep="")
		message(" [>] ", length(unique.contexts), " distinct context(s)")
  
		for (p in 1:length(unique.contexts)) {
			context <- unique.contexts[p]
			context.eq <- which(context.idx==p)
      
			if (context=="e") {
				if (!is.null(p1)) {
					tmp <- p1
				} else {
					tmp <- object[[1]][["e"]]@prob
				}
			} else {
				sd <- unlist(strsplit(context, split="-"))
				idxl <- length(sd)+1	

				tmp <- object[[idxl]][[context]]@prob
			}

			tmp <- as.numeric(tmp)

			for (s in 1:length(tmp)) {
        			state.eq <- states[context.eq]==A[s]
				prob[context.eq][state.eq] <- tmp[s]
			}
		}
  
  		prob <- matrix(prob, ncol=ncol(data))
		rownames(prob) <- rownames(data)
		colnames(prob) <- colnames(data)

		if (output=="logloss") {
			prob <- -log(prob, base=base)
		} else if (output=="SIMn") {
			prob <- log(prob, base=base)
		} else if (output=="SIMo") {
			prob <- log(prob/P0, base=base)
		}

		if (!decomp) {
			if (output=="prob") {
				prob <- apply(prob,1, rowProds)
			} else if (output %in% c("logloss", "SIMn")) {
				prob <- rowSums(prob)/rowSums(!is.na(prob))
			} else if (output=="SIMo") {
				prob <- rowSums(prob)
			}

			## if only one sequences we return a matrix as well 
			if (is.null(dim(prob))) { prob <- matrix(prob, nrow=nrow(data)) }
			rownames(prob) <- rownames(data)
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








