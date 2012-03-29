## ==================================
## Pruning Probabilistic Suffix Trees
## ==================================

setMethod("prune", "PSTf", function(object, nmin, L, r, K, keep, drop, topdown=TRUE, delete=TRUE) {
	
	data <- object@data
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)
	segmented <- object@segmented
	group <- object@group

	object <- as(object, "list")
	has.child <- NULL
	## if (missing(L)) { L <- length(object)-1 }

	if (!missing(keep)) {
		if (!inherits(keep,"stslist")) {
			keep <- seqdef(keep, alphabet=A)
		}
		keep.sl <- seqlength(keep)
	}

	for (i in length(object):2) {
		nodes <- object[[i]]
		parents <- object[[i-1]]
		## nodes <- lapply(nodes, function(x) {x@pruned[] <- FALSE; x})
		nbnodes <- unlist(lapply(nodes, function(x) { sum(!x@pruned) }))

		if (!missing(L) && i>(L+1) ) {
			nodes <- lapply(nodes, node.prune)
		} else {
			if (!missing(keep)) {
				if ( (i-1)>max(keep.sl) ) {
					nodes <- lapply(nodes, node.prune)
				} else {
					keep.list <- NULL
					for (z in max((i-1), min(keep.sl)):max(keep.sl)) {
						keep.tmp <- keep[keep.sl==z,, drop=FALSE]
						keep.list <- c(keep.list, seqconc(keep.tmp[,(z-i+2):z]))
					}
					keep.list <- unique(keep.list)
					nodes <- lapply(nodes, node.keep, keep.list)
				}
			}
			if (!missing(nmin)) {
				nodes <- lapply(nodes, node.nmin, nmin)
			}
			if (!missing(K)) {
				nodes <- lapply(nodes, node.pdiv, plist=parents, A=A, K=K, has.child=has.child)
			} else if (!missing(r)) {
				nodes <- lapply(nodes, node.pdiv, plist=parents, A=A, r=r, has.child=has.child)
			}
		}

		pruned <- unlist(lapply(nodes, function(x) {sum(x@pruned)}))
		plabel <- if (segmented) { " node segment(s) pruned" } else { " node(s) pruned" }

		message(" [>] L=",i-1,", ", sum(pruned),"/", sum(nbnodes), " node(s) pruned")

		if (delete & sum(pruned)>0) {
			if (segmented) {
				nodes <- lapply(nodes, remove.pruned.group)
				pruned.id <- which(unlist(lapply(nodes, function(x) {nrow(x@prob)==0})))
			} else {
				pruned.id <- which(pruned==1)
			}
			nodes <- nodes[-pruned.id]
			## Nodes having no more childrens set as leaves
			pnames <- unlist(lapply(nodes, node.parent))
			parents <- lapply(parents, function(x, pnames) {if (!x@path %in% pnames) {x@leaf[] <- TRUE}; x}, pnames)
		} else {
			if (segmented) {
				stop(" pruning with delete=FALSE not implemented for segmented PST")
			} else {
				unpruned.id <- which(pruned==0)
				has.child <- unlist(lapply(nodes[unpruned.id], node.parent))
			}
		}

		if (length(nodes)==0) {
			object <- object[-i]
		} else {
			object[[i]] <- nodes
		}
		object[[i-1]] <- parents
	}

	object <- new("PSTf", object, data=data, alphabet=A, cpal=cpal, labels=labels, segmented=segmented, group=group)

	return(object)
}
)

