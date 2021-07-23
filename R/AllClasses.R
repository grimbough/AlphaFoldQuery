#' 
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
