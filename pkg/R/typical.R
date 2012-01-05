## Searching typical sequences

setMethod("typical", signature=c(object="pstree", seqdata="stslist.s4"), 
	def=function(object, seqdata, l, n, s1, p1, method="pmax", L, ...) {

	A <- alphabet(seqdata)

	prob <- predict(object, seqdata, L=L, p1, decomp=TRUE)

}
)
		


	
