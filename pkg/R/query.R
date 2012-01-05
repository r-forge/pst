## Extracting the probability of observing each symbol in the alphabet after a given subsequence (string)

setMethod("query", signature="PST.list", 
	def=function(object, string, state, output="prob", exact=FALSE) {
		A <- attr(object, "alphabet")

		if (missing(string) || string=="e") {
			string <- "e"
			idxl <- 1
		} else {
			sd <- unlist(strsplit(string, split="-"))
      string <- paste(sd, collapse="-")
			idxl <- length(sd)+1
			if (any(!sd %in% A)) {
				stop(" [!] one or more symbol not in alphabet")
			} 
		}

		if (exact && !string %in% rownames(object[[idxl]])) {
			message( "[>] node is not in the tree")
			res <- NULL
		} else {
			if (idxl>length(object)) { 
				idxl <- length(object) 
				sd <- sd[(length(sd)-(idxl-2)):length(sd)]
        string <- paste(sd, collapse="-")
			}

      while (!string %in% rownames(object[[idxl]][!object[[idxl]]$pruned,])) {
				idxl <- idxl-1
        sd <- sd[2:length(sd)]
				string <- if (idxl>1) { paste(sd, collapse="-") } else {"e"}
			}

			res <- object[[idxl]][string,]
			if (output=="prob") {
				res <- res[,A]
				names(res) <- A
			} else if (output=="counts") {
				res <- res[, paste(A, "@wn", sep="")]
			} else if (output=="n") {
				res <- res[,"n"]
			}
			message(" [>] retrieving from node: ", paste(string, collapse="-"))
		}

		if (!missing(state) && output %in% c("prob", "counts")) {
					res <- res[which(A==state)]
		}

		return(res)
	}
)




