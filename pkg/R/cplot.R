## Probability distribution of a node and its parents
## and illustration of the pruning process 

setMethod("cplot", signature="PSTf", 
	def=function(object, context, state, all=FALSE, x.by=1, y.by=0.2, ...) {

		A <- object@alphabet
		cpal <- c(object@cpal)
		oolist <- list(...)
		
		if (!missing(state) && is.character(state)) { 
			state <- which(state==A)
		}

		node <- query(object, context, output="all")
		prob <- node@prob
		pruned <- node@pruned

		if (all) {
			seg <- rownames(object[[1]][[1]]@prob)
		} else {
			seg <- rownames(prob)
		}

		plot(NULL, axes=FALSE, xlab="", ylab="Prob", xlim=c(1,(length(seg)+1)), ylim=c(1,0))

		## prob matrix is reversed because we are using the function for plotting the tree nodes (yaxis is reversed) 
		plotNodeProb(1, 1, length(seg)+1, 0, prob=prob, cpal=cpal, group=seg, pruned=pruned)

		if (length(seg)>1) { axis(1, at=seq(1.5, length(seg)+0.5, by=x.by), labels=seg) }
		axis(2, at=seq(0,1, by=y.by), labels=rev(seq(0,1, by=y.by)))
	}
)

