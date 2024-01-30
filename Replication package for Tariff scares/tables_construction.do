
*** This file replicates the tables in "Tariff Scares: Trade policy uncertainty and foreign market entry by Chinese firms" by Crowley, Meng and Song.
*** These files are for replication purposes only.
*** There are two main data files: cutom_manu.dta and custom_trad.dta
***    - cutom_manu.dta contains data from all manufacturing exporters used for the regressions
***    - cutom_trad.dta contains data from all trading exporters used for the regressions


/* ***************************************************************************** */
/* ** TABLE 3: Impact on a product targeted by trade policy in a third market ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

/* entry of existing products */
drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table3, tex ctitle(entry existing products) append keep(AD_1 GDP RER)

/* entry of all products */
use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe entry AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m1
outreg2 m1 using table3, tex ctitle(entry all products) append keep(AD_1 GDP RER)

/* exit */
reghdfe exiths6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table3, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

/* entry of existing products */
drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table3, tex ctitle(entry existing products) append keep(AD_1 GDP RER)

/* entry of all products */
use mod\custom_trad.dta, clear
drop if ad==1
drop if ad1==1
reghdfe entry AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m1
outreg2 m1 using table3, tex ctitle(entry all products) append keep(AD_1 GDP RER)

/* exit */
reghdfe exiths6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table3, tex ctitle(exit) append keep(AD_1 GDP RER)


/* **************************************************************************************** */
/* ** TABLE 4: Heterogeneous impact on a product targeted by trade policy in a third market ** */
/* **************************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

/* entry of existing products */
drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(entry existing products) append keep(AD_1 GDP RER)

/* entry of all products */
use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe entry AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(entry all products) append keep(AD_1active AD_1other GDP RER)

/* exit */
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta;

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

/* entry of existing products */
drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(entry existing products) append keep(AD_1 GDP RER)

/* entry of all products */
use mod\custom_trad.dta, clear
drop if ad==1
drop if ad1==1
reghdfe entry AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(entry all products) append keep(AD_1active AD_1other GDP RER)

/* exit */
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table4, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ***************************************************************************** */
/* ** TABLE 5: Impact on closely-related products in third markets ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs4_1==1 & ad1firm==1

drop if prdi==0
drop if ad==1
drop if ad1==1
drop if ADhs6_1==1
reghdfe entryhs6 AD_1 GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table5, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
drop if ADhs6==1
reghdfe exiths6 AD_1 GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table5, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs4_1==1 & ad1firm==1

drop if prdi==0
drop if ad==1
drop if ad1==1
drop if ADhs6_1==1
reghdfe entryhs6 AD_1 GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table5, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_trad.dta, clear
drop if ad==1
drop if ad1==1
drop if ADhs6==1
reghdfe exiths6 AD_1 GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table5, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ***************************************************************************** */
/* ** TABLE 6: Heterogeneous impact on closely-related products in a third market ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs4_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share
gen AD_1core=AD_1*core

drop if prdi==0
drop if ad==1
drop if ad1==1
drop if ADhs6_1==1
reghdfe entryhs6 AD_1active AD_1other core GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table6, tex ctitle(entry) append keep(AD_1active AD_1other core GDP RER)

use mod\custom_manu.dta, clear
drop if ad1==1
drop if ad==1
drop if ADhs6==1
reghdfe exiths6 AD_1 share AD_1share AD_1core core GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table6, tex ctitle(exit) append keep(AD_1 share AD_1share AD_1core core GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs4_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share
gen AD_1core=AD_1*core

drop if prdi==0
drop if ad==1
drop if ad1==1
drop if ADhs6_1==1
reghdfe entryhs6 AD_1active AD_1other core GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table6, tex ctitle(entry) append keep(AD_1active AD_1other core GDP RER)

use mod\custom_trad.dta, clear
drop if ad1==1
drop if ad==1
drop if ADhs6==1
reghdfe exiths6 AD_1 share AD_1share AD_1core core GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table6, tex ctitle(exit) append keep(AD_1 share AD_1share AD_1core core GDP RER)


/* ***************************************************************************** */
/* ** TABLE 7: Export agglomeration and trade policy shocks ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1ExpArea=AD_1*ExpArea

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
keep if ad1firm==0
reghdfe entryhs6 AD_1 ExpArea AD_1ExpArea GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table7, tex ctitle(entry) append keep(AD_1 ExpArea AD_1ExpArea GDP RER)

use mod\custom_manu.dta, clear
drop if ad1==1
drop if ad==1
keep if adfirm==0
reghdfe exiths6 AD_1 ExpArea AD_1ExpArea GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table7, tex ctitle(exit) append keep( AD_1 ExpArea AD_1ExpArea GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1ExpArea=AD_1*ExpArea

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
keep if ad1firm==0
reghdfe entryhs6 AD_1 ExpArea AD_1ExpArea GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table7, tex ctitle(entry) append keep(AD_1 ExpArea AD_1ExpArea GDP RER)

use mod\custom_trad.dta, clear
drop if ad1==1
drop if ad==1
keep if adfirm==0
reghdfe exiths6 AD_1 ExpArea AD_1ExpArea GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table7, tex ctitle(exit) append keep( AD_1 ExpArea AD_1ExpArea GDP RER)


/* ***************************************************************************** */
/* ** TABLE 8: The intensity of policy information in a prefecture and firm entry ** */
/* ***************************************************************************** */

clear
use mod\custom_manu.dta

*Generate the interacted variables;
gen intensityactive=intensity*active
gen intensityother=intensity*(1-active)
gen intensitydactive=intensityd*active
gen intensitydother=intensityd*(1-active)

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
keep if ad1firm==0
reghdfe entryhs6 intensity GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m1
outreg2 m1 using table8, tex ctitle(entry) append keep(intensity GDP RER)
reghdfe entryhs6 intensityactive intensityother GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m2
outreg2 m2 using table8, tex ctitle(entry) append keep(intensityactive intensityother GDP RER)
reghdfe entryhs6 intensityd GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m3
outreg2 m3 using table8,tex ctitle(entry) append keep(intensityd GDP RER)
reghdfe entryhs6 intensitydactive intensitydother GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m4
outreg2 m4 using table8, tex ctitle(entry) append keep(intensitydactive intensitydother GDP RER)


/* ***************************************************************************** */
/* ** TABLE 9: Impact of a tariff scare: propensity score matching with a one-to-one match ** */
/* ***************************************************************************** */

//PSM with one-to-one match
/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1

gen tmp=runiform()
sort tmp
psmatch2 AD_1 GDP RER i.year i.indid i.countryid, out(entryhs6) neighbor(1) noreplace common ties
drop if _weight==.
save mod\psm_manu.dta

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table9, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table9, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1

gen tmp=runiform()
sort tmp
psmatch2 AD_1 GDP RER i.year i.indid i.countryid, out(entryhs6) neighbor(1) noreplace common ties
drop if _weight==.
save mod\psm_trad.dta

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table9, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table9, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ***************************************************************************** */
/* ** TABLE 10: Impact of a tariff scare: Matching with a PSM of score at or above the 90th percentile ** */
/* ***************************************************************************** */

//PSM with score at or above the 90th percentile
/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1

gen tmp=runiform()
sort tmp
psmatch2 AD_1 GDP RER i.year i.indid i.countryid, out(entryhs6) neighbor(1) common ties
drop if _weight==.
xtile ps=_pscore, nq(100)
drop if ps<90

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table10, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table10, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1

gen tmp=runiform()
sort tmp
psmatch2 AD_1 GDP RER i.year i.indid i.countryid, out(entryhs6) neighbor(1) common ties
drop if _weight==.
xtile ps=_pscore, nq(100)
drop if ps<90

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table10, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 AD_1share share GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table10, tex ctitle(exit) append keep(AD_1 AD_1share share GDP RER)


/* ***************************************************************************** */
/* ** TABLE 11: Impact on not closely-related products ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
drop if ADhs4==1
drop if ADhs4_1==1
gen AD_1=0
replace AD_1=1 if ad1firm==1

reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table11, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table11, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
drop if ADhs4==1
drop if ADhs4_1==1
gen AD_1=0
replace AD_1=1 if ad1firm==1

reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table11, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table11, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ***************************************************************************** */
/* ** TABLE 13: Table 3 and Table 4 entry estimates using data on all HS06 product codes ** */
/* ***************************************************************************** */

//construct sample without matching with antidumping HS04
clear
use mod\custom.dta 
keep if trading==0
save mod\cus_manu.dta
use mod\custom.dta, clear
keep if trading==1
save mode\cus_trad.dta

/* ** manufacturing firms ** */
clear
use mod\cus_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table13, tex ctitle(entry) append keep(AD_1 GDP RER)

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table13, tex ctitle(entry) append keep(AD_1 GDP RER)


/* ** trading firms ** */
clear
use mod\cus_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

*Generate the interacted variables;
gen AD_1active=AD_1*active
gen AD_1other=AD_1*(1-active)
gen AD_1share=AD_1*share

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP RER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table13, tex ctitle(entry) append keep(AD_1 GDP RER)

reghdfe entryhs6 AD_1active AD_1other GDP RER , a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table13, tex ctitle(entry) append keep(AD_1 GDP RER)


/* ***************************************************************************** */
/* ** TABLE 14: The impact on targeted products with growth in the exchange rate ** */
/* ***************************************************************************** */

/* ** manufacturing firms ** */
clear
use mod\custom_manu.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP dRER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table14, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 GDP dRER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table14, tex ctitle(exit) append keep(AD_1 GDP RER)


/* ** trading firms ** */
clear
use mod\custom_trad.dta

*Generate treatment variable;
gen AD_1=0
replace AD_1=1 if ADhs6_1==1 & ad1firm==1

drop if prdsw==1
drop if prdi==0
drop if ad==1
drop if ad1==1
reghdfe entryhs6 AD_1 GDP dRER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table14, tex ctitle(entry) append keep(AD_1 GDP RER)

use mod\custom_manu.dta, clear
drop if ad==1
drop if ad1==1
reghdfe exiths6 AD_1 GDP dRER, a(fFE=firmid cFE=countryid iFE=indid) cluster(indid countryid)
est store m
outreg2 m using table14, tex ctitle(exit) append keep(AD_1 GDP RER)
