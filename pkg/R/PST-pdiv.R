## Comparing two distributions

pdiv <- function(p1, p2, r, K, N, value=FALSE) {
	if (length(p1)!=length(p2)) {
		stop("p1 and p2 are not of equal lengths")
	} else if (any(p1==0) | any(p2==0)) {
		stop(" [!] one or more probability equals 0")
	} else if (!missing(r)) {
		if (any(p1>=r*p2) || any(p1<=(1/r)*p2)) { div <- TRUE } else { div <- FALSE }

	} else if (!missing(K)) {
		delta <- sum(p1*log(p1/p2))
		if ((delta*N) < K) { div <- FALSE } else { div <- TRUE }
	}

	if (value) {
		return(delta)
	} else {
		return(div)
	}
}


## Comparing two distributions - matrix version

pdiv.m <- function(prob, A, r, K, value=FALSE) {
	as <- length(A)
	p1 <- prob[1:as]
	p2 <- prob[(as+1):(as*2)] 
	N <- prob[(as*2)+1]

	if (length(p1)!=length(p2)) {
		stop("p1 and p2 are not of equal lengths")
	} else if (any(p1==0) | any(p2==0)) {
		stop(" [!] one or more probability equals 0")
	} else if (!missing(r)) {
		if (any(p1>=r*p2) || any(p1<=(1/r)*p2)) { div <- TRUE } else { div <- FALSE }

	} else if (!missing(K)) {
		delta <- sum(p1*log(p1/p2))
		if ((delta*N) < K) { div <- FALSE } else { div <- TRUE }
	}

	if (value) {
		return(delta)
	} else {
		return(div)
	}
}

