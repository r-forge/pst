## Generating artifical sequences

setMethod("generate", signature=c(object="PST.list"), 
	def=function(object, l, n=1, s1, p1, method="pmax", L, ...) {

	A <- alphabet(object)
	if (missing(L)) {
		sum <- summary(object)
		L <- sum@depth
	}

	if (!missing(s1)) {
		n <- length(s1)
		message(" [>] user provided first position state(s)")
	} else if (!missing(p1)) {
		if (sum(p1)==1 & length(p1)==length(A)) {
			message(" [>] user provided first position probabilities")
		} else {
			stop("First position probabilities must sum to 1 and be of length |A|")
		}
	}

	seq <- matrix(nrow=n, ncol=l)
	
	
	for (i in 1:n) {
		s <- 1

		if (!missing(s1)) {
			if (s1[i] %in% A) {
				seq[i, 1] <- s1[i]
				s <- 2
			} else {
				stop("s1 must be a state of the alphabet")
			}
		}
		
		for (j in s:l) {
			if (j==1) {
				if (missing(p1)) {
					p <- suppressMessages(query(object, "e"))
				} else {
					p <- p1
				}
			} else {
				prefix <- paste(seq[i, max(1, j-L):(j-1)], collapse="-")
				p <- suppressMessages(query(object, prefix))
			}

			if (method=="pmax") {
				seq[i,j] <- A[which.max(p)]
			} else if (method=="prob") {
				seq[i,j] <- sample(A, 1, p, replace=TRUE)
			}
		}
	}

	seq <- seqdef(seq, alphabet=A, cpal=cpal(object))

	return(seq)
}
)

