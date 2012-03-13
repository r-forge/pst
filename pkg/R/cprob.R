## Conditional probabilities

setMethod("cprob", signature=c(object="stslist"), 
	def=function(object, L, context, nmin=1, prob=TRUE, weighted=TRUE, with.missing=FALSE) {

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

	if (!missing(context)) {
		tmp <- seqdecomp(context)
		if (any(!tmp %in% statl) & context!="e") {
			stop(" [!] one or more symbol in context not found in alphabet")
		}
		L <- ncol(tmp)
	} 

	if (L>(seql-1)) { stop(" [!] sequence length <= L")}

	message(" [>] ", nbseq, " sequence(s), max. length=", seql)

	if (L==0 || (!missing(context) && context=="e")) {
		context.list <- "e"
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
		## contextes <- vector("character", length=vlength)
		contextes <- matrix(nrow=nbseq, ncol=ncol(object)-L)

		## inflating weight vector to match number of contextes
		weights <- rep(weights, ncol(object)-L)

		for (sl in (L+1):seql) {
			contextes[, sl-L] <- object[, (sl-L)]
			if (L>1) {
				for (c in (L-1):1) {
					contextes[, sl-L] <- paste(contextes[, sl-L], object[, (sl-c)], sep="-")
				}
			}	
		}
		states <- factor(object[,(L+1):sl], levels=statl)
		contextes <- as.vector(contextes)

		if (!missing(context)) {
			sel <- contextes==context
			context.list <- context
			contextes <- contextes[sel]
			states <- states[sel]
			weights <- weights[sel]
		} 
		else {
			context.list <- sort(unique(contextes))
			if (nmin>1) {
				context.freq <- table(contextes)
				del.nmin <- context.freq<nmin	
				if (sum(del.nmin)>0) {
					message(" [>] removing ", sum(del.nmin), " context(s) where n<", nmin) 
					context.list <- context.list[!del.nmin]
					sel <- contextes %in% context.list
					contextes <- contextes[sel]
					states <- states[sel]
					weights <- weights[sel]
				}
			}
		}

		nbcontext <- length(context.list)
	
		if (nbcontext==0) {
			message(" [>] no remaining context, prob. matrix has 0 rows") 
			tmat <- matrix(nrow=0, ncol=nbetat)
			n <- matrix(nrow=0, ncol=1)
		} else {
			message(" [>] computing prob., L=", L, ", ", nbcontext, " distinct context(s)") 
			tmat <- xtabs(weights ~ contextes+states)
			n <- rowSums(xtabs(rep(1, length(contextes)) ~ contextes+states))
			n <- as.data.frame(n, ncol=1)
			tmat <- as.data.frame(tmat[])

			## eliminating patterns containing missing states if with.missing=FALSE
			if (!with.missing) { 
				## if nr is a 'grep' special character 
				if (nr %in% c("?", "*")) { nr <- paste("\\",nr, sep="") }
				hasMiss <- grep(nr, rownames(tmat))
				if (length(hasMiss)>0) { 
					message(" [>] removing ", length(hasMiss), " context(s) containing missing values") 
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

