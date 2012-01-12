## Merging two PST

setMethod("merge", signature=c(x="PSTf", y="PSTf"), 
	def=function(x, y, verbose=FALSE) {

		A1 <- alphabet(x)
		A2 <- alphabet(y)

		if (!all.equal(A1, A2)==TRUE) {
			stop(" [!] you can only merge trees based on the same alphabet!")
		}

		if (length(y) > length(x)) {
			tmp <- x
			x <- y
			y <- tmp
		} 
		Lmax <- max(length(x), length(y))

		for (L in min(length(x), length(y)):1) {
			xnodes.id <- rownames(x[[L]])
			ynodes.id <- rownames(y[[L]])
			xy.id <- ynodes.id %in% xnodes.id

			yy <- ynodes.id[!xy.id]
			yx <- ynodes.id[xy.id]

			if (length(yx)>0) {
				x[[L]][yx, paste(A1, "@wn", sep="")] <- x[[L]][yx, paste(A1, "@wn", sep="")]+
					y[[L]][yx, paste(A1, "@wn", sep="")]
				x[[L]][yx, "n"] <- x[[L]][yx, "n"] + y[[L]][yx, "n"]
			}

			if (length(yy)>0) { 
				x[[L]] <- rbind(x[[L]], y[[L]][yy,]) 

			}

			x[[L]][,A1] <- x[[L]][,paste(A1, "@wn", sep="")]/rowSums(x[[L]][,paste(A1, "@wn", sep="")])
			if (L<Lmax) {
				x[[L]]$leaf <- TRUE		
				x[[L]][unique(x[[L+1]]$parent), "leaf"] <- FALSE
			} 
		}

		return(x)
	}
)





