# REPLICATION: Garthwaite et al. (2014) QJE
**Last edited:** February 15, 2024

## Table of Contents

- [Folder Structure](#Folder)
- [Data Construction](#Data)
- [References](#References)
  

## Folder 

Please download the newest version of [`Garthwaite et al. (2014) replication package`](http://www.nber.org/~notom/ggn-replication-kit.zip) and check/rename the package to `ggn-replication-kit`. Here is the main structure that your local directory may look like:

    . 
    ├── ggn-replication-kit              # Your downloaded replication pkg 
    │   ├── do
    │   │   ├── summary.do               # RUN THIS .DO FILE
    │   │   ├── README.md                # A very "succinct" README file From Authors
    │   │   └── (bunch of do files)
    │   ├── dta                          # Raw data; consider download new CPS data from [https://cps.ipums.org/cps/](https://cps.ipums.org/cps/)
    │   ├── gph                          # Generated figures
    │   ├── log  
    └── └── src  

## Data 

In `/raw-data/`, we need to manually download `IPUMS` datasets and `IHARP` dataset into `/raw-data/parents-abroad/` and `/raw-data/iharp/`, respectively.

1. `IPUMS`: Register with IPUMS at [https://international.ipums.org/international/](https://international.ipums.org/international/). Your extract needs to contain data on the following variables:
   > cntry year sample serial pernum wtper nchild age sex chborn yrschl educkh educvn empstat empstatd occ
   
   This extract should be placed in `/raw data/parents abroad/`. Note that, “detailed” codes are automatically included in extracts for selected variables in IPUMS USA. So, selecting EMPSTAT simultaneously contain both `EMPSTAT` (general) and `EMPSTATD` (detailed) in our desirable variable list. Also note that, to read in data successfully, one will need to modify `lines 2254-2272` of `/data/ec_family.do` using the .do file provided with the extract.

## References

Craig Garthwaite, Tal Gross, Matthew J. Notowidigdo, Public Health Insurance, Labor Supply, and Employment Lock , The Quarterly Journal of Economics, Volume 129, Issue 2, May 2014, Pages 653–696, [https://doi.org/10.1093/qje/qju005](https://doi.org/10.1093/qje/qju005)
