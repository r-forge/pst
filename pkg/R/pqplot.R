## Probability distribution of a node and its parents
## and outcomes of the gain function 

setMethod("pqplot", signature=c(object="PSTf", data="stslist"), 
	def <- function(object, data, cdata, L, stcol=TRUE, plotseq=FALSE, ptype="barplot", cex.plot=1, space=0, grid=TRUE, seqprob=TRUE,
	measure="prob", pqmax, ...) {

	oolist <- list(...)

	if (missing(L)) { L <- length(object)-1 }
	
	message(" [>] computing prob., max. length=", L)
	
	if (!missing(cdata)) {
		prob <- predict(object, data=data, cdata=cdata, L=L, decomp=TRUE)
	} else {
		prob <- predict(object, data=data, L=L, decomp=TRUE)
	}

	## Number of predicted symbols (used instead of sequence length)
	sl <- rowSums(!is.na(prob))

	if (measure=="logloss") {
		prob <- -log(prob, base=2)
		if (missing(pqmax)) { pqmax <- ceiling(max(prob)) }
		pmean <- sum(prob)/sl
		ytstep <- 1
		ylab <- "Log-loss"
	} else {
		if (missing(pqmax)) { pqmax <- 1 }
		pmean <- exp(log(rowProds(prob))/sl)
		ytstep <- 0.2
		ylab <- "Prob"
	}

	poff <- 0

	if (plotseq) {
		if (missing(cdata)) { cdata <- data }

		c.A <- alphabet(cdata)
		c.cpal <- cpal(cdata)

		if (any(cdata==attr(cdata, "nr"))) {
			c.A <- c(A, attr(cdata, "nr"))
			c.cpal <- c(cpal, attr(cdata, "missing.color"))
		}

		tmp <- TraMineR:::seqgbar(as.matrix(cdata), seql=sl, statl=c.A)

		## Plotting path
		barw <- 1
		seqscale <- 0.3
		seqpsep <- 0.1
		poff <- seqscale+seqpsep

		tmp <- matrix(tmp, nrow=length(c.A))
		tmp <- tmp*seqscale

		if (!"main" %in% names(oolist)) {
			main <- paste("States probabilities for seq")
		}

		barplot(tmp, col=c.cpal, width=barw,
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
			A <- alphabet(data)
			cpal <- cpal(data)
			nr <- attr(data, "nr")

			if (any(data==attr(data, "nr"))) {
				A <- c(A, nr)
				cpal <- c(cpal, attr(data, "missing.color"))
			}

			tmp <- TraMineR:::seqgbar(as.matrix(data), seql=sl, statl=A)
			tmp[tmp==1] <- tmp[tmp==1]*prob
			tmp <- matrix(tmp, nrow=length(A))
			stcol <- cpal
		} else {
			tmp <- prob
			stcol <- "red"
		}

		barplot(tmp, col=stcol, offset=poff, add=plotseq, ylim=c(0,(poff+pqmax)), 
			space=space, axes=FALSE, axisnames=FALSE, ylab=ylab, ...)
		abline(h=pmean, col="red")

	} else if (ptype=="lines") {
		if (plotseq) {
			lines(0.5:(length(prob)-0.5), prob+poff, col="red", type="s")
		} else {
			plot(0.5:(length(prob)-0.5), prob+poff, col="red", type="s")
		}
	}

	tpos <- seq(1, sl, by=attr(data, "xtstep"))
	tlab <- colnames(data)[tpos]
	tpos <- tpos + (tpos*space)

	axis(1, at=tpos-0.5, labels=tlab, pos=-0.04)

	plabpos <- seq(from=poff, to=(poff+pqmax), by=ytstep)
	plab <- plabpos-poff

	axis(2, at=plabpos, 
		labels=plab, 
		## las=2, 
		cex.axis=cex.plot)

}
)
