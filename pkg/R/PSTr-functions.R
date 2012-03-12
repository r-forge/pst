
## If node not in keep.list it is tagged as pruned
node.keep <- function(x, keep.list) {
	if (!x@path %in% keep.list) {
		x@pruned <- TRUE
	}
	return(x)
}

## Return the label of a parent's node 
node.parent <- function(x) {
	if (x@order==1) { 
		parent <- "e" 
	} else {
		parent <- unlist(strsplit(x@path,"-"))
		parent <- parent[2:length(parent)]
		parent <- paste(parent, collapse="-")
	}
	
	return(parent)
}

node.pdiv <- function(x, plist, A, K, r, N) {
	parent <- plist[[node.parent(x)]]
	glist <- rownames(x@prob)

	for (n in 1:nrow(x@prob)) {
		if (x@leaf[n] & !x@pruned[n]) {
			if (!missing(K)) {
				x@pruned[n] <- !pdiv(x@prob[n,], parent@prob[glist[n],], K=K, N=x@n[n])
			} else if (!missing(r)) {
				x@pruned[n] <- !pdiv(x@prob[n,], parent@prob[glist[n],], r=r)
			}
		}
	}

	return(x)
}


node.prune <- function(x) { 
	x@pruned[] <- TRUE 
	return(x)
}

node.nmin <- function(x,nmin) {
	x@pruned <- x@n < nmin
	return(x)
}


node.leaf <- function(x) { 
	x@leaf <- TRUE 
	return(x)
}

is.leaf <- function(x) { 
	return(x@leaf)
}

is.pruned <- function(x) { 
	return(x@pruned)
}

remove.pruned.group <- function(x) {
	if (any(x@pruned)) {
		idxnp <- !x@pruned
		x@prob <- x@prob[idxnp,, drop=FALSE]
		x@counts <- x@counts[idxnp,, drop=FALSE]
		x@pruned <- x@pruned[idxnp]
		x@leaf <- x@leaf[idxnp]
		x@n <- x@n[idxnp]
	}
	return(x)
}


select.group <- function(x, group) {
	idx <- which(rownames(x@counts)==group)

	if (length(idx)==1) {
		x@prob <- x@prob[idx,, drop=FALSE]
		x@counts <- x@counts[idx,, drop=FALSE]
		x@pruned <- x@pruned[idx]
		x@leaf <- x@leaf[idx]
		x@n <- x@n[idx]
	} else {
		x <- NULL
	}

	return(x)
}



