## 

setGeneric(
      name="cmine",
	def=function(object, ...)
	standardGeneric("cmine")
)

setGeneric("cprob", 
	def=function(object, L, ...) 
	standardGeneric("cprob")
)

setGeneric("generate", 
	def=function(object, l, n, s1, p1, method, L, ...) 
	standardGeneric("generate")
)

setGeneric(
      name="impute",
	def=function(object, data, ...)
	standardGeneric("impute")
)

setGeneric(
      name="pmine",
	def=function(object, data, ...)
	standardGeneric("pmine")
)

setGeneric(
      name="ppplot",
	def=function(object, path, state, r, K,  cex.plot=1, seqscale=0.3, node.type="circle", pscale=seqscale/2, 
		pruned.col="red", div.col="green", ...)
	standardGeneric("ppplot")
)


setGeneric(
      name="prune",
	def=function(object, nmin, L, r, K, keep, drop, topdown=TRUE, delete=TRUE)
	standardGeneric("prune")
)

setGeneric(
      name="pstree",
	def=function(x, group, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree")
)

setGeneric("query", 
	def=function(object, context, state, output="prob", exact=FALSE, ...)
	standardGeneric("query")
)

setGeneric(
      name="subtree",
	def=function(object, group)
	standardGeneric("subtree")
)

setGeneric(name="tune",
	def=function(object, K, criterion="AIC", output="PST")
	standardGeneric("tune")
)



