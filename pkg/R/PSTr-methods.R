## TAKEN FROM dengrogram method
## The ``generic'' method for "[["  (identical to e.g., "[[.POSIXct"):
## --> subbranches are pstrees as well!

setMethod("[[", "PSTr", function(x, i, drop = TRUE, root.attr=FALSE) {
	## cl <- class(x)
	alphabet <- x@alphabet
	cpal <- x@cpal
	labels <- x@labels

	x <- unclass(x)
	x <- x[[i]]

	if (!is.null(x) & root.attr) {
		x@alphabet <- alphabet
		x@cpal <- cpal
		x@labels <- labels
	}

	x
}
)



## Displaying PST
setMethod("print", "PSTr", function (x, max.level = NULL, digits.d = 1, give.attr = FALSE, 
    wid = getOption("width"), nest.lev = 0, indent.str = "", 
    stem = "--"
	## , ...
	) {

    pasteLis <- function(lis, dropNam, sep = " = ") {
        lis <- lis[!(names(lis) %in% dropNam)]
        fl <- sapply(lis, format, digits = digits.d)
        paste(paste(names(fl), fl, sep = sep), collapse = ", ")
    }

	istr <- sub(" $", "`", indent.str)
	cat(istr, stem, sep = "")
	at <- attributes(x)

	path <- at[["path"]]
	prob <- at[["prob"]]
	hgt <- at[["order"]]
	n <- at[["n"]]

	le <- length(which.child(x))
	leaf <- is.leaf(x)

    	left <- if (leaf) {"("} else {"["}
	right <- if (leaf) {")"} else {"]"}
        
        if (give.attr) {
            if (nzchar(at <- pasteLis(at, c("prob", "order", 
                "path")))) 
                at <- paste(",", at)
        }
        cat(left, path, ", ", sep="")
		## " (k=", format(hgt, digits = digits.d), "), ", 
		if (leaf) cat("leaf,") else cat(le, " child.,", sep="")
		cat(" p=(", sep="")
		cat(format(prob, digits = digits.d, scientific=FALSE), sep=",")
		cat("), n=",n, if (give.attr) 
                at, right, if (!is.null(max.level) && nest.lev == 
                max.level) 
                " ..", "\n", sep = "")

	if (!is.leaf(x)) {
		if (is.null(max.level) || nest.lev < max.level) {
			for (i in which.child(x)) {
				print(x[[i]], nest.lev = nest.lev + 1, 
					indent.str = paste(indent.str, if (i < le) " |" else "  "), 
					max.level = max.level, digits.d = digits.d, 
					give.attr = give.attr, wid = wid)
			}
		}
	}
    ## else {
    ##    cat("(", path, ", leaf)", sep="")
    ##    any.at <- hgt != 0
        ## if (any.at) 
        ## cat("(k =", format(hgt, digits = digits.d))
        ## if (memb != 1) 
        ##    cat(if (any.at) 
        ##        ", "
        ##    else {
        ##        any.at <- TRUE
        ##        "("
        ##    }, "memb= ", memb, sep = "")
        ## at <- pasteLis(at, c("class", "order", "path", "leaf"))
        ## if (any.at || nzchar(at)) 
        ##    cat(if (!any.at) 
        ##        "(", at, ")")
   ##     cat("\n")
   ## }
}
)

setMethod("summary", "PSTr", function(object, max.level=NULL) {

	stats <- pstree.rl.stats(object, max.level=max.level)

	res <- new("PST.summary",
		alphabet=object@alphabet,
		labels=object@labels,
		cpal=object@cpal,
		depth=as.integer(stats$depth),
		nodes=as.integer(stats$nodes),	
		leaves=as.integer(stats$leaves),
		freepar=as.integer((stats$nodes+stats$leaves)*(length(object@alphabet)-1))
	)

	return(res)
}
)

pstree.rl.stats <- function(PST, max.level) {
	stats <- list(leaves=as.integer(0), nodes=as.integer(0), depth=as.integer(0))

	childrens <- which.child(PST)

	stats$depth <- attr(PST,"order")

	if (is.leaf(PST) | (!is.null(max.level) && PST@order==max.level)) {
		stats$leaves <- stats$leaves+1
	} else if (is.null(max.level) | (!is.null(max.level) && max.level>PST@order)) {
		stats$depth <- stats$depth+1
		stats$nodes <- stats$nodes+1
		for (i in childrens) {
			tmp <- pstree.rl.stats(PST[[i]], max.level=max.level)
			stats$leaves <- stats$leaves+tmp$leaves
			stats$nodes <- stats$nodes+tmp$nodes
			if (tmp$depth>stats$depth) (stats$depth  <- tmp$depth)
		}
	}
	
	return(stats)
}


setMethod("show", "PST.summary", function(object) {
	alphabet <- object@alphabet
	nbstates <- length(alphabet)
	cpal <- object@cpal
	labels <- object@labels
	ns <- object@ns

	cat(" [>] alphabet (state labels): ","\n")
	maxstatedisplay <- 12
	for (i in 1:min(nbstates,maxstatedisplay))
		cat("     ",i, "=", object@alphabet[i], " (", labels[i], ")","\n", sep="")
	if (nbstates>12) message("      ...")
	cat(" [>] PST estimated using", ns, "symbols \n") 
	cat(" [>] max. depth:", object@depth,"\n")
	cat(" [>] ", object@nodes, " node(s), ", object@leaves, " leave(s)\n", sep="")
	cat(" [>] (", object@nodes,"+",object@leaves,") * (",nbstates, "-1) = ", object@freepar, " free parameters \n", sep="")
}
)

which.child <- function(PST) {
	child.list <- names(PST)[unlist(lapply(PST, is, "PSTr"))]
	return(child.list)
}
