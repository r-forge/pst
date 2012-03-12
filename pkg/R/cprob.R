## Conditional probabilities

setMethod("cprob", signature=c(object="stslist"), 
	def=function(object, L, prefix, nmin=1, prob=TRUE, weighted=TRUE, with.missing=FALSE) {

	statl <- alphabet(object)
	nr <- attr(object,"nr")
	if (with.missing) { statl <- c(statl, nr) }
	void <- attr(object, "void")

	debut <- Sys.time()

	## Weights
	weights <- attr(object, "weights")
	
	if (!weighted || is.null(weights)) {
		weights <- rep(1, nrow(object))
	}

	## 
	nbetat <- length(statl)
	seql <- ncol(object)
	nbseq <- nrow(object)

	## Turning object into a matrix
	object <- as.matrix(object)

	if (!missing(prefix)) {
		tmp <- seqdecomp(prefix)
		if (any(!tmp %in% statl) & prefix!="e") {
			stop(" [!] one or more symbol in prefix not in alphabet")
		}
		L <- ncol(tmp)
	} 

	if (L>(seql-1)) { stop(" [!] sequence length <= L")}

	message(" [>] ", nbseq, " sequences, max. length=", seql)

	if (L==0 || (!missing(prefix) && prefix=="e")) {
		prefix.list <- "e"
		message(" [>] computing prob., L=", L," ...")
		## tmat needs to be a matrix ...
		tmat <- matrix(0, nrow=1, ncol=nbetat, dimnames=list("e",statl))
		n <- matrix(0, nrow=1, ncol=1, dimnames=list("e","n"))

		tmat[1,] <- xtabs(rep(weights, seql) ~ factor(object, levels=statl))
		tmp <- xtabs(rep(1, seql*nbseq) ~ factor(object, levels=statl))
		n[1,] <- sum(tmp)
	}
	else {
		vlength <- nbseq*(seql-L)
		## prefixes <- vector("character", length=vlength)
		prefixes <- matrix(nrow=nbseq, ncol=ncol(object)-L)

		## inflating weight vector to match number of prefixes
		weights <- rep(weights, ncol(object)-L)

		for (sl in (L+1):seql) {
			prefixes[, sl-L] <- object[, (sl-L)]
			if (L>1) {
				for (c in (L-1):1) {
					prefixes[, sl-L] <- paste(prefixes[, sl-L], object[, (sl-c)], sep="-")
				}
			}	
		}
		states <- factor(object[,(L+1):sl], levels=statl)
		prefixes <- as.vector(prefixes)

		if (!missing(prefix)) {
			sel <- prefixes==prefix
			prefix.list <- prefix
			prefixes <- prefixes[sel]
			states <- states[sel]
			weights <- weights[sel]
		} 
		else {
			prefix.list <- sort(unique(prefixes))
			if (nmin>1) {
				prefix.freq <- table(prefixes)
				del.nmin <- prefix.freq<nmin	
				if (sum(del.nmin)>0) {
					message(" [>] removing ", sum(del.nmin), " prefix(es) where n<", nmin) 
					prefix.list <- prefix.list[!del.nmin]
					sel <- prefixes %in% prefix.list
					prefixes <- prefixes[sel]
					states <- states[sel]
					weights <- weights[sel]
				}
			}
		}

		nbprefix <- length(prefix.list)
	
		if (nbprefix==0) {
			message(" [>] no remaining prefix, prob. matrix has 0 rows") 
			tmat <- matrix(nrow=0, ncol=nbetat)
			n <- matrix(nrow=0, ncol=1)
		} else {
			message(" [>] computing prob., L=", L, ", ", nbprefix, " distinct prefix(es)") 
			tmat <- xtabs(weights ~ prefixes+states)
			n <- rowSums(xtabs(rep(1, length(prefixes)) ~ prefixes+states))
			n <- as.data.frame(n, ncol=1)
			tmat <- as.data.frame(tmat[])

			## eliminating patterns containing missing states if with.missing=FALSE
			if (!with.missing) { 
				## if nr is a 'grep' special character 
				if (nr %in% c("?", "*")) { nr <- paste("\\",nr, sep="") }
				hasMiss <- grep(nr, rownames(tmat))
				if (length(hasMiss)>0) { 
					message(" [>] removing ", length(hasMiss), " prefix(es) with missing values") 
					tmat <- tmat[-hasMiss, ,drop=FALSE]
					n <- n[-hasMiss, ,drop=FALSE]
	
				}
			}
		}
	}

	if (prob) {
		pfreq <- rowSums(tmat[, 1:nbetat, drop=FALSE])
		tmat[, 1:nbetat] <- tmat[, 1:nbetat]/pfreq
	}

	## Ensure that tmat and n are matrices for merging them

	tmat <- merge(tmat, n, by=0)
	prnames <- tmat[,1] 
	tmat <- as.matrix(tmat[,2:ncol(tmat)], ncol=length(statl)+1, nrow=nrow(tmat))
	rownames(tmat) <- as.character(prnames) 
	colnames(tmat) <- c(statl, "n")

	fin <- Sys.time()
	message(" [>] total time: ", format(round(fin-debut, 3)))

	return(tmat)
}
)

