##

setMethod("tune", signature=c(object="PSTf"), 
	def=function(object, K, criterion="AICc") {

	if (!inherits(object, "PSTf") || missing(object)) {
		stop(" [!] please provide the name of a valid PST object", call.=FALSE)
	}

	debut <- Sys.time()

	AIC.comp <- NULL

	K <- sort(K)

	for (i in 1:length(K)) {
		suppressMessages(pst <- prune(object, K=K[i]))
		suppressMessages(pst.AIC <- AIC(pst))
		if (criterion=="AICc") {
			pst.sum <- summary(pst)
			pst.AIC <- pst.AIC + ((2*pst.sum@freepar*(pst.sum@freepar+1))/(pst.sum@ns-pst.sum@freepar-1))
		}

		AIC.comp <- c(AIC.comp, pst.AIC)
		message(" [>] model ",i, ": ", criterion,"=", round(pst.AIC,2), " (K=", round(K[i],2),")")
	
		if (pst.AIC==min(AIC.comp)) {
			id.best <- i
			pst.best <- pst
		}
	}

	best.sum <- summary(pst.best)
	
	message(" [>] model ", id.best, " selected : ", criterion, "=", round(AIC.comp[id.best],2) , " (K=", round(K[id.best],2), ")")
	message(" [>] ", best.sum@nodes, " nodes, ", best.sum@leaves, " leaves, ", best.sum@freepar, " free parameters")
	
	return(pst.best)
}
)
