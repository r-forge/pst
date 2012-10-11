## 

setGeneric(
      name="cmine",
	def=function(object, ...)
	standardGeneric("cmine")
)

setGeneric(name="cplot",
	def=function(object, context, ...)
	standardGeneric("cplot")
)

setGeneric("cprob", 
	def=function(object, L, ...) 
	standardGeneric("cprob")
)

setGeneric("gain", 
	def=function(object, ...) 
	standardGeneric("gain")
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
      name="nodenames",
	def=function(object, ...)
	standardGeneric("nodenames")
)

setGeneric(
      name="pmine",
	def=function(object, data, ...)
	standardGeneric("pmine")
)

setGeneric(
      name="ppplot",
	def=function(object, path, state, r, C,  cex.plot=1, seqscale=0.3, node.type="circle", pscale=seqscale/2, 
		pruned.col="red", div.col="green", ...)
	standardGeneric("ppplot")
)

setGeneric(
      name="pqplot",
	def=function(object, data, ...)
	standardGeneric("pqplot")
)


setGeneric(
      name="prune",
	def=function(object, ...)
	standardGeneric("prune")
)

setGeneric(
      name="pstree",
	def=function(x, group, L, ...)
	standardGeneric("pstree")
)

setGeneric("query", 
	def=function(object, context, state, output="prob", exact=FALSE, ...)
	standardGeneric("query")
)

setGeneric(
      name="subtree",
	def=function(object, ...)
	standardGeneric("subtree")
)

setGeneric(name="tune",
	def=function(object, ...)
	standardGeneric("tune")
)



