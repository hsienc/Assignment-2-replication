# REPLICATION: SCHOELLMAN (2016) AEJ: MACRO
**Last edited:** February 14, 2024

## Table of Contents

- [Folder Structure](#Folder)
- [Data Construction](#Data)
- [References](#References)
  

## Folder 

Please download the newest version of [`Schoellman (2016) replication package`](https://www.openicpsr.org/openicpsr/project/114117/version/V2/view) and rename the package to `Replication package for ECHCD`. Here is a sample directory structure that your local folder may look like:

    . 
    ├── Replication package for ECHCD       # Downloaded replication pkg 
    │   ├── data   
    │   │   ├── readme.txt                  # Read BEFORE execute the dofiles!
    │   │   ├── raw-data                      
    │   │   │   ├── census
    │   │   │   ├── census-1990
    │   │   │   ├── census-9000
    │   │   │   ├── iharp                   # See instructions below to construct this dataset
    │   │   │   └── parents-abroad          # See instructions below to construct this dataset
    │   │   ├── (bunch of do files)  
    │   │   ├── results                     # Generated figures and tex files 
    │   │   └── temp                        
    └── README.md

## Data 

In `/raw-data`, we need to manually download two additional datasets into `/raw-data/iharp` and `/raw-data/parents-abroad`, respectively.

## References

Schoellman, Todd. (2016). Early childhood human capital and development. _American Economic Journal: Macroeconomics,_ 8(3), 145–74. [https://doi.org/10.1257/mac.20150117](https://doi.org/10.1257/mac.20150117)
