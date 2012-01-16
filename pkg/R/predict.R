## Computing sequence probability

setMethod("predict", signature=c(object="PSTf"), 
	def=function(object, seqdata, L=NULL, p1=NULL, decomp=FALSE, log=FALSE, base=2, norm=FALSE) {


	if (!inherits(object, "PSTf") || missing(object)) {
		stop(" [!] please provide the name of a valid PST object", call.=FALSE)
	}

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

	if (min(sl)!=max(sl) & !norm) {
		message(" [!] sequences have unequal lengths, use 'norm=TRUE' to normalize prob.")
	}

	if (is.null(L)) {
		L <- length(object)-1
	}

	message( " [>] max. depth: L=", L)

	message(" [>] extracting node labels from PST")
	prefix.table <- unlist(lapply(object[1:(L+1)], rownames))

	## getting prefixes of max length L for each state
	prefixes <- as.vector(prefix(seqdata, L=L))
	states <- as.vector(as.matrix(seqdata))
	prob <- vector("numeric", length=length(states))
	prob[] <- NA
	unique.prefixes <- unique(prefixes)

	prefix.idx <- match(prefixes, unique.prefixes)

	## taking longest suffix until prefix found in PST
	message(" [>] searching for prefix(es) in PST")
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
	}
	
	message(" [>] computing prob., ", nrow(seqdata), " sequences, max. depth=", L, sep="")
	message(" [>] ", length(unique.prefixes), " distinct prefixes")
  
	for (p in 1:length(unique.prefixes)) {
		prefix <- unique.prefixes[p]
		prefix.eq <- which(prefix.idx==p)
      
			if (prefix=="e") {
				if (!is.null(p1)) {
					tmp <- p1
				} else {
					tmp <- object[[1]][, A]
				}
			} else {
				sd <- unlist(strsplit(prefix, split="-"))
				idxl <- length(sd)+1	

				tmp <- object[[idxl]][prefix, A]
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

	if (!decomp) {
		prob <- apply(prob,1, rowProds)
		## if only one sequences we return a matrix as well 
		if (is.null(dim(prob))) { prob <- matrix(prob, nrow=nrow(seqdata)) }
		if (norm) {
			prob <- exp(log(prob, base=base)/sl)
		}
		rownames(prob) <- rownames(seqdata)
		colnames(prob) <- if (norm) "p.norm" else "p"
	}

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(prob)
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








