
.validUniprotID <- function(id) {
    grepl(x = id,
          pattern = "^([A-N,R-Z][0-9]([A-Z][A-Z, 0-9][A-Z, 0-9][0-9]){1,2})|([O,P,Q][0-9][A-Z, 0-9][A-Z, 0-9][A-Z, 0-9][0-9])(\\.\\d+)?$")
}

.createURL <- function(input) {
    url <- sprintf("https://alphafold.ebi.ac.uk/files/AF-%s-F1-predicted_aligned_error_v1.json",
                   input)
}

#' @importFrom httr GET http_error content
#' 
.testURL <- function(url) {
    res <- httr::GET(url) 
    ## download error
    if(http_error(res)) {
        stop("Error downloading JSON file")
    } 
    return(content(res, type = "application/json"))
}

#' Read an AlphaFold predicted aligned error file
#' 
#' @param input Character vector of length 1.  Can be either a complete URL
#' or local path to a predicted aligned error JSON file or a Uniprot protein 
#' ID.
#' 
#' @returns An object of class [PredictedAlignedError-class]
#' 
#' @examples 
#' ## using a Uniprot ID
#' readPAE( "O82387" )
#' 
#' ## using the full URL to a JSON file
#' readPAE( "https://alphafold.ebi.ac.uk/files/AF-O15552-F1-predicted_aligned_error_v1.json" )
#' 
#' @importFrom jsonlite fromJSON
#' @importFrom methods new
#' @export
readPAE <- function(input) {
    
    is_url <- grepl("^http", x = input)
    if(is_url) {
        json <- fromJSON(input)
    } else {
        if(!.validUniprotID(input)) {
            stop(input, " is not a valid Uniprot ID")
        }
        json <- .testURL(.createURL(input))[[1]]
    }
    
    json <- lapply(json, FUN = unlist)
    
    new("PredictedAlignedError",
        residue1 = json$residue1,
        residue2 = json$residue2,
        distance = json$distance,
        max_predicted_error = json$max_predicted_aligned_error
        )
}
