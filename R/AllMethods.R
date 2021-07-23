
setMethod("show", signature = "PredictedAlignedError", function(object) {
    
    cat("Number of residues: ", sqrt(length(errors(object))), "\n")
    cat("Maximum Predicted Alignment Error:", maxPredictedError(object))
})

#' 
#' @export
setGeneric("errors", function(object) {
    standardGeneric("errors")
})

setMethod("errors", 
          signature = c("PredictedAlignedError"), 
          definition = function(object) {
              object@distance
          }
)


#' 
#' @export
setGeneric("maxPredictedError", function(object) {
    standardGeneric("maxPredictedError")
})

setMethod("maxPredictedError", 
          signature = c("PredictedAlignedError"), 
          definition = function(object) {
              object@max_predicted_error
          }
)
