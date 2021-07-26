#' Predicted Aligned Error class
#'
#' Each structure prediction in AlphaFold is accompanied by a JSON file giving
#' the expected position error at each residue.  This class represents the 
#' contents of this file type.
#'
#' @slot residue1 The residue on which the protein structure is aligned.
#' @slot residue2 The residue the predicted error applies to.
#' @slot distance The predicted aligned error for each residue pairing.
#' @slot max_predicted_error The maximum possible value of the predicted aligned error.
#'
#' @name PredictedAlignedError-class
#' @rdname PredictedAlignedError-class
#' @exportClass PredictedAlignedError
setClass(Class = "PredictedAlignedError",
         slots = c(
           residue1 = "integer",
           residue2 = "integer",
           distance = "numeric",
           max_predicted_error = "numeric"
         ))

setAs(from = "PredictedAlignedError", to = "data.frame",
      def = function(from) {
        
        data.frame(
          residue1 = from@residue1,
          residue2 = from@residue2,
          distance = errors(from)
        )
      })

setAs(from = "PredictedAlignedError", to = "matrix",
      def = function(from) {
        matrix(
          errors(from), 
          nrow = sqrt(length(errors(from))),
          byrow = FALSE
        )
      })
