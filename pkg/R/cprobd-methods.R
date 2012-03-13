

setMethod("show", "cprobd", function(object) {

	cat(" [>] context:", object@context, "\n")
	show(object@.Data)
}
)


setMethod("round", "cprobd", function(x, digits=0) {

	x@.Data <- round(x@.Data, digits=digits)
	return(x)
}
)

