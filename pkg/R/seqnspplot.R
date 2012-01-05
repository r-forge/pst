## Probability distribution of a node and its parents
## and illustration of the pruning process 

seqnspplot <- function(PST, path, r, K,  cex.plot=1, seqscale=0.3, pscale=0.1, pruned.col="red", div.col="green", ...) {
	A <- PST@alphabet
	nbstate <- length(A)
	oolist <- list(...)

	if (length(path)==1) { path <- seqdecomp(path) }

	sl <- length(path)
	cpal <- c(PST@cpal, "white")

	## Retrieving probabilities
	prob <- matrix(nrow=nbstate, ncol=sl+1)
	N <- matrix(nrow=1, ncol=sl+1)

	node <- query(PST, "e", output="all")
	prob[,(sl+1)] <- as.numeric(node[,A])
	N[,sl+1] <- node[,"n"]
	
	lsuff <- lsuffix(PST, path)
	lsp <- sl-length(lsuff)+1	

	for (j in lsp:sl) {
		node <- query(PST, paste(path[j:sl], collapse="-"), output="all")
		prob[,j] <- as.numeric(node[,A])
		N[,j] <- node[, "n"]
	}

	## Plotting path
	barw <- 1
	seqscale <- 0.3
	gsep <- 0.1
	ppsep <- 0.05

	poff <- seqscale+gsep
	nr <- if (!missing(r)) { length(r) } else { 0 }
	nK <- if (!missing(K)) { length(K) } else { 0 }

	seqbar <- TraMineR:::seqgbar(c(path, "e"), seql=sl+1, statl=c(A,"e"))
	seqbar <- matrix(seqbar, nrow=nbstate+1)
	seqbar <- seqbar*seqscale
	## seqbar <- cbind(seqbar, rep(0, nbstate))

	barplot(seqbar, col=cpal, width=barw,
		## ylab=ylab,
		## xlim=c(0,(sl+1)),
		ylim=c(0,(poff+1+((nr+nK)*(pscale+ppsep))+ (((nr+nK)>0) * gsep))),
		horiz=FALSE,
		axes=FALSE,
		axisnames=FALSE,
		...)

	## Tag as div 
	if (!missing(r) | !missing(K)) {
		div <- matrix(nrow=nr+nK, ncol=sl)
		pruned <- matrix(nrow=nr+nK, ncol=sl)

		for (j in lsp:sl) {
			idpar <- 1
			if (nr>0) {
				for (i in 1:nr) { 
					div[idpar, j] <- pdiv(prob[,j], prob[,(j+1)], r=r[i])
					idpar <- idpar+1
				}
			}

			if (nK>0) {
				for (i in 1:nK) { 
					div[idpar, j] <- pdiv(prob[,j], prob[,(j+1)], K=K[i], N=N[,j])
					idpar <- idpar+1
				}
			}
		}

		pruned[,lsp] <- !div[,lsp]
		for (j in (lsp+1):sl) {
			for (pp in 1:(nr+nK)) {		
				pruned[pp, j] <- !div[pp, j] & pruned[pp, j-1]
				
			}
		}

		ppar.lab.pos <- NULL
		for (pp in 1:(nr+nK)) {
			barplot(rbind(div[pp,], pruned[pp,])*pscale, col=c(div.col,pruned.col), 
			offset=poff, add=TRUE, axes=FALSE, ...)
			ppar.lab.pos <- c(ppar.lab.pos, poff+(pscale/2))
			poff <- poff+pscale+ppsep
		}

		ppar.lab <- NULL
		if (nr>0) { ppar.lab <- c(ppar.lab, paste("r", 1:nr, sep="")) }
		if (nK>0) { ppar.lab <- c(ppar.lab, paste("K", 1:nK, sep="")) }

		axis(2, at=ppar.lab.pos, 
			labels=ppar.lab, 
			## las=2, 
			cex.axis=cex.plot)

		poff <- poff+gsep
	}



	## Plotting probability distributions
	barplot(prob, xlab="L (memory)", col=cpal, offset=poff, add=TRUE, axes=FALSE, ...)

	tpos <- 1:(sl+1)
	tpos <- tpos+tpos* if ("space" %in% names(oolist)) {oolist[["space"]]} else {0.2}

	axis(1, at=tpos-0.5, labels=sl:0, pos=-0.04)

	plabpos <- seq(from=poff, to=(poff+1), by=0.2)
	plab <- plabpos-poff

	axis(2, at=plabpos, 
		labels=plab, 
		## las=2, 
		cex.axis=cex.plot)

}
