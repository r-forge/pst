## Probability distribution of a node and its parents
## and illustration of the pruning process 

seqprobplot <- function(PST, seq, L, stcol=TRUE, plotseq=FALSE, ptype="barplot", cex.plot=1, space=0, grid=TRUE,...) {
	A <- PST@alphabet
	cpal <- cpal(seq)
	nbstate <- length(A)
	nr <- attr(seq, "nr")
	oolist <- list(...)

	if (missing(L)) {
		L <- length(PST)-1
	}
	
	message(" [>] computing prob., max. length=", L)	
	
	prob <- predict(PST, seq, L, log=FALSE, decomp=TRUE)
	sl <- seqlength(seq)
	poff <- 0

	if (any(seq==nr)) {
		A <- c(A, nr)
		cpal <- c(cpal, attr(seq, "missing.color"))
		nbstate <- nbstate+1
	}

	seqbar <- TraMineR:::seqgbar(as.matrix(seq), seql=sl, statl=A)

	if (plotseq) {
		## Plotting path
		barw <- 1
		seqscale <- 0.3
		seqpsep <- 0.1
		poff <- seqscale+seqpsep

		seqbar <- matrix(seqbar, nrow=nbstate)
		seqbar <- seqbar*seqscale
		## seqbar <- cbind(seqbar, rep(0, nbstate))

		if (!"main" %in% names(oolist)) {
			main <- paste("States probabilities for seq")
		}

		barplot(seqbar, col=cpal, width=barw,
			## ylab=ylab,
			## xlim=c(0,(sl+1)),
			ylim=c(0,(poff+1)),
			horiz=FALSE,
			axes=FALSE,
			axisnames=FALSE,
			main=main,
			space=space,
			...)
	}

	## Plotting probability distributions
	if (ptype=="barplot") {
		if (stcol) {	
			tmp <- seqbar
			tmp[tmp==1] <- tmp[tmp==1]*prob
			tmp <- matrix(tmp, nrow=nbstate)
			stcol <- cpal
		} else {
			tmp <- prob
			stcol <- "red"
		}

		barplot(tmp, col=stcol, offset=poff, add=plotseq, ylim=c(0,(poff+1)), 
			space=space, axes=FALSE, axisnames=FALSE, ...)
	} else if (ptype=="lines") {
		if (plotseq) {
			lines(0.5:(length(prob)-0.5), prob+poff, col="red", type="s")
		} else {
			plot(0.5:(length(prob)-0.5), prob+poff, col="red", type="s")
		}
	}

	tpos <- seq(1, sl, by=attr(seq, "xtstep"))
	tlab <- colnames(seq)[tpos]
	tpos <- tpos + (tpos*space)

	axis(1, at=tpos-0.5, labels=tlab, pos=-0.04)

	plabpos <- seq(from=poff, to=(poff+1), by=0.2)
	plab <- plabpos-poff

	axis(2, at=plabpos, 
		labels=plab, 
		## las=2, 
		cex.axis=cex.plot)

}
