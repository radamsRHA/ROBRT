#' Conduct.PhylogeneticRegression_PIC_M: function to conduct phylogenetic regression using PIC and M estimator
#'
#' This function returns a regression object that can be read using standard R functions (summary, lm, etc.)
#' @param handle.Phylogeny Phylogeny object that is used to compute PICs
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependent (response) trait y
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return handle.PIC_M Object containing results of M regression for PIC
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
#' 
#' ################################
#' # simulate tree and trait data #
#' ################################
#' handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
#' vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
#' 
#' #####################################
#' # Conduct M phylogenetic regression #
#' #####################################
#' summary(Conduct.PhylogeneticRegression_PIC_M(handle.Phylogeny = handle.Phylogeny, vector.Trait_X = vector.TraitValue_X, vector.Trait_Y = vector.TraitValue_Y))
#' 
#' handle.RESULTS_M <- Conduct.PhylogeneticRegression_PIC_M(handle.Phylogeny = handle.Phylogeny, vector.Trait_X = vector.TraitValue_X, vector.Trait_Y = vector.TraitValue_Y)
#' f.robftest(handle.RESULTS_M, var = "vector.PIC_X")$p.value

#########################################
# Conduct.PhylogeneticRegression_PIC_M #
#########################################
Conduct.PhylogeneticRegression_PIC_M <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y){
  
  ################
  # Compute PICS #
  ################
  vector.PIC_X <- pic(x = vector.Trait_X, phy = handle.Phylogeny)
  vector.PIC_Y <- pic(x = vector.Trait_Y, phy = handle.Phylogeny)
  
  #########################
  # Compute M regression #
  #########################
  handle.PIC_M <- rlm(formula = vector.PIC_Y~vector.PIC_X-1, method = "M", scale.est = "Huber", k2 = 1.345)
  
  ##########
  # return #
  ##########
  return(handle.PIC_M)
  
}