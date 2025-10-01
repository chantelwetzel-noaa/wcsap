#' Common species name in a matrix form. This approach can result in
#' issues in identifying species. Needs to be improved in order to create
#' search groups for complex species.
#'
#' @author Chantel Wetzel
#' @export
#'
#'
all_species <- function() {
  default <- getOption('warn')
  options(warn = -1)

  species = rbind(
    "arrowtooth flounder",
    "aurora rockfish",
    "bank rockfish",
    "big skate",
    "black rockfish",
    "blackgill rockfish",
    c(
      "blue rockfish",
      "deacon rockfish",
      "blue/deacon rockfish",
      "blue and deacon rockfish"
    ),
    "bocaccio",
    "California scorpionfish",
    "canary rockfish",
    "cabezon",
    "China rockfish",
    c("chilipepper", "chilipepper rockfish"),
    "copper rockfish",
    "cowcod",
    "darkblotched rockfish",
    "Dover sole",
    "English sole",
    "flathead sole",
    "greenspotted rockfish",
    "greenstriped rockfish",
    "kelp greenling",
    "lingcod",
    "longnose skate",
    "longspine thornyhead",
    "Pacific cod",
    "Pacific ocean perch",
    "Pacific sanddab",
    c("Pacific spiny dogfish", "spiny dogfish", "dogfish shark"),
    "petrale sole",
    "quillback rockfish",
    "redbanded rockfish",
    "rex sole",
    c(
      "rougheye rockfish",
      "blackspotted rockfish",
      "rougheye/blackspotted rockfish",
      "rougheye and blackspotted rockfish"
    ),
    "sablefish",
    "sand sole",
    "sharpchin rockfish",
    "shortraker rockfish",
    "shortspine thornyhead",
    "splitnose rockfish",
    "squarespot rockfish",
    "starry rockfish",
    c(
      "vermilion rockfish",
      "sunset rockfish",
      "vermilion/sunset rockfish",
      "vermilion and sunset rockfish"
    ),
    "widow rockfish",
    "yelloweye rockfish",
    "yellowtail rockfish"
  )

  options(warn = default)

  return(species)
}
