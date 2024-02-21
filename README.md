# REPLICATION: Schoellman (2016) AEJ: Macro
**Last edited:** February 21, 2024

See the latest version of Replication report [here](https://github.com/hsienc/econ_580_assignment_2/blob/a1671584a91817c2184b8adb1bc6eaaa75b9bf52/Eric_ECON580_Replication_report_5_page.pdf)

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

1. Download the newest version of [`Schoellman (2016) replication package`](https://www.openicpsr.org/openicpsr/project/114117/version/V2/view). This instruction is based on v2.
2. In `/raw-data/`, we check if `/census/usa_00131.dat` is contained.
3. To construct necessary datasets, download my modified version of codes above: `ec_adult-modified.do` and `master-modified.do`.
4. Make sure you place them at the right path- folder structure sees above.
5. (Optional)  See `/data/readme.txt` if you want to do more Robustness checks. One needs to download two additional datasets & waits for approval.
6. Open `/data/master-modified.do` and ensure it carries out the program `ec_adult-modified.do`.
7. Section 1 is mainly Data importation and cleaning, which takes roughly 3-4 hours.
8. We will save a subset of samples `/temp/census_sample_tenPercentDummy.dta` at the end of Section 1. This subset of data excludes 90% of the natives data, which are relatively irrelavant to the paper focus but significantly saves running time (only takes ~2 minutes to load in).
9. Section 2 is the results replications. I modified the fixed effect regressions in the original package and calculate estimates of our variables of interest, their standard errors, and confidence intervals separately. It yields the same estimates.
10. Check the Table 1 and Figure 2-5 in the original paper and see if they are "consistent".

Note. My observations have discrepancies with the original Schoellman (2006) paper. I suspect this was due to some memory error when loading in the raw data `/census/usa_00131.dat`. The total observations loaded in from `usa_00131.dat` are around 29,800,000 during my replication process. The results and graphs are fairly consistent with the original paper.    

## References

Schoellman, Todd. (2016). Early childhood human capital and development. American Economic Jour-
nal: Macroeconomics, 8(3), 145–74. [https://doi.org/10.1257/mac.20150117](https://doi.org/10.1257/mac.20150117)

