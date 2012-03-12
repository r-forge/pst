## Probability distribution of a node and its parents
## and illustration of the pruning process 

setMethod("ppplot", signature="PSTf", 
	def=function(object, path, state, r, K,  cex.plot=1, seqscale=0.3, node.type="circle", pscale=seqscale/2, 
		pruned.col="red", div.col="green", ...) {

		A <- object@alphabet
		if (!missing(state) && is.character(state)) { 
			state <- which(state==A)
		}

		nbstate <- length(A)
		oolist <- list(...)

		if (length(path)==1) { path <- seqdecomp(path) }

		sl <- length(path)
		cpal <- c(object@cpal)

		## Retrieving probabilities
		prob <- matrix(nrow=nbstate, ncol=sl+1)
		N <- matrix(nrow=1, ncol=sl+1)

		node <- query(object, "e", output="all")
		prob[,(sl+1)] <- as.numeric(node@prob)
		N[,sl+1] <- node@n
	
		lsuff <- lsuffix(object, path)
		lsp <- sl-length(lsuff)+1	

		for (j in lsp:sl) {
			node <- query(object, paste(path[j:sl], collapse="-"), output="all")
			prob[,j] <- as.numeric(node@prob)
			N[,j] <- node@n

		}

		## Plotting path
		barw <- 1
		gsep <- 0.1
		ppsep <- pscale/4
		poff <- 0

		nr <- if (!missing(r)) { length(r) } else { 0 }
		nK <- if (!missing(K)) { length(K) } else { 0 }

		plot(NULL, 
			xlim=c(1-seqscale, sl+2),
			ylim=c(0,(seqscale+gsep+1+((nr+nK)*(pscale+ppsep))+ (((nr+nK)>0) * gsep))),
			axes=FALSE,
			xlab="L (memory)", ylab="",
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
			poff <- poff+(pscale/2)

			for (pp in 1:(nr+nK)) {
				segments(1, poff, sl+1, poff, col="grey", lwd=3)
	
				for (i in 1:sl) {
					pcol <- if (pruned[pp, i]) {pruned.col} else if ( div[pp,i] ) {div.col} else {"grey"}
					if (node.type=="rectangle") {
						rect(i-seqscale, poff, i+seqscale, poff+pscale, 
							col=pcol)
					} else {
						symbols(x=i, y=poff, circles=pscale, bg=pcol, add=TRUE, inches=FALSE)
					}
				}
	
				symbols(x=sl+1, y=poff,	circles=pscale, bg="grey", add=TRUE, inches=FALSE)

				ppar.lab.pos <- c(ppar.lab.pos, poff)
				poff <- poff+pscale+ppsep
			}

			ppar.lab <- NULL
			if (nr>0) { ppar.lab <- c(ppar.lab, paste("r", 1:nr, sep="")) }
			if (nK>0) { ppar.lab <- c(ppar.lab, paste("K", 1:nK, sep="")) }

			axis(2, at=ppar.lab.pos, 
				labels=ppar.lab, 
				## las=2, 
				cex.axis=cex.plot)
		}

		## Plotting path and next symbol probability distributions
		poff <- poff+(seqscale/2)
		prob.yBottom <- poff+(seqscale/2)+gsep
	
		segments(1, poff, sl+1, poff, col="grey", lwd=3)

		for (i in 1:sl) {
			segments(i, poff, i, poff+(seqscale/2)+gsep, col="grey", lwd=3)
	
			symbols(x=i, y=poff, circles=seqscale, bg=cpal[which(path[i]==A)], add=TRUE, inches=FALSE)
			text(x=i, y=poff, labels=path[i])
			plotProb(i-seqscale, prob.yBottom , i+seqscale, prob.yBottom+1, prob=t(prob[,i]), state, cpal=cpal)
		}

		## ROOT NODE
		segments(sl+1, poff, sl+1, poff+(seqscale/2)+gsep, col="grey", lwd=3)

		symbols(sl+1, y=poff, circles=seqscale, bg="grey", add=TRUE, inches=FALSE)
		text(x=sl+1, y=poff, labels="e")

		## Plotting next symbol probability distributions
		plotProb((sl+1)-seqscale, prob.yBottom, (sl+1)+seqscale, prob.yBottom+1, t(prob[,sl+1]), state, cpal)

		axis(1, at=(1:(sl+1)), labels=sl:0, pos=-0.04)

		plabpos <- seq(from=prob.yBottom, to=(prob.yBottom+1), by=0.2)
		plab <- plabpos-prob.yBottom

		axis(2, at=plabpos, 
			labels=plab, 
			## las=2, 
			cex.axis=cex.plot)
	}
)

