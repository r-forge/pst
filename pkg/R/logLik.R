## Retunrs the log likelihood of a VLMC model

setMethod("logLik", "PSTf", function(object) {

	n <- nrow(object@data)
	sl <- seqlength(object@data)

	message(" [>] model fitted to ", n, " sequence(s) - ", nobs(object), " symbols")
	message(" [>] computing sequence(s) likelihood ...", appendLF=FALSE)

	pstsum <- summary(object)

	debut <- Sys.time()
	lik <- suppressMessages(predict(object, object@data, object@cdata, group=object@group))
	res <- sum(log(lik))

	fin <- Sys.time()
	message(" (", format(round(fin-debut, 3)), ")")

	class(res) <- "logLik"
	attr(res, "df") <- pstsum@freepar

	return(res)
}
)
 
 
