## PST

setOldClass("stslist")

setClass("plist",
	representation(
		alphabet="character",
		labels="character",
		nr="character",
		cpal="character",
		missing.color="character",
		weighted="logical"),
	contains="list"
)

setClass("pstree",
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

setClass("PST.list",
	representation(
		data="stslist",
		alphabet="character",
		labels="character",
		cpal="character"),
	contains="list"
)



setClass("pstree.root",
	representation(
		alphabet="character",
		labels="character",
		cpal="character"),
	contains="pstree"
)


setClass("pstree.summary",
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




