
#' @importFrom jsonlite fromJSON
#' @importFrom methods new
#' @export
readPAE <- function(jsonFile) {
    
    json <- jsonFile |>
        fromJSON() |> 
        lapply(FUN = unlist)
    
    new("PredictedAlignedError",
        residue1 = json$residue1,
        residue2 = json$residue2,
        distance = json$distance,
        max_predicted_error = json$max_predicted_aligned_error
        )
}
