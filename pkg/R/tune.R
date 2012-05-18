##

setMethod("tune", signature=c(object="PSTf"), 
	def=function(object, C, criterion="AICc", output="PST") {

	if (!inherits(object, "PSTf") || missing(object)) {
		stop(" [!] please provide the name of a valid PST object", call.=FALSE)
	}

	debut <- Sys.time()

	nbmod <- length(C)

	nodes.comp <- vector(mode="integer", length=nbmod) 
	leaves.comp <- vector(mode="integer", length=nbmod) 
	freepar.comp <- vector(mode="integer", length=nbmod) 
	AIC.comp <- vector(mode="numeric", length=nbmod)
	AIC.comp[] <- NA

	C <- sort(C)

	for (i in 1:nbmod) {
		suppressMessages(pst <- prune(object, C=C[i]))
		pst.sum <- summary(pst)
		nodes.comp[i] <- pst.sum@nodes
		leaves.comp[i] <- pst.sum@leaves
		freepar.comp[i] <- pst.sum@freepar

		suppressMessages(pst.AIC <- AIC(pst))

		if (criterion=="AICc") {
			pst.AIC <- pst.AIC + ((2*pst.sum@freepar*(pst.sum@freepar+1))/(pst.sum@ns-pst.sum@freepar-1))
		}

		AIC.comp[i] <- pst.AIC
		
		message(" [>] model ",i, ": ", criterion,"=", round(pst.AIC,2), " (C=", round(C[i],2),")")
	
		if (pst.AIC==min(AIC.comp, na.rm=TRUE)) {
			id.best <- i
			pst.best <- pst
		}
	}

	best.sum <- summary(pst.best)
	
	message(" [>] model ", id.best, " selected : ", criterion, "=", round(AIC.comp[id.best],2) , " (C=", round(C[id.best],2), ")")
	message(" [>] ", best.sum@nodes, " nodes, ", best.sum@leaves, " leaves, ", best.sum@freepar, " free parameters")
	
	if (output=="PST") {
		return(pst.best)
	} else if (output=="stats") {
		selected <- rep(" ", nbmod)
		selected[id.best] <- "*"
		tmp.comp <- AIC.comp-AIC.comp[id.best]
		selected[tmp.comp>0 & tmp.comp<=2] <- "**"
		selected[tmp.comp>2 & tmp.comp<10] <- "***"

		res <- data.frame(Model=1:length(C), C=C, Nodes=nodes.comp, Leaves=leaves.comp, Freepar=freepar.comp, AIC.comp, 			Selected=selected)
		names(res)[6] <- criterion
		
		return(res)
	}
}
)
