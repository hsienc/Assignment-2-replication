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
    │   │   ├── master.do                # !!!RUN THIS ONE!!!
    │   │   ├── temp                     # Store the generated sub-datasets
    │   │   └── results                  # Store the generated figures & .tex
    │   └── LISENSE.txt
    └── README.md                        # (Optional) Download this instruction

## Instruction 

Following the following steps to replicate Table 1 & Figure 2-5 in Schoellman (2006):

1. In `/raw-data/`, we only need `/census/usa_00131.dat`.
2. To construct necessary datasets for this exercise, download my modified version of codes above: `ec_adult-modified.do` and make sure you place it at the right path.

## References

Schoellman, Todd. (2016). Early childhood human capital and development. American Economic Jour-
nal: Macroeconomics, 8(3), 145–74. [https://doi.org/10.1257/mac.20150117](https://doi.org/10.1257/mac.20150117)

