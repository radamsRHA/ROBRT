#' Conduct.PhylogeneticRegression_PGLS_MM: function to conduct phylogenetic regression using PGLS and MM estimator
#'
#' This function returns a regression object that can be read using standard R functions (summary, lm, etc.)
#' @param handle.Phylogeny Phylogeny object that is used to compute PGLS
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependant (response) trait y
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return handle.PGLS_MM Object containing results of MM regression for PGLS
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(geiger)
#' library(ROBRT)
#' library(phytools)
#' library(MASS)
#' library(L1pack)
#' library(robust)
#' 
#' ################################
#' # simulate tree and trait data #
#' ################################
#' handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
#' vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' 
#' ######################################
#' # conduct MM phylogenetic regression #
#' ######################################
#' Conduct.PhylogeneticRegression_PGLS_MM(handle.Phylogeny = handle.Phylogeny, vector.Trait_X = vector.TraitValue_X, vector.Trait_Y = vector.TraitValue_Y)

##########################################
# Conduct.PhylogeneticRegression_PGLS_MM #
##########################################
Conduct.PhylogeneticRegression_PGLS_MM <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y){
  
  #######################
  # Build design matrix #
  #######################
  numeric.NumberOfSpecies <- length(handle.Phylogeny$tip.label)
  matrix.Design_Trait_X <- cbind(rep(1, numeric.NumberOfSpecies), vector.Trait_X)
  
  ##########################################
  # Get phylogenetic transformation matrix #
  ##########################################
  matrix.P <- Conduct.MatrixTransformation_PGLS(handle.Phylogeny = handle.Phylogeny)
  
  ####################
  # Transform traits #
  ####################
  vector.Projected_Trait_Y <-  matrix.P %*% vector.Trait_Y
  matrix.Design_Projected_Trait_X <- matrix.P %*% matrix.Design_Trait_X
  
  #########################
  # Compute MM regression #
  #########################
  handle.PGLS_MM <- lmRob(formula = vector.Projected_Trait_Y~matrix.Design_Projected_Trait_X-1)
  
  ##########
  # RETURN #
  ##########
  return(handle.PGLS_MM)
  
  
}