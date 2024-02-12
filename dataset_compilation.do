/*This is the dataset compilation program for 
"Tariff Scares: Trade policy information and the extensive margin of Chinese exporting firms" 
by Meredith A. Crowley, Ning Meng, and Huasheng Song. */

*This file creates the main datasets for the project. In order to run this file,
*we need the following raw data sets:
*hg2000.dta
*hg2001.dta
*hg2002.dta
*hg2003.dta
*hg2004.dta
*hg2005.dta
*hg2006.dta
*hg2007.dta
*hg2008.dta
*hg2009.dta /yearly customs data from 2000-2009
*AD_China.dta /AD cases against China
*GDP.dta /GDP growth rate for countries
*RER.dta /real exchange rate for countries
*The files hgXXXX.dta are annual Chinese Customs Data and must be obtained from a data provider.

*STAGE 1 SAMPLE RESTRICTION
*use yearly Chinese Customs Data and data of antidumping cases against China
/*
hs6 = product id at HS06 level
hs_id = product id at HS08 level
party_id = exporting firm id
origin_id = destination country id
company = Chinese name of firms
value = export value for each observation at firm-product-destination-year
quantity = export quantity for each observation at firm-product-destination-year
*/

/*generate firms' product scope*/
forvalues i=0/9{
use  raw\hg200`i'.dta,clear
keep hs6 party_id year
duplicates drop hs6 party_id, force
bysort party_id: gen count=_n
bysort party_id: egen tprd=max(count)
save  mod\tprd200`i'.dta,replace
}
use mod\tprd2000.dta, clear
forvalues i=1/9{
append using mod\tprd200`i'.dta
save  mod\tprd.dta,replace
}
drop if party_id==""
drop hs6
duplicates drop party_id year, force
save mod\tprd.dta,replace

/*generate top 20 importing partners of China in each year*/
forvalues i=0/9{
use  raw\hg200`i'.dta,clear
egen tvalue=sum(value)
bysort origin_id: egen ovalue=sum(value)
duplicates drop origin_id,force 
gsort -ovalue
gen number=_n
gen pr=ovalue/tvalue
egen pr20=sum(pr) if number<=20
keep if number <= 20
keep year origin_id
save  mod\sort200`i'.dta,replace
}
use mod\sort2000.dta, clear
forvalues i=1/9{
append using mod\sort200`i'.dta
save  mod\top20.dta,replace
}

*add countries imposing antidumping
use raw\AD_China.dta
duplicates drop origin_id year, force
keep origin_id year
append using  mod\top20.dta
save  mod\top20.dta, replace

/*identify firms that exports continuously for at least two years*/
forvalues i=0/9{
use  raw\hg200`i'.dta,clear
keep party_id year
duplicates drop party_id , force
save mod\exist200`i'.dta
keep party_id
save mod\party200`i'.dta
}

forvalues i=1/9{
use mod\exist200`i'.dta, clear
sort party_id 
local j = `i'-1
merge m:m party_id using mod\party200`j'.dta
gen exist=0
replace exist=1 if _merge==3
drop if _merge==2
drop _merge
save mod\exist200`i'.dta,replace
}
use mod\exist2001.dta, clear
forvalues i=2/9{
append using mod\exist200`i'.dta
save  mod\exist.dta,replace
}

/*restrict sample and aggregate*/
use raw\AD_China.dta, clear
gen hs4=substr(hs6,1,4)
keep hs4
duplicates drop hs4, force
save mod\ad_hs4.dta

forvalues i=1/9{
use  raw\hg200`i'.dta,clear
sort party_id year
joinby party_id year using mod\tprd.dta
bysort hs6 party_id origin_id: egen maxprd=max(tprd)
drop if maxprd==1   /*keep only multi-product firms*/                  
joinby origin_id year using mod\top20.dta  /*keep top 20 importing countries and AD initiaters*/  
joinby party_id year using mod\exist.dta  
drop if exist==0    /*keep only continuously exporting firms*/ 
drop exist
save mod\custom200`i'.dta
}


use mod\custom2001.dta, clear
forvalues i=2/9{
append using  raw\custom200`i'.dta
compress
save  mod\custom.dta,replace
}


use mod\custom.dta, clear
gen trading=0
replace trading=1 if strmatch(company, "*进出口*")| strmatch(company, "*贸易*")|  ///
strmatch(company, "*商贸*")| strmatch(company, "*物流*")|strmatch(company, "*仓储*")| ///
strmatch(company, "*经贸*")| strmatch(company, "*科贸*")|strmatch(company, "*仓库*") 
drop company                                
save mod\custom.dta,replace             /*identify trading firms*/
keep if trading==0
joinby hs4 using mod\ad_hs4.dta  /*keep HS04 products involved in antidumping*/
save mod\custom_manu.dta
use mod\custom.dta, clear
keep if trading==1
joinby hs4 using mod\ad_hs4.dta  /*keep HS04 products involved in antidumping*/
save mode\custom_trad.dta



*STAGE 2 VARIABLES GENERATION

**generation of dependent variables
forvalues i=0/10{
use  raw\hg200`i'.dta,clear
keep party_id origin_id year
duplicates drop party_id origin_id year, force
save mod\poy200`i'.dta
keep party_id origin_id
duplicates drop party_id origin_id, force
save mod\po200`i'.dta
}

forvalues i=0/10{
use  raw\hg200`i'.dta,clear
keep year hs6 party_id
duplicates drop year hs6 party_id, force
save mod\phy200`i'.dta
keep hs6 party_id
duplicates drop hs6 party_id, force
save mod\ph200`i'.dta
}

*entry
forvalues i=1/9{
use mod\poy200`i'.dta, clear
sort party_id 
local j = `i'-1
merge m:m party_id origin_id using mod\po200`j'.dta
gen entry=0
replace entry=1 if _merge==1
drop if _merge==2
drop _merge
save mod\entry200`i'.dta,replace  
}
use mod\entry2001.dta, clear
forvalues i=2/9{
append using mod\entry200`i'.dta
save  mod\entry.dta,replace  /*here we get if a firm enter a new market*/
}

*exit
forvalues i=0/9{
use mod\poy200`i'.dta, clear
sort party_id 
local j = `i'+1
merge m:m party_id origin_id using mod\po200`j'.dta
gen exit=0
replace exit=1 if _merge==1
drop if _merge==2
drop _merge
save mod\exit200`i'.dta,replace  
}
use mod\exit2000.dta, clear
forvalues i=1/9{
append using mod\exit200`i'.dta
save  mod\exit.dta,replace  /*here we get if a firm exit a market*/
}
*identify products
forvalues i=1/10{
use mod\phy200`i'.dta, clear
sort party_id hs6
local j = `i'-1
merge m:m party_id hs6 using mod\ph200`j'.dta
gen prdi=0
replace prdi=1 if _merge==1
drop if _merge==2
drop _merge
save mod\prdi200`i'.dta,replace  
}
use mod\prdi2001.dta, clear
forvalues i=1/9{
append using mod\prdi200`i'.dta
save  mod\prdi.dta,replace  /*here we get a firm's products exported for at least two years */
}

use mod\custom_manu.dta, clear
merge m:m party_id origin_id year using mod\entry.dta
drop if _merge==2
drop _merge
merge m:m party_id origin_id year using mod\exit.dta
drop if _merge==2
drop _merge
merge m:m party_id hs6 year using mod\prdi.dta
drop if _merge==2
drop _merge
duplicates drop hs6 party_id origin_id year, force
gen entryhs6=0
replace entryhs6=1 if entry==1&prdi==1
gen exiths6=0
replace exiths6=1 if exit==1&prdi==1
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
merge m:m party_id origin_id year using mod\entry.dta
drop if _merge==2
drop _merge
merge m:m party_id origin_id year using mod\exit.dta
drop if _merge==2
drop _merge
merge m:m party_id hs6 year using mod\prdi.dta
drop if _merge==2
drop _merge
duplicates drop hs6 party_id origin_id year, force
gen entryhs6=0
replace entryhs6=1 if entry==1&prdi==1
gen exiths6=0
replace exiths6=1 if exit==1&prdi==1
save  mod\custom_trad.dta,replace


**generation of independent variables

*GDP growth rate and real exchange rate at t-1
use mod\custom_manu.dta, clear
merge m:m origin_id year using raw\GDP.dta
drop if _merge==2
drop _merge
merge m:m origin_id year using raw\RER.dta
drop if _merge==2
drop _merge
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
merge m:m origin_id year using raw\GDP.dta
drop if _merge==2
drop _merge
merge m:m origin_id year using raw\RER.dta
drop if _merge==2
drop _merge
save  mod\custom_trad.dta,replace

*identify AD on product-country level and product level at t&t-1
use raw\AD_China.dta
replace year=year+1
save raw\AD_1.dta

use mod\custom_manu.dta, clear
merge m:m hs6 origin_id year using raw\AD_China.dta
gen ad=0
replace ad=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m hs6 origin_id year using mod\AD_1.dta
gen ad1=0
replace ad1=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs6 using raw\AD_China.dta
gen ADhs6=0
replace ADhs6=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs6 using mod\AD_1.dta
gen ADhs6_1=0
replace ADhs6_1=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs4 using raw\AD_China.dta
gen ADhs4=0
replace ADhs4=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs4 using mod\AD_1.dta
gen ADhs4_1=0
replace ADhs4_1=1 if _merge==3
drop if _merge==2
drop _merge
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
merge m:m hs6 origin_id year using raw\AD_China.dta
gen ad=0
replace ad=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m hs6 origin_id year using mod\AD_1.dta
gen ad1=0
replace ad1=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs6 using raw\AD_China.dta
gen ADhs6=0
replace ADhs6=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs6 using mod\AD_1.dta
gen ADhs6_1=0
replace ADhs6_1=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs4 using raw\AD_China.dta
gen ADhs4=0
replace ADhs4=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m year hs4 using mod\AD_1.dta
gen ADhs4_1=0
replace ADhs4_1=1 if _merge==3
drop if _merge==2
drop _merge
save  mod\custom_trad.dta,replace

*identify firms facing AD
use mod\custom_manu.dta, clear
keep if ad==1
keep party_id year
duplicates drop party_id year, force
save  mod\adfirm_manu.dta
use mod\custom_manu.dta, clear
keep if ad1==1
keep party_id year
duplicates drop party_id year, force
save  mod\ad1firm_manu.dta
use mod\custom_manu.dta, clear
merge m:m party_id year using mod\adfirm_manu.dta
gen adfirm=0
replace adfirm=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m party_id year using mod\ad1firm_manu.dta
gen ad1firm=0
replace ad1firm=1 if _merge==3
drop if _merge==2
drop _merge
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
keep if ad==1
keep party_id year
duplicates drop party_id year, force
save  mod\adfirm_trad.dta
use mod\custom_trad.dta, clear
keep if ad1==1
keep party_id year
duplicates drop party_id year, force
save  mod\ad1firm_trad.dta
use mod\custom_trad.dta, clear
merge m:m party_id year using mod\adfirm_trad.dta
gen adfirm=0
replace adfirm=1 if _merge==3
drop if _merge==2
drop _merge
merge m:m party_id year using mod\ad1firm_trad.dta
gen ad1firm=0
replace ad1firm=1 if _merge==3
drop if _merge==2
drop _merge
save  mod\custom_trad.dta,replace

*identify product switching
use mod\custom_manu.dta, clear
merge m:m year hs4 origin_id using raw\AD_1.dta
gen prdsw=0
replace prdsw=1 if _merge==3
drop if _merge==2
drop _merge
keep year party_id hs6 origin_id prdsw
duplicates drop year party_id hs6 origin_id,force
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
merge m:m year hs4 origin_id using raw\AD_1.dta
gen prdsw=0
replace prdsw=1 if _merge==3
drop if _merge==2
drop _merge
keep year party_id hs6 origin_id prdsw
duplicates drop year party_id hs6 origin_id,force
save  mod\custom_trad.dta,replace

*identify active users & generate market share & core product
use mod\custom_manu.dta, clear
merge m:m origin_id using  mod\active.dta 
drop if _merge==2
drop _merge
merge m:m hs6 party_id year using mod\core.dta 
drop if _merge==2
drop _merge
bysort year hs6 party_id origin_id: egen povalue=sum(value)
bysort year hs6 origin_id: egen ovalue=sum(value)
gen share=povalue/ovalue
save  mod\custom_manu.dta,replace

use mod\custom_trad.dta, clear
merge m:m origin_id using  mod\active.dta 
drop if _merge==2
drop _merge
merge m:m hs6 party_id year using mod\core.dta 
drop if _merge==2
drop _merge
bysort year hs6 party_id origin_id: egen povalue=sum(value)
bysort year hs6 origin_id: egen ovalue=sum(value)
gen share=povalue/ovalue
save  mod\custom_trad.dta,replace

*generate agglomeration variables
*area of export agglomeration
use mod\custom_manu.dta, clear
keep party_id year value hs6
bysort year zip3 hs6: egen area=sum(value)
bysort year hs6: egen total=sum(value)
gen expindex=area/total 
drop total area
xtile exp_pc100=expindex,nq(100)
duplicates drop hs6 party_id year, force
save mod\expindex_manu.dta
use mod\custom_trad.dta, clear
keep party_id year value hs6
bysort year zip3 hs6: egen area=sum(value)
bysort year hs6: egen total=sum(value)
gen expindex=area/total 
drop total area
xtile exp_pc100=expindex,nq(100)
duplicates drop hs6 party_id year, force
save mod\expindex_trad.dta

use mod\custom_manu.dta, clear
merge m:m year party_id hs6 using mod\expindex_manu.dta
drop if _merge==2
drop _merge
gen ExpArea=0
replace ExpArea=1 if exp_pc100>75
replace ExpArea=. if expindex==.
save mod\custom_manu.dta, replace
use mod\custom_trad.dta, clear
merge m:m year party_id hs6 using mod\expindex_manu.dta
drop if _merge==2
drop _merge
gen ExpArea=0
replace ExpArea=1 if exp_pc100>75
replace ExpArea=. if expindex==.
save mod\custom_trad.dta, replace

*area of trade policy intensity
//count the number of firms exporting hs06 in a prefecture
use mod\custom_manu.dta, clear
keep hs6 party_id year
duplicates drop hs6 party_id year, force
bysort year zip3 hs6: gen f_id=_n
bysort year zip3 hs6: egen f_count=max(f_id)
duplicates drop year hs6 zip3, force
keep year hs6 zip3 f_count
save mod\fcount_manu.dta
use mod\custom_trad.dta, clear
keep hs6 party_id year
duplicates drop hs6 party_id year, force
bysort year zip3 hs6: gen f_id=_n
bysort year zip3 hs6: egen f_count=max(f_id)
duplicates drop year hs6 zip3, force
keep year hs6 zip3 f_count
save mod\fcount_trad.dta
//count the number of firms exporting hs06 in a prefecture directly impacted by AD at t-1
use mod\custom_manu.dta, clear
keep if ad1==1
keep hs6 party_id year
duplicates drop hs6 party_id year, force
bysort year zip3 hs6: gen adf_id=_n
bysort year zip3 hs6: egen adf_count=max(adf_id)
duplicates drop year hs6 zip3, force
keep year hs6 zip3 adf_count
save mod\adfcount_manu.dta
use mod\custom_trad.dta, clear
keep if ad1==1
keep hs6 party_id year
duplicates drop hs6 party_id year, force
bysort year zip3 hs6: gen adf_id=_n
bysort year zip3 hs6: egen adf_count=max(adf_id)
duplicates drop year hs6 zip3, force
keep year hs6 zip3 adf_count
save mod\adfcount_trad.dta

use mod\custom_manu.dta, clear
merge m:m year hs6 zip3 using mod\adfcount_manu.dta
drop if _merge==2
drop _merge
replace adf_count=0 if adf_count==.&zip3!=""
merge m:m year hs6 zip3 using mod\fcount_manu.dta
drop if _merge==2
drop _merge
duplicates drop year party_id origin_id hs6, force
gen intensity=adf_count/f_count
gen intensityd=0
replace intensityd=1 if intensity>0.1
replace intensityd=. if intensity==.
save mode\cutom_manu.dta, replace
use mod\custom_trad.dta, clear
merge m:m year hs6 zip3 using mod\adfcount_manu.dta
drop if _merge==2
drop _merge
replace adf_count=0 if adf_count==.&zip3!=""
merge m:m year hs6 zip3 using mod\fcount_manu.dta
drop if _merge==2
drop _merge
duplicates drop year party_id origin_id hs6, force
gen intensity=adf_count/f_count
gen intensityd=0
replace intensityd=1 if intensity>0.1
replace intensityd=. if intensity==.
save mode\cutom_trad.dta, replace

