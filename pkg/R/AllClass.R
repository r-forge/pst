## PST
## Sequence objects as produced by TraMineR are S3 classes
setOldClass("stslist")

setClass("cprobd",
	representation(
		context="character"
	),
	contains="matrix"
)

setClass("PSTr",
	representation(
		alphabet="character",
		labels="character",
		cpal="character",
		counts="matrix",
    		n="numeric",
		prob="matrix",
		path="character",
		order="integer",
		leaf="logical",
		pruned="logical"),
	contains="list"
)

setClass("PSTr.tv",
	representation(
		alphabet="character",
		labels="character",
		cpal="character",
		counts="matrix",
    		n="numeric",
		prob="matrix",
		path="character",
		order="integer",
		leaf="logical",
		pruned="logical"),
	contains="list"
)


setClass("PSTf",
	representation(
		data="stslist",
		alphabet="character",
		labels="character",
		cpal="character",
		grouped="logical",
		group="factor"),
	contains="list"
)


setClass("PSTf.tv",
	representation(
		data="stslist",
		alphabet="character",
		labels="character",
		cpal="character"),
	contains="list"
)

setClass("PSTf.gr",
	representation(
		data="stslist",
		alphabet="character",
		labels="character",
		cpal="character"),
	contains="list"
)


setClass("PSTf.mc",
	representation(
		context.data="stslist",
		context.alphabet="character",
		context.labels="character",
		context.cpal="character"),
	contains="PSTf"
)



setClass("PSTr.root",
	representation(
		alphabet="character",
		labels="character",
		cpal="character"),
	contains="PSTr"
)


setClass("PST.summary",
	representation(
		alphabet="character",
		labels="character",
		cpal="character",
		ns="integer",
		depth="integer",
		nodes="integer",
		leaves="integer",
		freepar="integer")
)




