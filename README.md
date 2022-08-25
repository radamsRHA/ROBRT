---
output:
  html_document: default
  pdf_document: default
---

---
# ROBRT: ROBust Regression on Trees
**NOTE See the file https://github.com/radamsRHA/ROBRT/blob/master/ROBRT.pdf for detailed instructions**

## Installing R package ROBRT from github
The R package ROBRT is freely available to download and distribute from github <https://github.com/radamsRHA/ROBRT/>. To install and load ROBRT, you must first install the R package `devtools`, 

```
install.packages("devtools")
```
Now using devtools we can install `ROBRT` from github:

```
library(devtools)
install_github("radamsRHA/ROBRT")
library(ROBRT) # Load package 
```
`ROBRT` also requires the following dependencies to be installed:

```
install.packages('geiger')  
install.packages('phytools')  
install.packages('MASS')  
install.packages('L1pack')  
install.packages('robust')  
install.packages('sfsmisc')  
```
To begin using `ROBRT` try using the examples associated with each function. Importantly, the 5 estimators can be conducted for both PGLS and PIC phylogenetic regression using the primary function `Conduct.Robust_PhylogeneticRegression` with specific options. See examples below:

## Example: L2 with PIC

We can use `Conduct.Robust_PhylogeneticRegression` with option "PIC" and "L2" in vector.Estimators to run the L2 phylogenetic regression with PIC for a given datasets. First, let's load the R package `ROBRT` and its dependancies:

```
################
# Load depends #
################
library(ROBRT)
library('geiger')  
library('phytools')  
library('MASS')  
library('L1pack')  
library('robust')  
library('sfsmisc')  
```

Now, let's simulate a random phylogenetic tree and trait data for two statistically independent traits X and Y


```
################################
# simulate tree and trait data #
################################
handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
```


Next, let's conduct the PIC regression with L2

```
#######################
# Set to L2 estimator #
#######################
vector.Estimators <- c("L2")

Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
                                      string.Method = "PIC",
                                      vector.Trait_X = vector.TraitValue_X, 
                                      vector.Trait_Y = vector.TraitValue_Y, 
                                      vector.Estimators = vector.Estimators)
```

## Example: L2 with PGLS

We can use `Conduct.Robust_PhylogeneticRegression` with option "PGLS" to run L2 regression with PGLS



```
################################
# simulate tree and trait data #
################################
handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.Estimators <- c("L2")

#############################
# conduct robust regression #
#############################
Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
                                      string.Method = "PGLS",
                                      vector.Trait_X = vector.TraitValue_X, 
                                      vector.Trait_Y = vector.TraitValue_Y, 
                                      vector.Estimators = vector.Estimators)
```


## Example: Run PIC with five different estimators for phylogenetic regression

We can use `Conduct.Robust_PhylogeneticRegression` with option "PIC" and provide a vector containing all five estimators (L2, L1, M, S, and MM) to automate analyses


Let's try with simulating another dataset and running altogether 

```
################################
# simulate tree and trait data #
################################
handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.Estimators <- c("L2", "L1", "M", "S", "MM") # we want to run all five estimators

#############################
# conduct robust regression #
#############################
Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
                                      string.Method = "PIC",
                                      vector.Trait_X = vector.TraitValue_X, 
                                      vector.Trait_Y = vector.TraitValue_Y, 
                                      vector.Estimators = vector.Estimators)

```

## Example: Run PGLS with five different estimators for phylogenetic regression

We can use `Conduct.Robust_PhylogeneticRegression` with option "PGLS" and provide a vector containing all five estimators (L2, L1, M, S, and MM) to automate analyses


Let's try with simulating another dataset and running altogether 

```
################################
# simulate tree and trait data #
################################
handle.Phylogeny <- sim.bdtree(b = 1, n = 10)
vector.TraitValue_X <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.TraitValue_Y <- sim.char(handle.Phylogeny, par=1, model="BM", root=0)[,,1] # traits are independent 
vector.Estimators <- c("L2", "L1", "M", "S", "MM") # we want to run all five estimators

#############################
# conduct robust regression #
#############################
Conduct.Robust_PhylogeneticRegression(handle.Phylogeny = handle.Phylogeny, 
                                      string.Method = "PGLS",
                                      vector.Trait_X = vector.TraitValue_X, 
                                      vector.Trait_Y = vector.TraitValue_Y, 
                                      vector.Estimators = vector.Estimators)

```
