# REPLICATION: SCHOELLMAN (2016) AEJ: MACRO
**Last edited:** February 14, 2024

## Table of Contents

- [Folder Structure](#Folder)
- [Data Construction](#Data)
- [References](#References)
  

## Folder 

Please download the newest version of [`Schoellman (2016) replication package`](https://www.openicpsr.org/openicpsr/project/114117/version/V2/view) and rename the package to `Replication package for ECHCD`. Here is a sample structure that your local directory may look like:

    . 
    ├── Replication package for ECHCD   # Downloaded replication pkg 
    │   ├── data   
    │   │   ├── readme.txt              # READ BEFORE EXECUTE master.do!
    │   │   ├── raw-data                      
    │   │   │   ├── census
    │   │   │   ├── census-1990
    │   │   │   ├── census-9000
    │   │   │   ├── parents-abroad      # See instructions below on how to construct this dataset
    │   │   │   └── iharp               # See instructions below on how to construct this dataset
    │   │   ├── (bunch of do files)  
    │   │   ├── master.do               # RUN THIS .DO FILE
    │   │   ├── results                 # Generated figures and tex files 
    │   │   └── temp   
    │   └── LICENSE.txt
    └── README.md                      

## Data 

In `/raw-data/`, we need to manually download `IPUMS` datasets and `IHARP` dataset into `/raw-data/parents-abroad/` and `/raw-data/iharp/`, respectively.

1. `IPUMS`: Register with IPUMS at [https://international.ipums.org/international/](https://international.ipums.org/international/) The extract needs to contain data on the following variables:
   > cntry year sample serial pernum wtper nchild age sex chborn yrschl educkh educvn empstat empstatd occ
   
   This extract should be placed in `/raw data/parents abroad/`.  Note that, to read in data successfully, one will need to modify lines 2254-2272 of `/data/ec_family.do` using the .do file provided with the extract so that the code executes correctly.

## References

Schoellman, Todd. (2016). Early childhood human capital and development. _American Economic Journal: Macroeconomics,_ 8(3), 145–74. [https://doi.org/10.1257/mac.20150117](https://doi.org/10.1257/mac.20150117)
