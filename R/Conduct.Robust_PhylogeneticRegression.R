#' Conduct.Robust_PhylogeneticRegression: function to conduct robust phylogenetic regression using L2, L1, S, M, and/or MM for PGLS or PIC
#'
#' This function returns a list of robust phylogenetic regression results for L2, L1, S, M, and/or MM using PGLS or PIC
#' @param handle.Phylogeny Phylogeny object that is used to compute PGLS or PIC
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependent (response) trait y
#' @param vector.Estimators Vector where each element is a string that is "L1", "L2", "S", "M", or "MM"
#' @param string.Method String specifiying whether "PGLS" or "PIC" for phylogenetic regression
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return list.RESULTS List containing regression results for each estimator included in vector.Estimators
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
#' vector.Estimators <- c("L2")
#' 
#' #############################
#' # conduct robust regression #
#' #############################
#' Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
#'                                       string.Method = "PGLS",
#'                                       vector.Trait_X = vector.TraitValue_X, 
#'                                       vector.Trait_Y = vector.TraitValue_Y, 
#'                                       vector.Estimators = vector.Estimators)
#' 
#' 
#' Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
#'                                       string.Method = "PIC",
#'                                       vector.Trait_X = vector.TraitValue_X, 
#'                                       vector.Trait_Y = vector.TraitValue_Y, 
#'                                       vector.Estimators = vector.Estimators)
#'                                       
#########################################
# Conduct.Robust_PhylogeneticRegression #
#########################################
Conduct.Robust_PhylogeneticRegression <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y, vector.Estimators, string.Method){
  
  ################
  # Check method #
  ################
  if (string.Method == "PGLS"){
    list.RESULTS <- Conduct.Robust_PhylogeneticRegression_PGLS(handle.Phylogeny, vector.Trait_X, vector.Trait_Y, vector.Estimators)
  }
  if (string.Method == "PIC"){
    list.RESULTS <- Conduct.Robust_PhylogeneticRegression_PIC(handle.Phylogeny, vector.Trait_X, vector.Trait_Y, vector.Estimators)
  }
  
  ##########
  # RETURN #
  ##########
  return(list.RESULTS)
}