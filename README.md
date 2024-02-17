# REPLICATION: Schoellman (2016) AEJ: Macro
**Last edited:** February 17, 2024

## Table of Contents

- [Folder Structure](#Folder)
- [Replication Instruction](#Replication)
- [References](#References)
  

## Folder 

Please download the newest version of [`Schoellman (2016) replication package`](https://www.openicpsr.org/openicpsr/project/114117/version/V2/view) here and check/rename the package to `Replication package for ECHCD`. The main structure of your local directory may look like:

    . 
    ├── Replication package for ECHCD    # Your downloaded replication pkg 
    │   ├── data
    │   │   ├── readme.txt               # READ before executing the master.do!
    │   │   ├── raw-data                 
    │   │   │    ├── census              # Only need this for the main results Table 1 & Figure 2-5
    │   │   │    └── (other census)
    │   │   ├── ec_adult-modified.do     # Download this dofile from my repo above
    │   │   ├── master-modified.do       # Download this dofile from my repo above & RUN THIS ONE!
    │   │   ├── temp                     # Store the generated sub-datasets
    │   │   └── results                  # Store the generated figures & .tex
    │   └── LISENSE.txt
    └── README.md                        # (Optional) Download this instruction

## Instruction 

Following the following steps to replicate Table 1 & Figure 2-5 in Schoellman (2006):

1. In `/raw-data/`, we only need `/census/usa_00131.dat`.
2. See `/data/readme.txt` if you want to do Robustness checks.
3. To construct necessary datasets, download my modified version of codes above: `ec_adult-modified.do` and make sure you place it at the right path.
4. Open `/data/master-modified.do` and ensure it carries out the program `ec_adult-modified.do`.
5. Section 1 is mainly Data importation and cleaning, which takes roughly 3-4 hours.
6. We will save a subset of samples `/temp/census_sample_tenPercentDummy.dta` at the end of Section 1. This subset of data excludes 90% of the natives data, which are relatively irrelavant to the paper focus but significantly saves running time (only takes ~2 minutes to load in).
7. Section 2 is the results replications. Note that I modified the fixed effect regressions in the original package and calculate estimates of our variables of interest, their standard errors, and confidence intervals separately. It yields the same estimates.
8. Check the Table 1 and Figure 2-5 in the original paper and see if they are "consistent". 

## References

Schoellman, Todd. (2016). Early childhood human capital and development. American Economic Jour-
nal: Macroeconomics, 8(3), 145–74. [https://doi.org/10.1257/mac.20150117](https://doi.org/10.1257/mac.20150117)

