## ==================================
## Pruning Probabilistic Suffix Trees
## ==================================

setMethod("prune", "PSTf", function(object, nmin, L, r, K, topdown=TRUE, delete=TRUE) {
	
	data <- object@data
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)
	grouped <- object@grouped
	group <- object@group

	object <- as(object, "list")
	has.child <- NULL
	## if (missing(L)) { L <- length(object)-1 }

	for (i in length(object):2) {
		if (grouped) {
			for (group in 1:length(object[[1]])) {
				message(" [>] pruning nodes for group ", group)

				nodes <- object[[i]][[group]]
				parents <- object[[i-1]][[group]]

				if (any(!nodes$parent %in% rownames(parents))) {
					nip <- nodes$parent[!nodes$parent %in% rownames(parents)]
					for (noderror in 1:length(nip)) {
						message(nip[noderror], " not in parent nodes")
					}
				}  

				nodes$pruned <- FALSE

				if (!missing(L) && i>(L+1) ) {
					nodes$pruned <- TRUE
				} else {
					if (!missing(nmin)) {
						nmin.prune <- nodes$n < nmin
						nodes[nmin.prune, "pruned"] <- TRUE
					}

					if (!missing(K) | !missing(r)) {
						leaves <- which(nodes$leaf & !nodes$pruned)
						if (length(leaves)>0) {
							p1 <- nodes[leaves,A]
							N <- nodes[leaves, "n"]
							p2 <- parents[nodes$parent[leaves], A]
					
							tmp <- cbind(p1, p2, N)
							if (!missing(K)) {
								div <- apply(tmp,1, pdiv.m, A=A, K=K)
							} else if (!missing(r)) {
								div <- apply(tmp,1, pdiv.m, A=A, r=r)
							}

							nodes[leaves, "pruned"] <- !div
						}
					}
				}

				pruned <- which(nodes$pruned)
				message("     [>] L=",i-1,", ", length(pruned),"/", nrow(nodes), " node(s) pruned")

				if (delete & length(pruned)>0) {
					nodes <- nodes[-pruned,]
					## Nodes having no more childrens set as leaves
					newleaves <- !rownames(parents) %in% nodes$parent
					parents[newleaves, "leaf"] <- TRUE
				}

				object[[i]][[group]] <- nodes
				object[[i-1]][[group]] <- parents
			}
		} else {
			nodes <- object[[i]]
			parents <- object[[i-1]]
			nodes$pruned <- FALSE

			if (!missing(L) && i>(L+1) ) {
				nodes$pruned <- TRUE
			} else {
				if (!missing(nmin)) {
					nmin.prune <- nodes$n < nmin
					nodes[nmin.prune, "pruned"] <- TRUE
				}

				if (!missing(K) | !missing(r)) {
					leaves <- which((nodes$leaf & !nodes$pruned) & !rownames(nodes) %in% has.child)
					if (length(leaves)>0) {
						p1 <- nodes[leaves,A]
						N <- nodes[leaves, "n"]
						p2 <- parents[nodes$parent[leaves], A]

						tmp <- cbind(p1, p2, N)
						if (!missing(K)) {
							div <- apply(tmp,1, pdiv.m, A=A, K=K)
						} else if (!missing(r)) {
							div <- apply(tmp,1, pdiv.m, A=A, r=r)
						}

						nodes[leaves, "pruned"] <- !div
					}
				}
			}

			pruned <- which(nodes$pruned)
			message(" [>] L=",i-1,", ", length(pruned),"/", nrow(nodes), " node(s) pruned")

			if (delete & length(pruned)>0) {
				nodes <- nodes[-pruned,]
				## Nodes having no more childrens set as leaves
				newleaves <- !rownames(parents) %in% nodes$parent
				parents[newleaves, "leaf"] <- TRUE
			} else {
				has.child <- object[[i]]$parent[!pruned]
			}

			if (nrow(nodes)==0) {
				object <- object[-i]
			} else {
				object[[i]] <- nodes
			}
			object[[i-1]] <- parents
		}
	}

	object <- new("PSTf", object, data=data, alphabet=A, cpal=cpal, labels=labels, grouped=grouped, group=group)

	return(object)
}
)

