
setMethod("logLik", "PSTf", function(object) {
	seqprob <- predict(object, object@data)
	res <- sum(log(seqprob))

	pstsum <- summary(object)

	class(res) <- "logLik"
	attr(res, "df") <- pstsum@freepar

	return(res)
}
)
 
 
