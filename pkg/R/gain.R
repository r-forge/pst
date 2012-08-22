## Gain

setMethod("gain", signature=c(object="PSTf"), function(object, node, parent, gain.f=pdiv, par) {
	node <- query(object, node, exact=TRUE, output="all")
	parent <- query(object, node.parent(node), output="all")

	seglist <- rownames(node@prob)

	res <- vector(mode="logical", length=length(seglist))
	names(res) <- seglist

	for (n in 1:length(seglist)) {
		if ("C" %in% names(par)) {
			res[n] <- gain.f(node@prob[n,], parent@prob[seqglist[n],], C=par[["C"]], N=node@n[n])
		} else if ("r" %in% names(par)) {
			res[n] <- gain.f(node@prob[n,], parent@prob[seglist[n],], r=par[["r"]])
		}
	}

	return(res)
}
)




