## Computing sequence probability

setMethod("sim", signature=c(object="PST.list"), 
	def=function(object, seqdata, L=NULL, p1=NULL, base=2) {


	if (!inherits(object, "PST.list") || missing(object)) {
		stop(" [!] please provide the name of a valid PST object", call.=FALSE)
	}

	debut <- Sys.time()

	prob <- predict(object, seqdata, L=L, p1=p1, decomp=TRUE)
	nbpred <- rowSums(!is.na(prob))
	
	res <- rowSums(log(prob, base=base), na.rm=TRUE)/nbpred

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(res)
}
)









