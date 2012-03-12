## 

setGeneric("cprob", 
	def=function(object, L, ...) 
	standardGeneric("cprob")
)

setGeneric("generate", 
	def=function(object, l, n, s1, p1, method, L, ...) 
	standardGeneric("generate")
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
      name="subtree",
	def=function(object, group)
	standardGeneric("subtree")
)


setGeneric(
      name="pstpos",
	def=function(object, pos)
	standardGeneric("pstpos")
)


setGeneric(
      name="pstree.rec",
	def=function(object, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, method="A", verbose=FALSE)
	standardGeneric("pstree.rec")
)

setGeneric(
      name="pstree.v2",
	def=function(object, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, method="A", verbose=FALSE)
	standardGeneric("pstree.v2")
)


setGeneric("query", 
	def=function(object, string, state, output="prob", exact=FALSE, ...)
	standardGeneric("query")
)


setGeneric("sim", 
	def=function(object, seqdata, L, ...) 
	standardGeneric("sim")
)


setGeneric("typical", 
	def=function(object, seqdata, l, n, s1, p1, method, L, ...) 
	standardGeneric("typical")
)


setGeneric(name="tune",
	def=function(object, K, criterion="AIC", output="PST")
	standardGeneric("tune")
)

## Multichannel
setGeneric("predict.mc", 
	def=function(object, x, y, L=NULL, p1=NULL, decomp=FALSE, log=FALSE, base=2, norm=FALSE) 
	standardGeneric("predict.mc")
)

setGeneric(
      name="pstree.mc",
	def=function(x, y, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree.mc")
)

## Time varying
setGeneric(
      name="pstree.tv",
	def=function(x, y, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree.tv")
)

## Grouped
setGeneric(
      name="pstree",
	def=function(x, group, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree")
)


