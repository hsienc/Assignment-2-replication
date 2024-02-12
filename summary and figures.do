*** This file replicates the summary statistics tables and figures in "Tariff Scares: Trade policy uncertainty and foreign market entry by Chinese firms" by Crowley, Meng and Song.
*** These files are for replication purposes only.
*** There are two main data files: cutom_manu.dta and custom_trad.dta
***    - cutom_manu.dta contains data from all manufacturing exporters used for the regressions
***    - cutom_trad.dta contains data from all trading exporters used for the regressions


/* ***************************************************************************** */
/* ** TABLE 2: Summary statistics ** */
/* ***************************************************************************** */

use mod\custom_manu.dta,clear
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
tabstat entryhs6 AD_1 AD_1active AD_1other GDP RER

use mod\custom_trad.dta,clear
gen AD_1share=AD_1*share
tabstat entryhs6 AD_1 share AD_1share GDP RER


/* ***************************************************************************** */
/* ** TABLE 15: Distribution of intensity ** */
/* ***************************************************************************** */

use mod\custom_manu.dta,clear
egen intens=cut(intensity), at(0(0.1)1)
tab ind


/* ***************************************************************************** */
/* ** FIGURE 11-12: Distribution of firms¡¯ total market scope 2001 vs. 2009 ** */
/* ***************************************************************************** */

use  mod\custom_manu.dta,clear
twoway (kdensity markets if year==2001) (kdensity markets if year==2009), //
legend(row(1)label(1 "year=2001 ") label(2 "year=2009")) ytitle("Density") xtitle("Total market scope")
graph save Graph mod\figure11

use  mod\custom_manu.dta,clear
twoway (kdensity markets if year==2001) (kdensity markets if year==2009), //
legend(row(1)label(1 "year=2001 ") label(2 "year=2009")) ytitle("Density") xtitle("Total market scope")
graph save Graph mod\figure12


/* ***************************************************************************** */
/* ** FIGURE 13: Distribution of the variable "intensity of policy information in a prefecture" ** */
/* ***************************************************************************** */

use  mod\custom_manu.dta,clear
histogram intensity if adf_count!=0, ytitle("Density") xtitle("Intensity")
graph save Graph mod\figure13




