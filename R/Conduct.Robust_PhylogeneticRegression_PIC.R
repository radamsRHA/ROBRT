#' Conduct.Robust_PhylogeneticRegression_PIC: function to conduct robust phylogenetic regression using L2, L1, S, M, and/or MM
#'
#' This function returns a list of robust phylogenetic regression results for L2, L1, S, M, and/or MM
#' @param handle.Phylogeny Phylogeny object that is used to compute PICs
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependent (response) trait y
#' @param vector.Estimators Vector where each element is a string that is "L1", "L2", "S", "M", or "MM"
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
#' vector.Estimators <- c("L2", "L1", "M", "MM", "S")
#' 
#' ######################################
#' # conduct S phylogenetic regression #
#' ######################################
#' handle.RESULTS_PIC <- Conduct.Robust_PhylogeneticRegression_PIC(handle.Phylogeny = handle.Phylogeny, 
#'                                                                 vector.Trait_X = vector.TraitValue_X, 
#'                                                                 vector.Trait_Y = vector.TraitValue_Y, 
#'                                                                 vector.Estimators = vector.Estimators)

#############################################
# Conduct.Robust_PhylogeneticRegression_PIC #
#############################################
Conduct.Robust_PhylogeneticRegression_PIC <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y, vector.Estimators){
  
  ################################################
  # Summarize input estimators that will be used #
  ################################################
  numeric.NumberEstimators <- length(vector.Estimators)
  list.RESULTS <- list()
  
  ###########################
  # Loop through estimators #
  ###########################
  for (i in 1:numeric.NumberEstimators){
    
    ############################
    # get string for estimator #
    ############################
    handle.RESULTS_i <- NA # CLEAN
    string.Estimator <- vector.Estimators[i]
    
    #######################
    # check for estimator #
    #######################
    if (string.Estimator == "L2"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PIC_L2(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "L1"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PIC_L1(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "S"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PIC_S(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "M"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PIC_M(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "MM"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PIC_MM(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    
    ##########################
    # Append to results list #
    ##########################
    list.RESULTS[[i]] <- handle.RESULTS_i
  }
  
  ########################
  # Append names of list #
  ########################
  names(list.RESULTS) <- vector.Estimators
  
  ##########
  # RETURN #
  ##########
  return(list.RESULTS)
  
}