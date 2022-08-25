#' Conduct.PhylogeneticRegression_PIC_L1: function to conduct phylogenetic regression using PIC and L1 estimator
#'
#' This function returns a regression object that can be read using standard R functions (summary, lm, etc.)
#' @param handle.Phylogeny Phylogeny object that is used to compute PICs
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependent (response) trait y
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return handle.PIC_L1 Object containing results of L1 regression for PIC
#' @export
#' @examples
#' 
#' ################
#' # load depends #
#' ################
#' library(geiger)
#' library(ROBRT)
#' library(phytools)
#' library(L1pack)
#' 
#' ################################
#' # simulate tree and trait data #
#' ################################
#' handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
#' vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' 
#' ######################################
#' # Conduct L1 phylogenetic regression #
#' ######################################
#' summary(Conduct.PhylogeneticRegression_PIC_L1(handle.Phylogeny = handle.Phylogeny, vector.Trait_X = vector.TraitValue_X, vector.Trait_Y = vector.TraitValue_Y))


#########################################
# Conduct.PhylogeneticRegression_PIC_L1 #
#########################################
Conduct.PhylogeneticRegression_PIC_L1 <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y){
  
  ################
  # Compute PICS #
  ################
  vector.PIC_X <- pic(x = vector.Trait_X, phy = handle.Phylogeny)
  vector.PIC_Y <- pic(x = vector.Trait_Y, phy = handle.Phylogeny)
  
  #########################
  # Compute L1 regression #
  #########################
  handle.PIC_L1 <- lad(formula = vector.PIC_Y~vector.PIC_X-1, method = "EM")
  
  ##########
  # return #
  ##########
  return(handle.PIC_L1)
  
}