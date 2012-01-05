## Impute missign values in sequence data using a PST

impute <- function(pstree, seqdata, method="pmax") {
	
	ipdata <- as.data.frame(seqdata)
	L <- summary(pstree)@depth
		
	A <- alphabet(seqdata)
	if (!all.equal(alphabet(pstree), alphabet(seqdata))) {
		stop(" [!] pstree and seqdata do not have same alphabet")
	}

	nr <- attr(seqdata, "nr")
	sl <- ncol(seqdata)

	ismiss <- matrix(nrow=nrow(ipdata), ncol=ncol(ipdata))
	hasmiss <- vector("logical", length=nrow(seqdata))

	for (i in 1:sl) {
		ismiss[,i] <- ipdata[,i]==nr
	}

	nbmiss <- rowSums(ismiss)
	hasmiss <- nbmiss>0

	message(" [>] found ", sum(hasmiss), " sequence(s) with missing values")
	message(" [>] ", sum(nbmiss), " missing states ")

	for (i in which(hasmiss)) {
		for (l in 1:sl) {
			if (ipdata[i,l]==nr) {
				if (l==1) {
					prefix <- "e"
				} else {
					prefix <- seqconc(ipdata[i, max(1, l-L):(l-1)])
				}

				p <- suppressMessages(query(pstree, prefix))

				## Imputation
				if (method=="pmax") {
					ipdata[i,l] <- A[which.max(p)]
				} else {
					ipdata[i,l] <- sample(A, size=1, prob=p)
				}
			}
		}
	}

	ipdata <- seqdef(ipdata, alphabet=A, missing=nr, labels=stlab(seqdata), cpal=cpal(seqdata), 
		weights=attr(seqdata, "weights"))
	return(ipdata)		

}
		

	
