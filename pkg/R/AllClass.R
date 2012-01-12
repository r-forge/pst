## PST

setOldClass("stslist")

setClass("PSTr",
	representation(
		alphabet="character",
		labels="character",
		cpal="character",
		counts="numeric",
    		n="numeric",
		prob="numeric",
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
		cpal="character"),
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




