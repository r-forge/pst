## 

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
	def=function(x, L, nmin=1, ymin, weighted=TRUE, with.missing=FALSE, ...)
	standardGeneric("pstree")
)

setGeneric(
      name="prune",
	def=function(object, nmin, L, r, K, topdown=TRUE, delete=TRUE)
	standardGeneric("prune")
)

setGeneric(name="tune",
	def=function(object, K, criterion="AICc")
	standardGeneric("tune")
)



