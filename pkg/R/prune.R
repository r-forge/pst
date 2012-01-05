## ==================================
## Pruning Probabilistic Suffix Trees
## ==================================

## Comparing two distributions

pdiv <- function(p1, p2, r, K, N, value=FALSE) {
	if (length(p1)!=length(p2)) {
		stop("p1 and p2 are not of equal lengths")
	} else if (any(p1==0) | any(p2==0)) {
		stop(" [!] one or more probability equals 0")
	} else if (!missing(r)) {
		if (any(p1>=r*p2) || any(p1<=(1/r)*p2)) { div <- TRUE } else { div <- FALSE }

	} else if (!missing(K)) {
		delta <- sum(p1*log(p1/p2))
		if ((delta*N) < K) { div <- FALSE } else { div <- TRUE }
	}

	if (value) {
		return(delta)
	} else {
		return(div)
	}
}


## Comparing two distributions - matrix version

pdiv.m <- function(prob, A, r, K, value=FALSE) {
	as <- length(A)
	p1 <- prob[1:as]
	p2 <- prob[(as+1):(as*2)] 
	N <- prob[(as*2)+1]

	if (length(p1)!=length(p2)) {
		stop("p1 and p2 are not of equal lengths")
	} else if (any(p1==0) | any(p2==0)) {
		stop(" [!] one or more probability equals 0")
	} else if (!missing(r)) {
		if (any(p1>=r*p2) || any(p1<=(1/r)*p2)) { div <- TRUE } else { div <- FALSE }

	} else if (!missing(K)) {
		delta <- sum(p1*log(p1/p2))
		if ((delta*N) < K) { div <- FALSE } else { div <- TRUE }
	}

	if (value) {
		return(delta)
	} else {
		return(div)
	}
}




## =====================================================================
setMethod("prune.old", "PST.list", function(object, nmin, L, r, K, topdown=TRUE, delete=TRUE) {
	
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)

	for (i in length(object):2) {
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
				leaves <- which(nodes$leaf & !nodes$pruned)
				for (j in leaves) {
					p1 <- nodes[j, A]
					p2 <- parents[nodes[j, "parent"], A]
					div <- pdiv(p1, p2, r=r, K=K, N=nodes[j, "n"])
					if (!div) { nodes[j, "pruned"] <- TRUE }
				}	

			}
		}

		pruned <- which(nodes$pruned)
		message(" [>] ", length(pruned), " nodes pruned at L=", i-1)

		if (delete & length(pruned)>0) {
			nodes <- nodes[-pruned,]
			## Nodes having no more childrens set as leaves
			newleaves <- !rownames(parents) %in% nodes$parent
			parents[newleaves, "leaf"] <- TRUE
		}
		object[[i]] <- nodes
		object[[i-1]] <- parents

	}

	object <- new("PST.list", object, alphabet=A, cpal=cpal, labels=labels)

	return(object)
}
)


## =====================================================================
setMethod("prune", "PST.list", function(object, nmin, L, r, K, topdown=TRUE, delete=TRUE) {
	
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)

	for (i in length(object):2) {
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
		message(" [>] L=",i-1,", ", nrow(nodes)," nodes / " , length(pruned), " pruned")

		if (delete & length(pruned)>0) {
			nodes <- nodes[-pruned,]
			## Nodes having no more childrens set as leaves
			newleaves <- !rownames(parents) %in% nodes$parent
			parents[newleaves, "leaf"] <- TRUE
		}
		if (nrow(nodes)==0) {
			object <- object[-i]
		} else {
			object[[i]] <- nodes
		}
		object[[i-1]] <- parents

	}

	object <- new("PST.list", object, alphabet=A, cpal=cpal, labels=labels)

	return(object)
}
)

