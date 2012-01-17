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
	## seqscale <- 0.3
	gsep <- 0.1
	ppsep <- 0.05

	poff <- seqscale+gsep
	nr <- if (!missing(r)) { length(r) } else { 0 }
	nK <- if (!missing(K)) { length(K) } else { 0 }

	seqbar <- TraMineR:::seqgbar(c(path, "e"), seql=sl+1, statl=c(A,"e"))
	seqbar <- matrix(seqbar, nrow=nbstate+1)
	seqbar <- seqbar*seqscale
	## seqbar <- cbind(seqbar, rep(0, nbstate))

	plot(NULL, 
		xlim=c(1-seqscale, sl+2),
		ylim=c(0,(poff+1+((nr+nK)*(pscale+ppsep))+ (((nr+nK)>0) * gsep))),
		axes=FALSE,
		xlab="L (memory)", ylab="",
		...)
	segments(1, seqscale/2, sl+1, seqscale/2, col="grey", lwd=3)

	for (i in 1:sl) {
		segments(i, seqscale/2, i, poff, col="grey", lwd=3)

		symbols(x=i, y=seqscale/2, circles=seqscale, bg=cpal[which(path[i]==A)], add=TRUE, inches=FALSE)
		text(x=i, y=seqscale/2, labels=path[i])

		plotProb(i-seqscale, poff, i+seqscale, poff+1, prob[,i], cpal)
	}

	## ROOT NODE
	segments(sl+1, seqscale/2, sl+1, poff, col="grey", lwd=3)

	symbols(sl+1, y=seqscale/2, circles=seqscale, bg="grey", add=TRUE, inches=FALSE)
	text(x=sl+1, y=seqscale/2, labels="e")
	
	plotProb((sl+1)-seqscale, poff, (sl+1)+seqscale, poff+1, prob[,sl+1], cpal)

	axis(1, at=(1:(sl+1)), labels=sl:0, pos=-0.04)

	plabpos <- seq(from=poff, to=(poff+1), by=0.2)
	plab <- plabpos-poff

	axis(2, at=plabpos, 
		labels=plab, 
		## las=2, 
		cex.axis=cex.plot)

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
		poff <- poff+pscale+ppsep+1

		for (pp in 1:(nr+nK)) {

			for (i in 1:sl) {
				rect(i-seqscale, poff, i+seqscale, poff+pscale, 
					col=if (pruned[pp, i]) {pruned.col} else if ( div[pp,i] ) {div.col} else {"grey"})
			}

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

}
