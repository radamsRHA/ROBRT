#' Conduct.Robust_PhylogeneticRegression_PGLS: function to conduct robust phylogenetic regression using L2, L1, S, M, and/or MM
#'
#' This function returns a list of robust phylogenetic regression results for L2, L1, S, M, and/or MM
#' @param handle.Phylogeny Phylogeny object that is used to compute PGLS
#' @param vector.Trait_X Vector containing values for independent (predictor) trait X
#' @param vector.Trait_Y Vector containing values for dependent (response) trait y
#' @param vector.Estimators Vector where each element is a string that is "L1", "L2", "S", "M", or "MM"
#' @keywords Brownian motion, robust regression, phylogenetic comparative method, trait data
#' @return list.RESULTS List containing regression results for each estimator included in vector.Estimators
#' @export
#' @examples
#' 

#############################################
# Conduct.Robust_PhylogeneticRegression_PGLS #
#############################################
Conduct.Robust_PhylogeneticRegression_PGLS <- function(handle.Phylogeny, vector.Trait_X, vector.Trait_Y, vector.Estimators){
  
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
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PGLS_L2(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "L1"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PGLS_L1(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "S"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PGLS_S(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "M"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PGLS_M(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
    }
    if (string.Estimator == "MM"){
      handle.RESULTS_i <- Conduct.PhylogeneticRegression_PGLS_MM(handle.Phylogeny, vector.Trait_X, vector.Trait_Y)
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