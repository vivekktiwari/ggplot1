#' Scale: manual
#'
#' This scale function allows you complete control over the
#' scale.
#'
#' Supply labels and breaks to produce a legend.
#'
#' @inheritParams pscontinuous
#' @param labels character vector of break labels
#' @param grob grob function to use when drawing legend
#' @export
scmanual <- function(plot, variable="x", name="", breaks=NULL, labels=as.character(breaks), grob=function(x) grob_point(x, unique=FALSE)) {
	add_scale(plot,
	  scale_manual(variable=variable, name=name, breaks=breaks, labels=labels, grob=grob)
	)
}

scale_manual <- function(name="", variable="x", breaks=NULL, labels=labels, grob=function(x) grob_point(x, unique=FALSE)) {
	structure(
		list(variable=variable, name=name, breaks=breaks, labels=labels, grob=grob),
		class = c("manual", "scale")
	)
}
#' @export
"update<-.manual" <- function(x, value) x
#' @export
map_aesthetic.manual <- function(scale, data, ...) {
	if (length(intersect(names(data), input(scale))) < length(input(scale))) return(data.frame())
	data[,input(scale), drop=FALSE]
}
#' @export
breaks.manual <- function(scale, ...) scale$breaks
#' @export
labels.manual <- function(object, ...) scale$labels


#' @export
print.manual <- function(x, ...) {
	cat(paste("manual scale: ", scale_mapping(x), "\n", sep=""))
}

#' @export
defaultgrob.manual <- function(x) x$grob
#' @export
guides.manual <- function(scale, ...) {
  if(is.null(scale$labels)) return()
  guides.default(scale, ...)
}
