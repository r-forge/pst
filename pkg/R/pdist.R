## Probabilistic distance

setMethod("pdist", signature=c("PSTf", "PSTf"), function (x, y, method="cp", l, symetric=FALSE, ns=5000, ...) {
	
	if (method=="cp") {
		gsx <- generate(x, l=l, n=ns, method="prob")
		gsx.px <- predict(x, gsx)
		gsx.py <- predict(y, gsx)
		dxy <- log(gsx.px/gsx.py)/l
	
		if (symetric) {
			gsy <- generate(y, l=l, n=ns, method="prob")
			gsy.py <- predict(y, gsy)
			gsy.px <- predict(x, gsy)
			dyx <- log(gsy.py/gsy.px)/l
			res <- (dxy+dyx) / 2
		} else {
			res <- dxy
		}
	}

	return(res)

}
)
