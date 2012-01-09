
## turning S3 predict function in to S4 
## setGeneric("predict", 
##	def=function(pstree, seqdata, k, rev, ...) 
##	standardGeneric("predict")
## )

setGeneric("sim", 
	def=function(object, seqdata, L, ...) 
	standardGeneric("sim")
)

setGeneric("query", 
	def=function(object, string, state, output="prob", exact=FALSE)
	standardGeneric("query")
)

setGeneric("generate", 
	def=function(object, l, n, s1, p1, method, L, ...) 
	standardGeneric("generate")
)


setGeneric(
      name="pstree",
	def=function(object, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree")
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


setGeneric(
      name="prune",
	def=function(object, nmin, L, r, K, topdown=TRUE, delete=TRUE)
	standardGeneric("prune")
)





