## PST
## Sequence objects as produced by TraMineR are S3 classes
setOldClass("stslist")

setClass("cprobd",
	representation(
		context="character"
	),
	contains="matrix"
)

setClass("cprobd.list",
	representation(
		alphabet="character",
		labels="character",
		cpal="character"
	),
	contains="list"
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

setClass("PSTf",
	representation(
		data="stslist",
		alphabet="character",
		labels="character",
		cpal="character",
		segmented="logical",
		group="factor",
		call="call"),
	contains="list"
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




