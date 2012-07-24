## ==================================
## Pruning Probabilistic Suffix Trees
## ==================================

setMethod("prune", "PSTf", function(object, nmin, L, r, C, keep, drop, state, delete=TRUE) {
	
	data <- object@data
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)
	segmented <- object@segmented
	group <- object@group

	if (!missing(keep)) {
		if (class(object)=="PSTf.mc") {
			c.A <- object@c.alphabet
		} else {
			c.A <- object@alphabet
		}

		if (!inherits(keep,"stslist")) {
			keep <- seqdef(keep, alphabet=c.A, nr="#")
		}
		keep.sl <- seqlength(keep)
	}

	object <- as(object, "list")
	has.child <- NULL

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
					keep.tmp <- keep[keep.sl==i-1,, drop=FALSE]
					keep.list <- seqconc(keep.tmp)
					nodes <- lapply(nodes, node.keep, keep.list, has.child)
				}
			}
			if (!missing(state)) {
				state.tmp <- seqdecomp(names(nodes))
				state.tmp <- which(rowSums(state.tmp==state)>0)
				nodes[state.tmp] <- lapply(nodes[state.tmp], node.prune)
			}
			if (!missing(nmin)) {
				nodes <- lapply(nodes, node.nmin, nmin)
			}
			if (!missing(C)) {
				nodes <- lapply(nodes, node.pdiv, plist=parents, A=A, C=C, has.child=has.child)
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
		} else if (sum(pruned)>0) {
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

