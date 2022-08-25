#' Conduct.PhylogeneticRegression_PIC_L2: function to conduct phylogenetic regression using PIC and L2 estimator
#'
#' This function returns a regression object that can be read using standard R functions (summary, lm, etc.)
#' @param handle.Phylogeny Phylogeny object that is used to compute PICs
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependant (response) trait y
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return handle.PIC_L2 Object containing results of L2 regression for PIC
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(geiger)
#' library(ROBRT)
#' library(phytools)
#' 
#' ################################
#' # simulate tree and trait data #
#' ################################
#' handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
#' vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' 
#' ######################################
#' # Conduct L2 phylogenetic regression #
#' ######################################
#' summary(Conduct.PhylogeneticRegression_PIC_L2(handle.Phylogeny = handle.Phylogeny, vector.Trait_X = vector.TraitValue_X, vector.Trait_Y = vector.TraitValue_Y))


#########################################
# Conduct.PhylogeneticRegression_PIC_L2 #
#########################################
Conduct.PhylogeneticRegression_PIC_L2 <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y){
  
  ################
  # Compute PICS #
  ################
  vector.PIC_X <- pic(x = vector.Trait_X, phy = handle.Phylogeny)
  vector.PIC_Y <- pic(x = vector.Trait_Y, phy = handle.Phylogeny)
  
  #########################
  # Compute L2 regression #
  #########################
  handle.PIC_L2 <- lm(vector.PIC_Y ~ vector.PIC_X-1)
  
  ##########
  # return #
  ##########
  return(handle.PIC_L2)

}