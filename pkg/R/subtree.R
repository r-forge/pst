## Extracts a given group
setMethod("subtree", "PSTf",  function(object, group) {
	if (!object@grouped) {
		stop(" this is not a grouped PST")
	}

	if (is.numeric(group)) {
		gid <- object@group==levels(object@group)[group]
	} else {
		gid <- object@group==group
	}

	seqdata <- object@data[gid,]
	A <- alphabet(object)
	cpal <- cpal(object)
	labels <- stlab(object)

	object <- as(object, "list")

	for (i in length(object):1) {
		object[[i]] <- lapply(object[[i]], select.group, as.character(group))
		remove <- unlist(lapply(object[[i]], is.null))
		object[[i]] <- object[[i]][!remove]
	}

	object <- new("PSTf", object, data=seqdata, alphabet=A, cpal=cpal, labels=labels, grouped=FALSE)
	return(object)
}
)

