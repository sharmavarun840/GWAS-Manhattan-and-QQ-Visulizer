


package_install <- function(x){
  for (i in x) {
    # Check if package is installed
    if (!require(i, character.only = TRUE)){
      # If the package could not be loaded then install it
      install.packages(i)
    }
  }
}


packages <- c("shiny", "qqman", "data.table", "CMplot", "manhattanly", "plotly")


package_install(packages)