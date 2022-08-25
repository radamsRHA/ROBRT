#' Conduct.MatrixTransformation_PGLS: function to compute the phylogenetic transformation matrix that can be used to transform input trait values
#'
#' This function returns a matrix that can be used to transform input trait values in phylogenetic space
#' @param handle.Phylogeny Phylogeny object that is used to generate the matrix.P (phylogenetic transform matrix)
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return matrix.P Matrix used for phylogenetic transformation of input trait data
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(geiger)
#' library(ROBRT)
#' 
#' ################################
#' # simulate tree and trait data #
#' ################################
#' handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
#' vector.TraitValue <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1]
#' 
#' #####################
#' # transform to PGLS #
#' #####################
#' Conduct.MatrixTransformation_PGLS(handle.Phylogeny = handle.Phylogeny)


#####################################
# Conduct.MatrixTransformation_PGLS #
#####################################
Conduct.MatrixTransformation_PGLS <- function(handle.Phylogeny){
  
  ###############################
  # function for transformation #
  ###############################
  "%XXX%" <- function(x, n) with(eigen(x), vectors %*% (values^n * t(vectors)))
  
  #################
  # Decompose VCV #
  #################
  numeric.NumberOfSpecies <- length(handle.Phylogeny$tip.label)
  matrix.C <- vcv(phy = handle.Phylogeny) # VCV matrix
  matrix.U <- eigen(x = matrix.C)$vectors
  matrix.W <- matrix(0, nrow = numeric.NumberOfSpecies, ncol = numeric.NumberOfSpecies)
  diag(matrix.W) <- eigen(x = matrix.C)$values
  matrix.P <- solve(matrix.U %*% (matrix.W %XXX% (0.5)) %*% t(matrix.U))
  
  ##########
  # return #
  ##########
  return(matrix.P) # phylogenetic transformation matrix
  

}