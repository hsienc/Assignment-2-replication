/*
*************************************************************************************
*************************************************************************************
*************************************************************************************

ec_adult-modified.do

Original package: https://www.openicpsr.org/openicpsr/project/114117/version/V2/view

Modified by Eric Hsienchen Chu

This file estimates the adult socioeconomic outcomes of Indochinese refugees as a function
of their age at arrival to the United States in Schoellman (2006). 

Steps:
1.  Setup and manipulation of external files.
2.  Main group testing.

*************************************************************************************
*************************************************************************************
*************************************************************************************

*/

/*

*************************************************************************************
*************************************************************************************
*************************************************************************************

Step 1. Setup and manipulation of external files.

*************************************************************************************
*************************************************************************************
*************************************************************************************

*/

*
* 1.1: Set up program, assign memory, read in data.
*

	log using ec_adult.smcl, replace
	clear all
	set maxvar 10000
	set matsize 10000
	set more off
	set scheme sj

	quietly infix               ///
	  int     year       1-4    ///
	  byte    statefip   5-6    ///
	  int     metaread   10-13  ///
	  long    puma       14-18  ///
	  byte    gq         19-19  ///
	  float   perwt      20-29  ///
	  int     age        30-32  ///
	  byte    sex        33-33  ///
	  byte    marst      34-34  ///
	  byte    marrno     35-35  ///
	  int     raced      37-39  ///
	  long    bpld       43-47  ///
	  int     yrimmig    48-51  ///
	  int     languaged  54-57  ///
	  byte    speakeng   58-58  ///
	  byte    school     59-59  ///
	  int     educd      62-64  ///
	  byte    empstat    65-65  ///
	  byte    labforce   68-68  ///
	  byte    classwkrd  70-71  ///
	  byte    wkswork1   72-73  ///
	  byte    wkswork2   74-74  ///
	  byte    uhrswork   75-76  ///
	  long    incwage    77-82  ///
	  using `"./raw data/census/usa_00131.dat"'

* PLEASE BE PATIENT WHEN LOADING IN THIS DAT FILE

	replace perwt     = perwt     / 100

	format perwt     %10.2f

	label var year      `"Census year"'
	label var statefip  `"State (FIPS code)"'
	label var metaread  `"Metropolitan area [detailed version]"'
	label var puma      `"Public Use Microdata Area"'
	label var gq        `"Group quarters status"'
	label var perwt     `"Person weight"'
	label var age       `"Age"'
	label var sex       `"Sex"'
	label var marst     `"Marital status"'
	label var marrno    `"Times married"'
	label var raced     `"Race [detailed version]"'
	label var bpld      `"Birthplace [detailed version]"'
	label var yrimmig   `"Year of immigration"'
	label var languaged `"Language spoken [detailed version]"'
	label var speakeng  `"Speaks English"'
	label var school    `"School attendance"'
	label var educd     `"Educational attainment [detailed version]"'
	label var empstat   `"Employment status [general version]"'
	label var labforce  `"Labor force status"'
	label var classwkrd `"Class of worker [detailed version]"'
	label var wkswork1  `"Weeks worked last year"'
	label var wkswork2  `"Weeks worked last year, intervalled"'
	label var uhrswork  `"Usual hours worked per week"'
	label var incwage   `"Wage and salary income"'

	label define year_lbl 1850 `"1850"'
	label define year_lbl 1860 `"1860"', add
	label define year_lbl 1870 `"1870"', add
	label define year_lbl 1880 `"1880"', add
	label define year_lbl 1900 `"1900"', add
	label define year_lbl 1910 `"1910"', add
	label define year_lbl 1920 `"1920"', add
	label define year_lbl 1930 `"1930"', add
	label define year_lbl 1940 `"1940"', add
	label define year_lbl 1950 `"1950"', add
	label define year_lbl 1960 `"1960"', add
	label define year_lbl 1970 `"1970"', add
	label define year_lbl 1980 `"1980"', add
	label define year_lbl 1990 `"1990"', add
	label define year_lbl 2000 `"2000"', add
	label define year_lbl 2001 `"2001"', add
	label define year_lbl 2002 `"2002"', add
	label define year_lbl 2003 `"2003"', add
	label define year_lbl 2004 `"2004"', add
	label define year_lbl 2005 `"2005"', add
	label define year_lbl 2006 `"2006"', add
	label define year_lbl 2007 `"2007"', add
	label define year_lbl 2008 `"2008"', add
	label define year_lbl 2009 `"2009"', add
	label define year_lbl 2010 `"2010"', add
	label define year_lbl 2011 `"2011"', add
	label values year year_lbl

	label define statefip_lbl 01 `"Alabama"'
	label define statefip_lbl 02 `"Alaska"', add
	label define statefip_lbl 04 `"Arizona"', add
	label define statefip_lbl 05 `"Arkansas"', add
	label define statefip_lbl 06 `"California"', add
	label define statefip_lbl 08 `"Colorado"', add
	label define statefip_lbl 09 `"Connecticut"', add
	label define statefip_lbl 10 `"Delaware"', add
	label define statefip_lbl 11 `"District of Columbia"', add
	label define statefip_lbl 12 `"Florida"', add
	label define statefip_lbl 13 `"Georgia"', add
	label define statefip_lbl 15 `"Hawaii"', add
	label define statefip_lbl 16 `"Idaho"', add
	label define statefip_lbl 17 `"Illinois"', add
	label define statefip_lbl 18 `"Indiana"', add
	label define statefip_lbl 19 `"Iowa"', add
	label define statefip_lbl 20 `"Kansas"', add
	label define statefip_lbl 21 `"Kentucky"', add
	label define statefip_lbl 22 `"Louisiana"', add
	label define statefip_lbl 23 `"Maine"', add
	label define statefip_lbl 24 `"Maryland"', add
	label define statefip_lbl 25 `"Massachusetts"', add
	label define statefip_lbl 26 `"Michigan"', add
	label define statefip_lbl 27 `"Minnesota"', add
	label define statefip_lbl 28 `"Mississippi"', add
	label define statefip_lbl 29 `"Missouri"', add
	label define statefip_lbl 30 `"Montana"', add
	label define statefip_lbl 31 `"Nebraska"', add
	label define statefip_lbl 32 `"Nevada"', add
	label define statefip_lbl 33 `"New Hampshire"', add
	label define statefip_lbl 34 `"New Jersey"', add
	label define statefip_lbl 35 `"New Mexico"', add
	label define statefip_lbl 36 `"New York"', add
	label define statefip_lbl 37 `"North Carolina"', add
	label define statefip_lbl 38 `"North Dakota"', add
	label define statefip_lbl 39 `"Ohio"', add
	label define statefip_lbl 40 `"Oklahoma"', add
	label define statefip_lbl 41 `"Oregon"', add
	label define statefip_lbl 42 `"Pennsylvania"', add
	label define statefip_lbl 44 `"Rhode Island"', add
	label define statefip_lbl 45 `"South Carolina"', add
	label define statefip_lbl 46 `"South Dakota"', add
	label define statefip_lbl 47 `"Tennessee"', add
	label define statefip_lbl 48 `"Texas"', add
	label define statefip_lbl 49 `"Utah"', add
	label define statefip_lbl 50 `"Vermont"', add
	label define statefip_lbl 51 `"Virginia"', add
	label define statefip_lbl 53 `"Washington"', add
	label define statefip_lbl 54 `"West Virginia"', add
	label define statefip_lbl 55 `"Wisconsin"', add
	label define statefip_lbl 56 `"Wyoming"', add
	label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
	label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
	label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
	label define statefip_lbl 64 `"Maryland-Delaware"', add
	label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
	label define statefip_lbl 66 `"Utah-Nevada"', add
	label define statefip_lbl 67 `"Arizona-New Mexico"', add
	label define statefip_lbl 68 `"Alaska-Hawaii"', add
	label define statefip_lbl 72 `"Puerto Rico"', add
	label define statefip_lbl 97 `"Military/Mil. Reservation"', add
	label define statefip_lbl 99 `"State not identified"', add
	label values statefip statefip_lbl

	label define metaread_lbl 0000 `"Not identifiable or not in an MSA"'
	label define metaread_lbl 0040 `"Abilene, TX"', add
	label define metaread_lbl 0060 `"Aguadilla, PR"', add
	label define metaread_lbl 0080 `"Akron, OH"', add
	label define metaread_lbl 0120 `"Albany, GA"', add
	label define metaread_lbl 0160 `"Albany-Schenectady-Troy, NY"', add
	label define metaread_lbl 0200 `"Albuquerque, NM"', add
	label define metaread_lbl 0220 `"Alexandria, LA"', add
	label define metaread_lbl 0240 `"Allentown-Bethlehem-Easton, PA/NJ"', add
	label define metaread_lbl 0280 `"Altoona, PA"', add
	label define metaread_lbl 0320 `"Amarillo, TX"', add
	label define metaread_lbl 0380 `"Anchorage, AK"', add
	label define metaread_lbl 0400 `"Anderson, IN"', add
	label define metaread_lbl 0440 `"Ann Arbor, MI"', add
	label define metaread_lbl 0450 `"Anniston, AL"', add
	label define metaread_lbl 0460 `"Appleton-Oshkosh-Neenah, WI"', add
	label define metaread_lbl 0470 `"Arecibo, PR"', add
	label define metaread_lbl 0480 `"Asheville, NC"', add
	label define metaread_lbl 0500 `"Athens, GA"', add
	label define metaread_lbl 0520 `"Atlanta, GA"', add
	label define metaread_lbl 0560 `"Atlantic City, NJ"', add
	label define metaread_lbl 0580 `"Auburn-Opelika, AL"', add
	label define metaread_lbl 0600 `"Augusta-Aiken, GA-SC"', add
	label define metaread_lbl 0640 `"Austin, TX"', add
	label define metaread_lbl 0680 `"Bakersfield, CA"', add
	label define metaread_lbl 0720 `"Baltimore, MD"', add
	label define metaread_lbl 0730 `"Bangor, ME"', add
	label define metaread_lbl 0740 `"Barnstable-Yarmouth, MA"', add
	label define metaread_lbl 0760 `"Baton Rouge, LA"', add
	label define metaread_lbl 0780 `"Battle Creek, MI"', add
	label define metaread_lbl 0840 `"Beaumont-Port Arthur-Orange,TX"', add
	label define metaread_lbl 0860 `"Bellingham, WA"', add
	label define metaread_lbl 0870 `"Benton Harbor, MI"', add
	label define metaread_lbl 0880 `"Billings, MT"', add
	label define metaread_lbl 0920 `"Biloxi-Gulfport, MS"', add
	label define metaread_lbl 0960 `"Binghamton, NY"', add
	label define metaread_lbl 1000 `"Birmingham, AL"', add
	label define metaread_lbl 1010 `"Bismarck,ND"', add
	label define metaread_lbl 1020 `"Bloomington, IN"', add
	label define metaread_lbl 1040 `"Bloomington-Normal, IL"', add
	label define metaread_lbl 1080 `"Boise City, ID"', add
	label define metaread_lbl 1120 `"Boston, MA"', add
	label define metaread_lbl 1121 `"Lawrence-Haverhill, MA/NH"', add
	label define metaread_lbl 1122 `"Lowell, MA/NH"', add
	label define metaread_lbl 1123 `"Salem-Gloucester, MA"', add
	label define metaread_lbl 1140 `"Bradenton, FL"', add
	label define metaread_lbl 1150 `"Bremerton, WA"', add
	label define metaread_lbl 1160 `"Bridgeport, CT"', add
	label define metaread_lbl 1200 `"Brockton, MA"', add
	label define metaread_lbl 1240 `"Brownsville-Harlingen-San Benito, TX"', add
	label define metaread_lbl 1260 `"Bryan-College Station, TX"', add
	label define metaread_lbl 1280 `"Buffalo-Niagara Falls, NY"', add
	label define metaread_lbl 1281 `"Niagara Falls, NY"', add
	label define metaread_lbl 1300 `"Burlington, NC"', add
	label define metaread_lbl 1310 `"Burlington, VT"', add
	label define metaread_lbl 1320 `"Canton, OH"', add
	label define metaread_lbl 1330 `"Caguas, PR"', add
	label define metaread_lbl 1350 `"Casper, WY"', add
	label define metaread_lbl 1360 `"Cedar Rapids, IA"', add
	label define metaread_lbl 1400 `"Champaign-Urbana-Rantoul, IL"', add
	label define metaread_lbl 1440 `"Charleston-N.Charleston,SC"', add
	label define metaread_lbl 1480 `"Charleston, WV"', add
	label define metaread_lbl 1520 `"Charlotte-Gastonia-Rock Hill, SC"', add
	label define metaread_lbl 1521 `"Rock Hill, SC"', add
	label define metaread_lbl 1540 `"Charlottesville, VA"', add
	label define metaread_lbl 1560 `"Chattanooga, TN/GA"', add
	label define metaread_lbl 1580 `"Cheyenne, WY"', add
	label define metaread_lbl 1600 `"Chicago-Gary-Lake, IL"', add
	label define metaread_lbl 1601 `"Aurora-Elgin, IL"', add
	label define metaread_lbl 1602 `"Gary-Hammond-East Chicago, IN"', add
	label define metaread_lbl 1603 `"Joliet IL"', add
	label define metaread_lbl 1604 `"Lake County, IL"', add
	label define metaread_lbl 1620 `"Chico, CA"', add
	label define metaread_lbl 1640 `"Cincinnati OH/KY/IN"', add
	label define metaread_lbl 1660 `"Clarksville-Hopkinsville, TN/KY"', add
	label define metaread_lbl 1680 `"Cleveland, OH"', add
	label define metaread_lbl 1720 `"Colorado Springs, CO"', add
	label define metaread_lbl 1740 `"Columbia, MO"', add
	label define metaread_lbl 1760 `"Columbia, SC"', add
	label define metaread_lbl 1800 `"Columbus, GA/AL"', add
	label define metaread_lbl 1840 `"Columbus, OH"', add
	label define metaread_lbl 1880 `"Corpus Christi, TX"', add
	label define metaread_lbl 1900 `"Cumberland, MD/WV"', add
	label define metaread_lbl 1920 `"Dallas-Fort Worth, TX"', add
	label define metaread_lbl 1921 `"Fort Worth-Arlington, TX"', add
	label define metaread_lbl 1930 `"Danbury, CT"', add
	label define metaread_lbl 1950 `"Danville, VA"', add
	label define metaread_lbl 1960 `"Davenport, IA Rock Island-Moline, IL"', add
	label define metaread_lbl 2000 `"Dayton-Springfield, OH"', add
	label define metaread_lbl 2001 `"Springfield, OH"', add
	label define metaread_lbl 2020 `"Daytona Beach, FL"', add
	label define metaread_lbl 2030 `"Decatur, AL"', add
	label define metaread_lbl 2040 `"Decatur, IL"', add
	label define metaread_lbl 2080 `"Denver-Boulder-Longmont, CO"', add
	label define metaread_lbl 2081 `"Boulder-Longmont, CO"', add
	label define metaread_lbl 2120 `"Des Moines, IA"', add
	label define metaread_lbl 2121 `"Polk, IA"', add
	label define metaread_lbl 2160 `"Detroit, MI"', add
	label define metaread_lbl 2180 `"Dothan, AL"', add
	label define metaread_lbl 2190 `"Dover, DE"', add
	label define metaread_lbl 2200 `"Dubuque, IA"', add
	label define metaread_lbl 2240 `"Duluth-Superior, MN/WI"', add
	label define metaread_lbl 2281 `"Dutchess Co., NY"', add
	label define metaread_lbl 2290 `"Eau Claire, WI"', add
	label define metaread_lbl 2310 `"El Paso, TX"', add
	label define metaread_lbl 2320 `"Elkhart-Goshen, IN"', add
	label define metaread_lbl 2330 `"Elmira, NY"', add
	label define metaread_lbl 2340 `"Enid, OK"', add
	label define metaread_lbl 2360 `"Erie, PA"', add
	label define metaread_lbl 2400 `"Eugene-Springfield, OR"', add
	label define metaread_lbl 2440 `"Evansville, IN/KY"', add
	label define metaread_lbl 2520 `"Fargo-Morehead, ND/MN"', add
	label define metaread_lbl 2560 `"Fayetteville, NC"', add
	label define metaread_lbl 2580 `"Fayetteville-Springdale, AR"', add
	label define metaread_lbl 2600 `"Fitchburg-Leominster, MA"', add
	label define metaread_lbl 2620 `"Flagstaff, AZ-UT"', add
	label define metaread_lbl 2640 `"Flint, MI"', add
	label define metaread_lbl 2650 `"Florence, AL"', add
	label define metaread_lbl 2660 `"Florence, SC"', add
	label define metaread_lbl 2670 `"Fort Collins-Loveland, CO"', add
	label define metaread_lbl 2680 `"Fort Lauderdale-Hollywood-Pompano Beach, FL"', add
	label define metaread_lbl 2700 `"Fort Myers-Cape Coral, FL"', add
	label define metaread_lbl 2710 `"Fort Pierce, FL"', add
	label define metaread_lbl 2720 `"Fort Smith, AR/OK"', add
	label define metaread_lbl 2750 `"Fort Walton Beach, FL"', add
	label define metaread_lbl 2760 `"Fort Wayne, IN"', add
	label define metaread_lbl 2840 `"Fresno, CA"', add
	label define metaread_lbl 2880 `"Gadsden, AL"', add
	label define metaread_lbl 2900 `"Gainesville, FL"', add
	label define metaread_lbl 2920 `"Galveston-Texas City, TX"', add
	label define metaread_lbl 2970 `"Glens Falls, NY"', add
	label define metaread_lbl 2980 `"Goldsboro, NC"', add
	label define metaread_lbl 2990 `"Grand Forks, ND/MN"', add
	label define metaread_lbl 3000 `"Grand Rapids, MI"', add
	label define metaread_lbl 3010 `"Grand Junction, CO"', add
	label define metaread_lbl 3040 `"Great Falls, MT"', add
	label define metaread_lbl 3060 `"Greeley, CO"', add
	label define metaread_lbl 3080 `"Green Bay, WI"', add
	label define metaread_lbl 3120 `"Greensboro-Winston Salem-High Point, NC"', add
	label define metaread_lbl 3121 `"Winston-Salem, NC"', add
	label define metaread_lbl 3150 `"Greenville, NC"', add
	label define metaread_lbl 3160 `"Greenville-Spartanburg-Anderson SC"', add
	label define metaread_lbl 3161 `"Anderson, SC"', add
	label define metaread_lbl 3180 `"Hagerstown, MD"', add
	label define metaread_lbl 3200 `"Hamilton-Middleton, OH"', add
	label define metaread_lbl 3240 `"Harrisburg-Lebanon-Carlisle, PA"', add
	label define metaread_lbl 3280 `"Hartford-Bristol-Middleton-New Britain, CT"', add
	label define metaread_lbl 3281 `"Bristol, CT"', add
	label define metaread_lbl 3282 `"Middletown, CT"', add
	label define metaread_lbl 3283 `"New Britain, CT"', add
	label define metaread_lbl 3290 `"Hickory-Morgantown, NC"', add
	label define metaread_lbl 3300 `"Hattiesburg, MS"', add
	label define metaread_lbl 3320 `"Honolulu, HI"', add
	label define metaread_lbl 3350 `"Houma-Thibodoux, LA"', add
	label define metaread_lbl 3360 `"Houston-Brazoria, TX"', add
	label define metaread_lbl 3361 `"Brazoria, TX"', add
	label define metaread_lbl 3400 `"Huntington-Ashland, WV/KY/OH"', add
	label define metaread_lbl 3440 `"Huntsville, AL"', add
	label define metaread_lbl 3480 `"Indianapolis, IN"', add
	label define metaread_lbl 3500 `"Iowa City, IA"', add
	label define metaread_lbl 3520 `"Jackson, MI"', add
	label define metaread_lbl 3560 `"Jackson, MS"', add
	label define metaread_lbl 3580 `"Jackson, TN"', add
	label define metaread_lbl 3590 `"Jacksonville, FL"', add
	label define metaread_lbl 3600 `"Jacksonville, NC"', add
	label define metaread_lbl 3610 `"Jamestown-Dunkirk, NY"', add
	label define metaread_lbl 3620 `"Janesville-Beloit, WI"', add
	label define metaread_lbl 3660 `"Johnson City-Kingsport-Bristol, TN/VA"', add
	label define metaread_lbl 3680 `"Johnstown, PA"', add
	label define metaread_lbl 3710 `"Joplin, MO"', add
	label define metaread_lbl 3720 `"Kalamazoo-Portage, MI"', add
	label define metaread_lbl 3740 `"Kankakee, IL"', add
	label define metaread_lbl 3760 `"Kansas City, MO-KS"', add
	label define metaread_lbl 3800 `"Kenosha, WI"', add
	label define metaread_lbl 3810 `"Kileen-Temple, TX"', add
	label define metaread_lbl 3840 `"Knoxville, TN"', add
	label define metaread_lbl 3850 `"Kokomo, IN"', add
	label define metaread_lbl 3870 `"LaCrosse, WI"', add
	label define metaread_lbl 3880 `"Lafayette, LA"', add
	label define metaread_lbl 3920 `"Lafayette-W. Lafayette, IN"', add
	label define metaread_lbl 3960 `"Lake Charles, LA"', add
	label define metaread_lbl 3980 `"Lakeland-Winterhaven, FL"', add
	label define metaread_lbl 4000 `"Lancaster, PA"', add
	label define metaread_lbl 4040 `"Lansing-E. Lansing, MI"', add
	label define metaread_lbl 4080 `"Laredo, TX"', add
	label define metaread_lbl 4100 `"Las Cruces, NM"', add
	label define metaread_lbl 4120 `"Las Vegas, NV"', add
	label define metaread_lbl 4150 `"Lawrence, KS"', add
	label define metaread_lbl 4200 `"Lawton, OK"', add
	label define metaread_lbl 4240 `"Lewiston-Auburn, ME"', add
	label define metaread_lbl 4280 `"Lexington-Fayette, KY"', add
	label define metaread_lbl 4320 `"Lima, OH"', add
	label define metaread_lbl 4360 `"Lincoln, NE"', add
	label define metaread_lbl 4400 `"Little Rock-North Little Rock, AR"', add
	label define metaread_lbl 4410 `"Long Branch-Asbury Park,NJ"', add
	label define metaread_lbl 4420 `"Longview-Marshall, TX"', add
	label define metaread_lbl 4440 `"Lorain-Elyria, OH"', add
	label define metaread_lbl 4480 `"Los Angeles-Long Beach, CA"', add
	label define metaread_lbl 4481 `"Anaheim-Santa Ana-Garden Grove, CA"', add
	label define metaread_lbl 4482 `"Orange County, CA"', add
	label define metaread_lbl 4520 `"Louisville, KY/IN"', add
	label define metaread_lbl 4600 `"Lubbock, TX"', add
	label define metaread_lbl 4640 `"Lynchburg, VA"', add
	label define metaread_lbl 4680 `"Macon-Warner Robins, GA"', add
	label define metaread_lbl 4720 `"Madison, WI"', add
	label define metaread_lbl 4760 `"Manchester, NH"', add
	label define metaread_lbl 4800 `"Mansfield, OH"', add
	label define metaread_lbl 4840 `"Mayaguez, PR"', add
	label define metaread_lbl 4880 `"McAllen-Edinburg-Pharr-Mission, TX"', add
	label define metaread_lbl 4890 `"Medford, OR"', add
	label define metaread_lbl 4900 `"Melbourne-Titusville-Cocoa-Palm Bay, FL"', add
	label define metaread_lbl 4920 `"Memphis, TN/AR/MS"', add
	label define metaread_lbl 4940 `"Merced, CA"', add
	label define metaread_lbl 5000 `"Miami-Hialeah, FL"', add
	label define metaread_lbl 5040 `"Midland, TX"', add
	label define metaread_lbl 5080 `"Milwaukee, WI"', add
	label define metaread_lbl 5120 `"Minneapolis-St. Paul, MN"', add
	label define metaread_lbl 5140 `"Missoula, MT"', add
	label define metaread_lbl 5160 `"Mobile, AL"', add
	label define metaread_lbl 5170 `"Modesto, CA"', add
	label define metaread_lbl 5190 `"Monmouth-Ocean, NJ"', add
	label define metaread_lbl 5200 `"Monroe, LA"', add
	label define metaread_lbl 5240 `"Montgomery, AL"', add
	label define metaread_lbl 5280 `"Muncie, IN"', add
	label define metaread_lbl 5320 `"Muskegon-Norton Shores-Muskegon Heights, MI"', add
	label define metaread_lbl 5330 `"Myrtle Beach, SC"', add
	label define metaread_lbl 5340 `"Naples, FL"', add
	label define metaread_lbl 5350 `"Nashua, NH"', add
	label define metaread_lbl 5360 `"Nashville, TN"', add
	label define metaread_lbl 5400 `"New Bedford, MA"', add
	label define metaread_lbl 5460 `"New Brunswick-Perth Amboy-Sayreville, NJ"', add
	label define metaread_lbl 5480 `"New Haven-Meriden, CT"', add
	label define metaread_lbl 5481 `"Meriden"', add
	label define metaread_lbl 5482 `"New Haven, CT"', add
	label define metaread_lbl 5520 `"New London-Norwich, CT/RI"', add
	label define metaread_lbl 5560 `"New Orleans, LA"', add
	label define metaread_lbl 5600 `"New York-Northeastern NJ"', add
	label define metaread_lbl 5601 `"Nassau Co, NY"', add
	label define metaread_lbl 5602 `"Bergen-Passaic, NJ"', add
	label define metaread_lbl 5603 `"Jersey City, NJ"', add
	label define metaread_lbl 5604 `"Middlesex-Somerset-Hunterdon, NJ"', add
	label define metaread_lbl 5605 `"Newark, NJ"', add
	label define metaread_lbl 5640 `"Newark, OH"', add
	label define metaread_lbl 5660 `"Newburgh-Middletown, NY"', add
	label define metaread_lbl 5720 `"Norfolk-VA Beach-Newport News, VA"', add
	label define metaread_lbl 5721 `"Newport News-Hampton"', add
	label define metaread_lbl 5722 `"Norfolk- VA Beach-Portsmouth"', add
	label define metaread_lbl 5760 `"Norwalk, CT"', add
	label define metaread_lbl 5790 `"Ocala, FL"', add
	label define metaread_lbl 5800 `"Odessa, TX"', add
	label define metaread_lbl 5880 `"Oklahoma City, OK"', add
	label define metaread_lbl 5910 `"Olympia, WA"', add
	label define metaread_lbl 5920 `"Omaha, NE/IA"', add
	label define metaread_lbl 5950 `"Orange, NY"', add
	label define metaread_lbl 5960 `"Orlando, FL"', add
	label define metaread_lbl 5990 `"Owensboro, KY"', add
	label define metaread_lbl 6010 `"Panama City, FL"', add
	label define metaread_lbl 6020 `"Parkersburg-Marietta,WV/OH"', add
	label define metaread_lbl 6030 `"Pascagoula-Moss Point, MS"', add
	label define metaread_lbl 6080 `"Pensacola, FL"', add
	label define metaread_lbl 6120 `"Peoria, IL"', add
	label define metaread_lbl 6160 `"Philadelphia, PA/NJ"', add
	label define metaread_lbl 6200 `"Phoenix, AZ"', add
	label define metaread_lbl 6240 `"Pine Bluff, AR"', add
	label define metaread_lbl 6280 `"Pittsburgh-Beaver Valley, PA"', add
	label define metaread_lbl 6281 `"Beaver County, PA"', add
	label define metaread_lbl 6320 `"Pittsfield, MA"', add
	label define metaread_lbl 6360 `"Ponce, PR"', add
	label define metaread_lbl 6400 `"Portland, ME"', add
	label define metaread_lbl 6440 `"Portland-Vancouver, OR"', add
	label define metaread_lbl 6441 `"Vancouver, WA"', add
	label define metaread_lbl 6450 `"Portsmouth-Dover-Rochester, NH/ME"', add
	label define metaread_lbl 6460 `"Poughkeepsie, NY"', add
	label define metaread_lbl 6480 `"Providence-Fall River-Pawtucket, MA/RI"', add
	label define metaread_lbl 6481 `"Fall River, MA/RI"', add
	label define metaread_lbl 6482 `"Pawtuckett-Woonsocket-Attleboro, RI/MA"', add
	label define metaread_lbl 6520 `"Provo-Orem, UT"', add
	label define metaread_lbl 6560 `"Pueblo, CO"', add
	label define metaread_lbl 6580 `"Punta Gorda, FL"', add
	label define metaread_lbl 6600 `"Racine, WI"', add
	label define metaread_lbl 6640 `"Raleigh-Durham, NC"', add
	label define metaread_lbl 6641 `"Durham, NC"', add
	label define metaread_lbl 6660 `"Rapid City, SD"', add
	label define metaread_lbl 6680 `"Reading, PA"', add
	label define metaread_lbl 6690 `"Redding, CA"', add
	label define metaread_lbl 6720 `"Reno, NV"', add
	label define metaread_lbl 6740 `"Richland-Kennewick-Pasco, WA"', add
	label define metaread_lbl 6760 `"Richmond-Petersburg, VA"', add
	label define metaread_lbl 6761 `"Petersburg-Colonial Heights, VA"', add
	label define metaread_lbl 6780 `"Riverside-San Bernardino,CA"', add
	label define metaread_lbl 6781 `"San Bernardino, CA"', add
	label define metaread_lbl 6800 `"Roanoke, VA"', add
	label define metaread_lbl 6820 `"Rochester, MN"', add
	label define metaread_lbl 6840 `"Rochester, NY"', add
	label define metaread_lbl 6880 `"Rockford, IL"', add
	label define metaread_lbl 6895 `"Rocky Mount, NC"', add
	label define metaread_lbl 6920 `"Sacramento, CA"', add
	label define metaread_lbl 6960 `"Saginaw-Bay City-Midland, MI"', add
	label define metaread_lbl 6961 `"Bay City, MI"', add
	label define metaread_lbl 6980 `"St. Cloud, MN"', add
	label define metaread_lbl 7000 `"St. Joseph, MO"', add
	label define metaread_lbl 7040 `"St. Louis, MO-IL"', add
	label define metaread_lbl 7080 `"Salem, OR"', add
	label define metaread_lbl 7120 `"Salinas-Sea Side-Monterey, CA"', add
	label define metaread_lbl 7140 `"Salisbury-Concord, NC"', add
	label define metaread_lbl 7160 `"Salt Lake City-Ogden, UT"', add
	label define metaread_lbl 7161 `"Ogden"', add
	label define metaread_lbl 7200 `"San Angelo, TX"', add
	label define metaread_lbl 7240 `"San Antonio, TX"', add
	label define metaread_lbl 7320 `"San Diego, CA"', add
	label define metaread_lbl 7360 `"San Francisco-Oakland-Vallejo, CA"', add
	label define metaread_lbl 7361 `"Oakland, CA"', add
	label define metaread_lbl 7362 `"Vallejo-Fairfield-Napa, CA"', add
	label define metaread_lbl 7400 `"San Jose, CA"', add
	label define metaread_lbl 7440 `"San Juan-Bayamon, PR"', add
	label define metaread_lbl 7460 `"San Luis Obispo-Atascad-P Robles, CA"', add
	label define metaread_lbl 7470 `"Santa Barbara-Santa Maria-Lompoc, CA"', add
	label define metaread_lbl 7480 `"Santa Cruz, CA"', add
	label define metaread_lbl 7490 `"Santa Fe, NM"', add
	label define metaread_lbl 7500 `"Santa Rosa-Petaluma, CA"', add
	label define metaread_lbl 7510 `"Sarasota, FL"', add
	label define metaread_lbl 7520 `"Savannah, GA"', add
	label define metaread_lbl 7560 `"Scranton-Wilkes-Barre, PA"', add
	label define metaread_lbl 7561 `"Wilkes-Barre-Hazelton, PA"', add
	label define metaread_lbl 7600 `"Seattle-Everett, WA"', add
	label define metaread_lbl 7610 `"Sharon, PA"', add
	label define metaread_lbl 7620 `"Sheboygan, WI"', add
	label define metaread_lbl 7640 `"Sherman-Denison, TX"', add
	label define metaread_lbl 7680 `"Shreveport, LA"', add
	label define metaread_lbl 7720 `"Sioux City, IA/NE"', add
	label define metaread_lbl 7760 `"Sioux Falls, SD"', add
	label define metaread_lbl 7800 `"South Bend-Mishawaka, IN"', add
	label define metaread_lbl 7840 `"Spokane, WA"', add
	label define metaread_lbl 7880 `"Springfield, IL"', add
	label define metaread_lbl 7920 `"Springfield, MO"', add
	label define metaread_lbl 8000 `"Springfield-Holyoke-Chicopee, MA"', add
	label define metaread_lbl 8040 `"Stamford, CT"', add
	label define metaread_lbl 8050 `"State College, PA"', add
	label define metaread_lbl 8080 `"Steubenville-Weirton,OH/WV"', add
	label define metaread_lbl 8120 `"Stockton, CA"', add
	label define metaread_lbl 8140 `"Sumter, SC"', add
	label define metaread_lbl 8160 `"Syracuse, NY"', add
	label define metaread_lbl 8200 `"Tacoma, WA"', add
	label define metaread_lbl 8240 `"Tallahassee, FL"', add
	label define metaread_lbl 8280 `"Tampa-St. Petersburg-Clearwater, FL"', add
	label define metaread_lbl 8320 `"Terre Haute, IN"', add
	label define metaread_lbl 8360 `"Texarkana, TX/AR"', add
	label define metaread_lbl 8400 `"Toledo, OH/MI"', add
	label define metaread_lbl 8440 `"Topeka, KS"', add
	label define metaread_lbl 8480 `"Trenton, NJ"', add
	label define metaread_lbl 8520 `"Tucson, AZ"', add
	label define metaread_lbl 8560 `"Tulsa, OK"', add
	label define metaread_lbl 8600 `"Tuscaloosa, AL"', add
	label define metaread_lbl 8640 `"Tyler, TX"', add
	label define metaread_lbl 8680 `"Utica-Rome, NY"', add
	label define metaread_lbl 8730 `"Ventura-Oxnard-Simi Valley, CA"', add
	label define metaread_lbl 8750 `"Victoria, TX"', add
	label define metaread_lbl 8760 `"Vineland-Milville-Bridgetown, NJ"', add
	label define metaread_lbl 8780 `"Visalia-Tulare-Porterville, CA"', add
	label define metaread_lbl 8800 `"Waco, TX"', add
	label define metaread_lbl 8840 `"Washington, DC/MD/VA"', add
	label define metaread_lbl 8880 `"Waterbury, CT"', add
	label define metaread_lbl 8920 `"Waterloo-Cedar Falls, IA"', add
	label define metaread_lbl 8940 `"Wausau, WI"', add
	label define metaread_lbl 8960 `"West Palm Beach-Boca Raton-Delray Beach, FL"', add
	label define metaread_lbl 9000 `"Wheeling, WV/OH"', add
	label define metaread_lbl 9040 `"Wichita, KS"', add
	label define metaread_lbl 9080 `"Wichita Falls, TX"', add
	label define metaread_lbl 9140 `"Williamsport, PA"', add
	label define metaread_lbl 9160 `"Wilmington, DE/NJ/MD"', add
	label define metaread_lbl 9200 `"Wilmington, NC"', add
	label define metaread_lbl 9240 `"Worcester, MA"', add
	label define metaread_lbl 9260 `"Yakima, WA"', add
	label define metaread_lbl 9270 `"Yolo, CA"', add
	label define metaread_lbl 9280 `"York, PA"', add
	label define metaread_lbl 9320 `"Youngstown-Warren, OH-PA"', add
	label define metaread_lbl 9340 `"Yuba City, CA"', add
	label define metaread_lbl 9360 `"Yuma, AZ"', add
	label values metaread metaread_lbl

	label define gq_lbl 0 `"Vacant unit"'
	label define gq_lbl 1 `"Households under 1970 definition"', add
	label define gq_lbl 2 `"Additional households under 1990 definition"', add
	label define gq_lbl 3 `"Group quarters--Institutions"', add
	label define gq_lbl 4 `"Other group quarters"', add
	label define gq_lbl 5 `"Additional households under 2000 definition"', add
	label define gq_lbl 6 `"Fragment"', add
	label values gq gq_lbl

	label define age_lbl 000 `"Less than 1 year old"'
	label define age_lbl 001 `"1"', add
	label define age_lbl 002 `"2"', add
	label define age_lbl 003 `"3"', add
	label define age_lbl 004 `"4"', add
	label define age_lbl 005 `"5"', add
	label define age_lbl 006 `"6"', add
	label define age_lbl 007 `"7"', add
	label define age_lbl 008 `"8"', add
	label define age_lbl 009 `"9"', add
	label define age_lbl 010 `"10"', add
	label define age_lbl 011 `"11"', add
	label define age_lbl 012 `"12"', add
	label define age_lbl 013 `"13"', add
	label define age_lbl 014 `"14"', add
	label define age_lbl 015 `"15"', add
	label define age_lbl 016 `"16"', add
	label define age_lbl 017 `"17"', add
	label define age_lbl 018 `"18"', add
	label define age_lbl 019 `"19"', add
	label define age_lbl 020 `"20"', add
	label define age_lbl 021 `"21"', add
	label define age_lbl 022 `"22"', add
	label define age_lbl 023 `"23"', add
	label define age_lbl 024 `"24"', add
	label define age_lbl 025 `"25"', add
	label define age_lbl 026 `"26"', add
	label define age_lbl 027 `"27"', add
	label define age_lbl 028 `"28"', add
	label define age_lbl 029 `"29"', add
	label define age_lbl 030 `"30"', add
	label define age_lbl 031 `"31"', add
	label define age_lbl 032 `"32"', add
	label define age_lbl 033 `"33"', add
	label define age_lbl 034 `"34"', add
	label define age_lbl 035 `"35"', add
	label define age_lbl 036 `"36"', add
	label define age_lbl 037 `"37"', add
	label define age_lbl 038 `"38"', add
	label define age_lbl 039 `"39"', add
	label define age_lbl 040 `"40"', add
	label define age_lbl 041 `"41"', add
	label define age_lbl 042 `"42"', add
	label define age_lbl 043 `"43"', add
	label define age_lbl 044 `"44"', add
	label define age_lbl 045 `"45"', add
	label define age_lbl 046 `"46"', add
	label define age_lbl 047 `"47"', add
	label define age_lbl 048 `"48"', add
	label define age_lbl 049 `"49"', add
	label define age_lbl 050 `"50"', add
	label define age_lbl 051 `"51"', add
	label define age_lbl 052 `"52"', add
	label define age_lbl 053 `"53"', add
	label define age_lbl 054 `"54"', add
	label define age_lbl 055 `"55"', add
	label define age_lbl 056 `"56"', add
	label define age_lbl 057 `"57"', add
	label define age_lbl 058 `"58"', add
	label define age_lbl 059 `"59"', add
	label define age_lbl 060 `"60"', add
	label define age_lbl 061 `"61"', add
	label define age_lbl 062 `"62"', add
	label define age_lbl 063 `"63"', add
	label define age_lbl 064 `"64"', add
	label define age_lbl 065 `"65"', add
	label define age_lbl 066 `"66"', add
	label define age_lbl 067 `"67"', add
	label define age_lbl 068 `"68"', add
	label define age_lbl 069 `"69"', add
	label define age_lbl 070 `"70"', add
	label define age_lbl 071 `"71"', add
	label define age_lbl 072 `"72"', add
	label define age_lbl 073 `"73"', add
	label define age_lbl 074 `"74"', add
	label define age_lbl 075 `"75"', add
	label define age_lbl 076 `"76"', add
	label define age_lbl 077 `"77"', add
	label define age_lbl 078 `"78"', add
	label define age_lbl 079 `"79"', add
	label define age_lbl 080 `"80"', add
	label define age_lbl 081 `"81"', add
	label define age_lbl 082 `"82"', add
	label define age_lbl 083 `"83"', add
	label define age_lbl 084 `"84"', add
	label define age_lbl 085 `"85"', add
	label define age_lbl 086 `"86"', add
	label define age_lbl 087 `"87"', add
	label define age_lbl 088 `"88"', add
	label define age_lbl 089 `"89"', add
	label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
	label define age_lbl 091 `"91"', add
	label define age_lbl 092 `"92"', add
	label define age_lbl 093 `"93"', add
	label define age_lbl 094 `"94"', add
	label define age_lbl 095 `"95"', add
	label define age_lbl 096 `"96"', add
	label define age_lbl 097 `"97"', add
	label define age_lbl 098 `"98"', add
	label define age_lbl 099 `"99"', add
	label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
	label define age_lbl 101 `"101"', add
	label define age_lbl 102 `"102"', add
	label define age_lbl 103 `"103"', add
	label define age_lbl 104 `"104"', add
	label define age_lbl 105 `"105"', add
	label define age_lbl 106 `"106"', add
	label define age_lbl 107 `"107"', add
	label define age_lbl 108 `"108"', add
	label define age_lbl 109 `"109"', add
	label define age_lbl 110 `"110"', add
	label define age_lbl 111 `"111"', add
	label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
	label define age_lbl 113 `"113"', add
	label define age_lbl 114 `"114"', add
	label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
	label define age_lbl 116 `"116"', add
	label define age_lbl 117 `"117"', add
	label define age_lbl 118 `"118"', add
	label define age_lbl 119 `"119"', add
	label define age_lbl 120 `"120"', add
	label define age_lbl 121 `"121"', add
	label define age_lbl 122 `"122"', add
	label define age_lbl 123 `"123"', add
	label define age_lbl 124 `"124"', add
	label define age_lbl 125 `"125"', add
	label define age_lbl 126 `"126"', add
	label define age_lbl 129 `"129"', add
	label define age_lbl 130 `"130"', add
	label define age_lbl 135 `"135"', add
	label values age age_lbl

	label define sex_lbl 1 `"Male"'
	label define sex_lbl 2 `"Female"', add
	label values sex sex_lbl

	label define marst_lbl 1 `"Married, spouse present"'
	label define marst_lbl 2 `"Married, spouse absent"', add
	label define marst_lbl 3 `"Separated"', add
	label define marst_lbl 4 `"Divorced"', add
	label define marst_lbl 5 `"Widowed"', add
	label define marst_lbl 6 `"Never married/single"', add
	label values marst marst_lbl

	label define marrno_lbl 0 `"Not Applicable"'
	label define marrno_lbl 1 `"Married once"', add
	label define marrno_lbl 2 `"Married twice (or more)"', add
	label define marrno_lbl 3 `"Married thrice (or more)"', add
	label define marrno_lbl 4 `"Four times"', add
	label define marrno_lbl 5 `"Five times"', add
	label define marrno_lbl 6 `"Six times"', add
	label define marrno_lbl 7 `"Unknown"', add
	label define marrno_lbl 8 `"Illegible"', add
	label define marrno_lbl 9 `"Missing"', add
	label values marrno marrno_lbl

	label define raced_lbl 100 `"White"'
	label define raced_lbl 110 `"Spanish write-in"', add
	label define raced_lbl 120 `"Blank (white) (1850)"', add
	label define raced_lbl 130 `"Portuguese"', add
	label define raced_lbl 140 `"Mexican (1930)"', add
	label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
	label define raced_lbl 200 `"Black/Negro"', add
	label define raced_lbl 210 `"Mulatto"', add
	label define raced_lbl 300 `"American Indian/Alaska Native"', add
	label define raced_lbl 301 `"Alaskan Athabaskan"', add
	label define raced_lbl 302 `"Apache"', add
	label define raced_lbl 303 `"Blackfoot"', add
	label define raced_lbl 304 `"Cherokee"', add
	label define raced_lbl 305 `"Cheyenne"', add
	label define raced_lbl 306 `"Chickasaw"', add
	label define raced_lbl 307 `"Chippewa"', add
	label define raced_lbl 308 `"Choctaw"', add
	label define raced_lbl 309 `"Comanche"', add
	label define raced_lbl 310 `"Creek"', add
	label define raced_lbl 311 `"Crow"', add
	label define raced_lbl 312 `"Iroquois"', add
	label define raced_lbl 313 `"Kiowa"', add
	label define raced_lbl 314 `"Lumbee"', add
	label define raced_lbl 315 `"Navajo"', add
	label define raced_lbl 316 `"Osage"', add
	label define raced_lbl 317 `"Paiute"', add
	label define raced_lbl 318 `"Pima"', add
	label define raced_lbl 319 `"Potawatomi"', add
	label define raced_lbl 320 `"Pueblo"', add
	label define raced_lbl 321 `"Seminole"', add
	label define raced_lbl 322 `"Shoshone"', add
	label define raced_lbl 323 `"Sioux"', add
	label define raced_lbl 324 `"Tlingit (Tlingit-Haida, 2000/ACS)"', add
	label define raced_lbl 325 `"Tohono O Odham"', add
	label define raced_lbl 326 `"All other tribes (1990)"', add
	label define raced_lbl 327 `"Tribe not specified"', add
	label define raced_lbl 328 `"Hopi"', add
	label define raced_lbl 330 `"Aleut"', add
	label define raced_lbl 340 `"Eskimo"', add
	label define raced_lbl 341 `"Alaskan mixed"', add
	label define raced_lbl 342 `"Inupiat"', add
	label define raced_lbl 343 `"Yupik"', add
	label define raced_lbl 350 `"Delaware"', add
	label define raced_lbl 351 `"Latin American Indian"', add
	label define raced_lbl 352 `"Puget Sound Salish"', add
	label define raced_lbl 353 `"Yakama"', add
	label define raced_lbl 354 `"Yaqui"', add
	label define raced_lbl 355 `"Colville"', add
	label define raced_lbl 356 `"Houma"', add
	label define raced_lbl 357 `"Menominee"', add
	label define raced_lbl 358 `"Yuman"', add
	label define raced_lbl 388 `"South American Indian"', add
	label define raced_lbl 389 `"Mexican American Indian"', add
	label define raced_lbl 390 `"Other Amer. Indian tribe (2000,ACS)"', add
	label define raced_lbl 391 `"2+ Amer. Indian tribes (2000,ACS)"', add
	label define raced_lbl 392 `"Other Alaska Native tribe(s) (2000,ACS)"', add
	label define raced_lbl 393 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
	label define raced_lbl 400 `"Chinese"', add
	label define raced_lbl 410 `"Taiwanese"', add
	label define raced_lbl 420 `"Chinese and Taiwanese"', add
	label define raced_lbl 500 `"Japanese"', add
	label define raced_lbl 600 `"Filipino"', add
	label define raced_lbl 610 `"Asian Indian (Hindu 1920-1940)"', add
	label define raced_lbl 620 `"Korean"', add
	label define raced_lbl 630 `"Hawaiian"', add
	label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
	label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
	label define raced_lbl 634 `"Hawaiian mixed"', add
	label define raced_lbl 640 `"Vietnamese"', add
	label define raced_lbl 641 `"Bhutanese"', add
	label define raced_lbl 642 `"Mongolian"', add
	label define raced_lbl 643 `"Nepalese"', add
	label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
	label define raced_lbl 651 `"Asian only (CPS)"', add
	label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
	label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
	label define raced_lbl 660 `"Cambodian"', add
	label define raced_lbl 661 `"Hmong"', add
	label define raced_lbl 662 `"Laotian"', add
	label define raced_lbl 663 `"Thai"', add
	label define raced_lbl 664 `"Bangladeshi"', add
	label define raced_lbl 665 `"Burmese"', add
	label define raced_lbl 666 `"Indonesian"', add
	label define raced_lbl 667 `"Malaysian"', add
	label define raced_lbl 668 `"Okinawan"', add
	label define raced_lbl 669 `"Pakistani"', add
	label define raced_lbl 670 `"Sri Lankan"', add
	label define raced_lbl 671 `"Other Asian, n.e.c."', add
	label define raced_lbl 672 `"Asian, not specified"', add
	label define raced_lbl 673 `"Chinese and Japanese"', add
	label define raced_lbl 674 `"Chinese and Filipino"', add
	label define raced_lbl 675 `"Chinese and Vietnamese"', add
	label define raced_lbl 676 `"Chinese and Asian write-in"', add
	label define raced_lbl 677 `"Japanese and Filipino"', add
	label define raced_lbl 678 `"Asian Indian and Asian write-in"', add
	label define raced_lbl 679 `"Other Asian race combinations"', add
	label define raced_lbl 680 `"Samoan"', add
	label define raced_lbl 681 `"Tahitian"', add
	label define raced_lbl 682 `"Tongan"', add
	label define raced_lbl 683 `"Other Polynesian (1990)"', add
	label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
	label define raced_lbl 685 `"Guamanian/Chamorro"', add
	label define raced_lbl 686 `"Northern Mariana Islander"', add
	label define raced_lbl 687 `"Palauan"', add
	label define raced_lbl 688 `"Other Micronesian (1990)"', add
	label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
	label define raced_lbl 690 `"Fijian"', add
	label define raced_lbl 691 `"Other Melanesian (1990)"', add
	label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
	label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
	label define raced_lbl 699 `"Pacific Islander, n.s."', add
	label define raced_lbl 700 `"Other race, n.e.c."', add
	label define raced_lbl 801 `"White and Black"', add
	label define raced_lbl 802 `"White and AIAN"', add
	label define raced_lbl 810 `"White and Asian"', add
	label define raced_lbl 811 `"White and Chinese"', add
	label define raced_lbl 812 `"White and Japanese"', add
	label define raced_lbl 813 `"White and Filipino"', add
	label define raced_lbl 814 `"White and Asian Indian"', add
	label define raced_lbl 815 `"White and Korean"', add
	label define raced_lbl 816 `"White and Vietnamese"', add
	label define raced_lbl 817 `"White and Asian write-in"', add
	label define raced_lbl 818 `"White and other Asian race(s)"', add
	label define raced_lbl 819 `"White and two or more Asian groups"', add
	label define raced_lbl 820 `"White and PI  "', add
	label define raced_lbl 821 `"White and Native Hawaiian"', add
	label define raced_lbl 822 `"White and Samoan"', add
	label define raced_lbl 823 `"White and Guamanian"', add
	label define raced_lbl 824 `"White and PI write-in"', add
	label define raced_lbl 825 `"White and other PI race(s)"', add
	label define raced_lbl 826 `"White and other race write-in"', add
	label define raced_lbl 827 `"White and other race, n.e.c."', add
	label define raced_lbl 830 `"Black and AIAN"', add
	label define raced_lbl 831 `"Black and Asian"', add
	label define raced_lbl 832 `"Black and Chinese"', add
	label define raced_lbl 833 `"Black and Japanese"', add
	label define raced_lbl 834 `"Black and Filipino"', add
	label define raced_lbl 835 `"Black and Asian Indian"', add
	label define raced_lbl 836 `"Black and Korean"', add
	label define raced_lbl 837 `"Black and Asian write-in"', add
	label define raced_lbl 838 `"Black and other Asian race(s)"', add
	label define raced_lbl 840 `"Black and PI"', add
	label define raced_lbl 841 `"Black and PI write-in"', add
	label define raced_lbl 842 `"Black and other PI race(s)"', add
	label define raced_lbl 845 `"Black and other race write-in"', add
	label define raced_lbl 850 `"AIAN and Asian"', add
	label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
	label define raced_lbl 852 `"AIAN and Asian Indian"', add
	label define raced_lbl 853 `"AIAN and Asian write-in (2000 1%)"', add
	label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
	label define raced_lbl 855 `"AIAN and PI"', add
	label define raced_lbl 856 `"AIAN and other race write-in"', add
	label define raced_lbl 860 `"Asian and PI"', add
	label define raced_lbl 861 `"Chinese and Hawaiian"', add
	label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
	label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
	label define raced_lbl 864 `"Filipino and Hawaiian"', add
	label define raced_lbl 865 `"Filipino and PI write-in"', add
	label define raced_lbl 866 `"Asian Indian and PI write-in (2000 1%)"', add
	label define raced_lbl 867 `"Asian write-in and PI write-in"', add
	label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
	label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
	label define raced_lbl 880 `"Asian and other race write-in"', add
	label define raced_lbl 881 `"Chinese and other race write-in"', add
	label define raced_lbl 882 `"Japanese and other race write-in"', add
	label define raced_lbl 883 `"Filipino and other race write-in"', add
	label define raced_lbl 884 `"Asian Indian and other race write-in"', add
	label define raced_lbl 885 `"Asian write-in and other race write-in"', add
	label define raced_lbl 886 `"Other Asian race(s) and other race write-in"', add
	label define raced_lbl 887 `"Chinese and Korean"', add
	label define raced_lbl 890 `"PI and other race write-in: "', add
	label define raced_lbl 891 `"PI write-in and other race write-in"', add
	label define raced_lbl 892 `"Other PI race(s) and other race write-in"', add
	label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
	label define raced_lbl 899 `"API and other race write-in"', add
	label define raced_lbl 901 `"White, Black, AIAN"', add
	label define raced_lbl 902 `"White, Black, Asian"', add
	label define raced_lbl 903 `"White, Black, PI"', add
	label define raced_lbl 904 `"White, Black, other race write-in"', add
	label define raced_lbl 905 `"White, AIAN, Asian"', add
	label define raced_lbl 906 `"White, AIAN, PI"', add
	label define raced_lbl 907 `"White, AIAN, other race write-in"', add
	label define raced_lbl 910 `"White, Asian, PI "', add
	label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
	label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
	label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
	label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
	label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
	label define raced_lbl 916 `"White, AIAN and Filipino"', add
	label define raced_lbl 917 `"White, Black, and Filipino"', add
	label define raced_lbl 920 `"White, Asian, other race write-in"', add
	label define raced_lbl 921 `"White, Filipino, other race write-in (2000 1%)"', add
	label define raced_lbl 922 `"White, Asian write-in, other race write-in (2000 1%)"', add
	label define raced_lbl 923 `"Other White, Asian race(s), other race write-in (2000 1%)"', add
	label define raced_lbl 925 `"White, PI, other race write-in"', add
	label define raced_lbl 926 `"White, Chinese, Filipino"', add
	label define raced_lbl 930 `"Black, AIAN, Asian"', add
	label define raced_lbl 931 `"Black, AIAN, PI"', add
	label define raced_lbl 932 `"Black, AIAN, other race write-in"', add
	label define raced_lbl 933 `"Black, Asian, PI"', add
	label define raced_lbl 934 `"Black, Asian, other race write-in"', add
	label define raced_lbl 935 `"Black, PI, other race write-in"', add
	label define raced_lbl 940 `"AIAN, Asian, PI"', add
	label define raced_lbl 941 `"AIAN, Asian, other race write-in"', add
	label define raced_lbl 942 `"AIAN, PI, other race write-in"', add
	label define raced_lbl 943 `"Asian, PI, other race write-in"', add
	label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
	label define raced_lbl 949 `"2 or 3 races (CPS)"', add
	label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
	label define raced_lbl 951 `"White, Black, AIAN, PI"', add
	label define raced_lbl 952 `"White, Black, AIAN, other race write-in"', add
	label define raced_lbl 953 `"White, Black, Asian, PI"', add
	label define raced_lbl 954 `"White, Black, Asian, other race write-in"', add
	label define raced_lbl 955 `"White, Black, PI, other race write-in"', add
	label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
	label define raced_lbl 961 `"White, AIAN, Asian, other race write-in"', add
	label define raced_lbl 962 `"White, AIAN, PI, other race write-in"', add
	label define raced_lbl 963 `"White, Asian, PI, other race write-in"', add
	label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
	label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
	label define raced_lbl 971 `"Black, AIAN, Asian, other race write-in"', add
	label define raced_lbl 972 `"Black, AIAN, PI, other race write-in"', add
	label define raced_lbl 973 `"Black, Asian, PI, other race write-in"', add
	label define raced_lbl 974 `"AIAN, Asian, PI, other race write-in"', add
	label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write-in"', add
	label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
	label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
	label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write-in"', add
	label define raced_lbl 982 `"White, Black, AIAN, PI, other race write-in"', add
	label define raced_lbl 983 `"White, Black, Asian, PI, other race write-in"', add
	label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write-in"', add
	label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write-in"', add
	label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write-in"', add
	label define raced_lbl 989 `"4 or 5 races (CPS)"', add
	label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write-in"', add
	label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
	label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
	label values raced raced_lbl

	label define bpld_lbl 00100 `"Alabama"'
	label define bpld_lbl 00200 `"Alaska"', add
	label define bpld_lbl 00400 `"Arizona"', add
	label define bpld_lbl 00500 `"Arkansas"', add
	label define bpld_lbl 00600 `"California"', add
	label define bpld_lbl 00800 `"Colorado"', add
	label define bpld_lbl 00900 `"Connecticut"', add
	label define bpld_lbl 01000 `"Delaware"', add
	label define bpld_lbl 01100 `"District of Columbia"', add
	label define bpld_lbl 01200 `"Florida"', add
	label define bpld_lbl 01300 `"Georgia"', add
	label define bpld_lbl 01500 `"Hawaii"', add
	label define bpld_lbl 01600 `"Idaho"', add
	label define bpld_lbl 01610 `"Idaho Territory"', add
	label define bpld_lbl 01700 `"Illinois"', add
	label define bpld_lbl 01800 `"Indiana"', add
	label define bpld_lbl 01900 `"Iowa"', add
	label define bpld_lbl 02000 `"Kansas"', add
	label define bpld_lbl 02100 `"Kentucky"', add
	label define bpld_lbl 02200 `"Louisiana"', add
	label define bpld_lbl 02300 `"Maine"', add
	label define bpld_lbl 02400 `"Maryland"', add
	label define bpld_lbl 02500 `"Massachusetts"', add
	label define bpld_lbl 02600 `"Michigan"', add
	label define bpld_lbl 02700 `"Minnesota"', add
	label define bpld_lbl 02800 `"Mississippi"', add
	label define bpld_lbl 02900 `"Missouri"', add
	label define bpld_lbl 03000 `"Montana"', add
	label define bpld_lbl 03100 `"Nebraska"', add
	label define bpld_lbl 03200 `"Nevada"', add
	label define bpld_lbl 03300 `"New Hampshire"', add
	label define bpld_lbl 03400 `"New Jersey"', add
	label define bpld_lbl 03500 `"New Mexico"', add
	label define bpld_lbl 03510 `"New Mexico Territory"', add
	label define bpld_lbl 03600 `"New York"', add
	label define bpld_lbl 03700 `"North Carolina"', add
	label define bpld_lbl 03800 `"North Dakota"', add
	label define bpld_lbl 03900 `"Ohio"', add
	label define bpld_lbl 04000 `"Oklahoma"', add
	label define bpld_lbl 04010 `"Indian Territory"', add
	label define bpld_lbl 04100 `"Oregon"', add
	label define bpld_lbl 04200 `"Pennsylvania"', add
	label define bpld_lbl 04400 `"Rhode Island"', add
	label define bpld_lbl 04500 `"South Carolina"', add
	label define bpld_lbl 04600 `"South Dakota"', add
	label define bpld_lbl 04610 `"Dakota Territory"', add
	label define bpld_lbl 04700 `"Tennessee"', add
	label define bpld_lbl 04800 `"Texas"', add
	label define bpld_lbl 04900 `"Utah"', add
	label define bpld_lbl 04910 `"Utah Territory"', add
	label define bpld_lbl 05000 `"Vermont"', add
	label define bpld_lbl 05100 `"Virginia"', add
	label define bpld_lbl 05300 `"Washington"', add
	label define bpld_lbl 05400 `"West Virginia"', add
	label define bpld_lbl 05500 `"Wisconsin"', add
	label define bpld_lbl 05600 `"Wyoming"', add
	label define bpld_lbl 05610 `"Wyoming Territory"', add
	label define bpld_lbl 09000 `"Native American"', add
	label define bpld_lbl 09900 `"United States, ns"', add
	label define bpld_lbl 10000 `"American Samoa"', add
	label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
	label define bpld_lbl 10500 `"Guam"', add
	label define bpld_lbl 11000 `"Puerto Rico"', add
	label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
	label define bpld_lbl 11510 `"St. Croix"', add
	label define bpld_lbl 11520 `"St. John"', add
	label define bpld_lbl 11530 `"St. Thomas"', add
	label define bpld_lbl 12000 `"Other US Possessions:"', add
	label define bpld_lbl 12010 `"Johnston Atoll"', add
	label define bpld_lbl 12020 `"Midway Islands"', add
	label define bpld_lbl 12030 `"Wake Island"', add
	label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
	label define bpld_lbl 12041 `"Navassa Island"', add
	label define bpld_lbl 12050 `"Other US Pacific Islands"', add
	label define bpld_lbl 12051 `"Baker Island"', add
	label define bpld_lbl 12052 `"Howland Island"', add
	label define bpld_lbl 12053 `"Jarvis Island"', add
	label define bpld_lbl 12054 `"Kingman Reef"', add
	label define bpld_lbl 12055 `"Palmyra Atoll"', add
	label define bpld_lbl 12090 `"US outlying areas, ns"', add
	label define bpld_lbl 12091 `"US possessions, ns"', add
	label define bpld_lbl 12092 `"US territory, ns"', add
	label define bpld_lbl 15000 `"Canada"', add
	label define bpld_lbl 15010 `"English Canada"', add
	label define bpld_lbl 15011 `"British Columbia"', add
	label define bpld_lbl 15013 `"Alberta"', add
	label define bpld_lbl 15015 `"Saskatchewan"', add
	label define bpld_lbl 15017 `"Northwest"', add
	label define bpld_lbl 15019 `"Ruperts Land"', add
	label define bpld_lbl 15020 `"Manitoba"', add
	label define bpld_lbl 15021 `"Red River"', add
	label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
	label define bpld_lbl 15031 `"Upper Canada"', add
	label define bpld_lbl 15032 `"Canada West"', add
	label define bpld_lbl 15040 `"New Brunswick"', add
	label define bpld_lbl 15050 `"Nova Scotia"', add
	label define bpld_lbl 15051 `"Cape Breton"', add
	label define bpld_lbl 15052 `"Halifax"', add
	label define bpld_lbl 15060 `"Prince Edward Island"', add
	label define bpld_lbl 15070 `"Newfoundland"', add
	label define bpld_lbl 15080 `"French Canada"', add
	label define bpld_lbl 15081 `"Quebec"', add
	label define bpld_lbl 15082 `"Lower Canada"', add
	label define bpld_lbl 15083 `"Canada East"', add
	label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
	label define bpld_lbl 16000 `"Atlantic Islands"', add
	label define bpld_lbl 16010 `"Bermuda"', add
	label define bpld_lbl 16020 `"Cape Verde"', add
	label define bpld_lbl 16030 `"Falkland Islands"', add
	label define bpld_lbl 16040 `"Greenland"', add
	label define bpld_lbl 16050 `"St. Helena and Ascension"', add
	label define bpld_lbl 16060 `"Canary Islands"', add
	label define bpld_lbl 19900 `"North America, ns"', add
	label define bpld_lbl 20000 `"Mexico"', add
	label define bpld_lbl 21000 `"Central America"', add
	label define bpld_lbl 21010 `"Belize/British Honduras"', add
	label define bpld_lbl 21020 `"Costa Rica"', add
	label define bpld_lbl 21030 `"El Salvador"', add
	label define bpld_lbl 21040 `"Guatemala"', add
	label define bpld_lbl 21050 `"Honduras"', add
	label define bpld_lbl 21060 `"Nicaragua"', add
	label define bpld_lbl 21070 `"Panama"', add
	label define bpld_lbl 21071 `"Canal Zone"', add
	label define bpld_lbl 21090 `"Central America, ns"', add
	label define bpld_lbl 25000 `"Cuba"', add
	label define bpld_lbl 26000 `"West Indies"', add
	label define bpld_lbl 26010 `"Dominican Republic"', add
	label define bpld_lbl 26020 `"Haiti"', add
	label define bpld_lbl 26030 `"Jamaica"', add
	label define bpld_lbl 26040 `"British West Indies"', add
	label define bpld_lbl 26041 `"Anguilla"', add
	label define bpld_lbl 26042 `"Antigua-Barbuda"', add
	label define bpld_lbl 26043 `"Bahamas"', add
	label define bpld_lbl 26044 `"Barbados"', add
	label define bpld_lbl 26045 `"British Virgin Islands"', add
	label define bpld_lbl 26046 `"Anegada"', add
	label define bpld_lbl 26047 `"Cooper"', add
	label define bpld_lbl 26048 `"Jost Van Dyke"', add
	label define bpld_lbl 26049 `"Peter"', add
	label define bpld_lbl 26050 `"Tortola"', add
	label define bpld_lbl 26051 `"Virgin Gorda"', add
	label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
	label define bpld_lbl 26053 `"Cayman Islands"', add
	label define bpld_lbl 26054 `"Dominica"', add
	label define bpld_lbl 26055 `"Grenada"', add
	label define bpld_lbl 26056 `"Montserrat"', add
	label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
	label define bpld_lbl 26058 `"St. Lucia"', add
	label define bpld_lbl 26059 `"St. Vincent"', add
	label define bpld_lbl 26060 `"Trinidad and Tobago"', add
	label define bpld_lbl 26061 `"Turks and Caicos"', add
	label define bpld_lbl 26069 `"British West Indies, ns"', add
	label define bpld_lbl 26070 `"Other West Indies"', add
	label define bpld_lbl 26071 `"Aruba"', add
	label define bpld_lbl 26072 `"Netherlands Antilles"', add
	label define bpld_lbl 26073 `"Bonaire"', add
	label define bpld_lbl 26074 `"Curacao"', add
	label define bpld_lbl 26075 `"Dutch St. Maarten"', add
	label define bpld_lbl 26076 `"Saba"', add
	label define bpld_lbl 26077 `"St. Eustatius"', add
	label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
	label define bpld_lbl 26080 `"French St. Maarten"', add
	label define bpld_lbl 26081 `"Guadeloupe"', add
	label define bpld_lbl 26082 `"Martinique"', add
	label define bpld_lbl 26083 `"St. Barthelemy"', add
	label define bpld_lbl 26089 `"French Caribbean, ns"', add
	label define bpld_lbl 26090 `"Antilles, n.s."', add
	label define bpld_lbl 26091 `"Caribbean, ns"', add
	label define bpld_lbl 26092 `"Latin America, ns"', add
	label define bpld_lbl 26093 `"Leeward Islands, ns"', add
	label define bpld_lbl 26094 `"West Indies, ns"', add
	label define bpld_lbl 26095 `"Windward Islands, ns"', add
	label define bpld_lbl 29900 `"Americas, ns"', add
	label define bpld_lbl 30000 `"South America"', add
	label define bpld_lbl 30005 `"Argentina"', add
	label define bpld_lbl 30010 `"Bolivia"', add
	label define bpld_lbl 30015 `"Brazil"', add
	label define bpld_lbl 30020 `"Chile"', add
	label define bpld_lbl 30025 `"Colombia"', add
	label define bpld_lbl 30030 `"Ecuador"', add
	label define bpld_lbl 30035 `"French Guiana"', add
	label define bpld_lbl 30040 `"Guyana/British Guiana"', add
	label define bpld_lbl 30045 `"Paraguay"', add
	label define bpld_lbl 30050 `"Peru"', add
	label define bpld_lbl 30055 `"Suriname"', add
	label define bpld_lbl 30060 `"Uruguay"', add
	label define bpld_lbl 30065 `"Venezuela"', add
	label define bpld_lbl 30090 `"South America, ns"', add
	label define bpld_lbl 30091 `"South and Central America, n.s."', add
	label define bpld_lbl 40000 `"Denmark"', add
	label define bpld_lbl 40010 `"Faeroe Islands"', add
	label define bpld_lbl 40100 `"Finland"', add
	label define bpld_lbl 40200 `"Iceland"', add
	label define bpld_lbl 40300 `"Lapland, ns"', add
	label define bpld_lbl 40400 `"Norway"', add
	label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
	label define bpld_lbl 40411 `"Svalbard"', add
	label define bpld_lbl 40412 `"Jan Meyen"', add
	label define bpld_lbl 40500 `"Sweden"', add
	label define bpld_lbl 41000 `"England"', add
	label define bpld_lbl 41010 `"Channel Islands"', add
	label define bpld_lbl 41011 `"Guernsey"', add
	label define bpld_lbl 41012 `"Jersey"', add
	label define bpld_lbl 41020 `"Isle of Man"', add
	label define bpld_lbl 41100 `"Scotland"', add
	label define bpld_lbl 41200 `"Wales"', add
	label define bpld_lbl 41300 `"United Kingdom, ns"', add
	label define bpld_lbl 41400 `"Ireland"', add
	label define bpld_lbl 41410 `"Northern Ireland"', add
	label define bpld_lbl 41900 `"Northern Europe, ns"', add
	label define bpld_lbl 42000 `"Belgium"', add
	label define bpld_lbl 42100 `"France"', add
	label define bpld_lbl 42110 `"Alsace-Lorraine"', add
	label define bpld_lbl 42111 `"Alsace"', add
	label define bpld_lbl 42112 `"Lorraine"', add
	label define bpld_lbl 42200 `"Liechtenstein"', add
	label define bpld_lbl 42300 `"Luxembourg"', add
	label define bpld_lbl 42400 `"Monaco"', add
	label define bpld_lbl 42500 `"Netherlands"', add
	label define bpld_lbl 42600 `"Switzerland"', add
	label define bpld_lbl 42900 `"Western Europe, ns"', add
	label define bpld_lbl 43000 `"Albania"', add
	label define bpld_lbl 43100 `"Andorra"', add
	label define bpld_lbl 43200 `"Gibraltar"', add
	label define bpld_lbl 43300 `"Greece"', add
	label define bpld_lbl 43310 `"Dodecanese Islands"', add
	label define bpld_lbl 43320 `"Turkey Greece"', add
	label define bpld_lbl 43330 `"Macedonia"', add
	label define bpld_lbl 43400 `"Italy"', add
	label define bpld_lbl 43500 `"Malta"', add
	label define bpld_lbl 43600 `"Portugal"', add
	label define bpld_lbl 43610 `"Azores"', add
	label define bpld_lbl 43620 `"Madeira Islands"', add
	label define bpld_lbl 43630 `"Cape Verde Islands"', add
	label define bpld_lbl 43640 `"St. Miguel"', add
	label define bpld_lbl 43700 `"San Marino"', add
	label define bpld_lbl 43800 `"Spain"', add
	label define bpld_lbl 43900 `"Vatican City"', add
	label define bpld_lbl 44000 `"Southern Europe, ns"', add
	label define bpld_lbl 45000 `"Austria"', add
	label define bpld_lbl 45010 `"Austria-Hungary"', add
	label define bpld_lbl 45020 `"Austria-Graz"', add
	label define bpld_lbl 45030 `"Austria-Linz"', add
	label define bpld_lbl 45040 `"Austria-Salzburg"', add
	label define bpld_lbl 45050 `"Austria-Tyrol"', add
	label define bpld_lbl 45060 `"Austria-Vienna"', add
	label define bpld_lbl 45070 `"Austria-Kaernsten"', add
	label define bpld_lbl 45080 `"Austria-Neustadt"', add
	label define bpld_lbl 45100 `"Bulgaria"', add
	label define bpld_lbl 45200 `"Czechoslovakia"', add
	label define bpld_lbl 45210 `"Bohemia"', add
	label define bpld_lbl 45211 `"Bohemia-Moravia"', add
	label define bpld_lbl 45212 `"Slovakia"', add
	label define bpld_lbl 45213 `"Czech Republic"', add
	label define bpld_lbl 45300 `"Germany"', add
	label define bpld_lbl 45301 `"Berlin"', add
	label define bpld_lbl 45302 `"West Berlin"', add
	label define bpld_lbl 45303 `"East Berlin"', add
	label define bpld_lbl 45310 `"West Germany"', add
	label define bpld_lbl 45311 `"Baden"', add
	label define bpld_lbl 45312 `"Bavaria"', add
	label define bpld_lbl 45313 `"Braunschweig"', add
	label define bpld_lbl 45314 `"Bremen"', add
	label define bpld_lbl 45315 `"Hamburg"', add
	label define bpld_lbl 45316 `"Hanover"', add
	label define bpld_lbl 45317 `"Hessen"', add
	label define bpld_lbl 45318 `"Hessen Nassau"', add
	label define bpld_lbl 45319 `"Holstein"', add
	label define bpld_lbl 45320 `"Lippe"', add
	label define bpld_lbl 45321 `"Lubeck"', add
	label define bpld_lbl 45322 `"Oldenburg"', add
	label define bpld_lbl 45323 `"Rhine Province"', add
	label define bpld_lbl 45324 `"Schleswig"', add
	label define bpld_lbl 45325 `"Schleswig-Holstein"', add
	label define bpld_lbl 45327 `"Waldeck"', add
	label define bpld_lbl 45328 `"Wurttemberg"', add
	label define bpld_lbl 45329 `"Waldecker"', add
	label define bpld_lbl 45330 `"Wittenberg"', add
	label define bpld_lbl 45331 `"Frankfurt"', add
	label define bpld_lbl 45332 `"Saarland"', add
	label define bpld_lbl 45333 `"Nordheim-Westfalen"', add
	label define bpld_lbl 45340 `"East Germany"', add
	label define bpld_lbl 45341 `"Anhalt"', add
	label define bpld_lbl 45342 `"Brandenburg"', add
	label define bpld_lbl 45344 `"Mecklenburg"', add
	label define bpld_lbl 45345 `"Sachsen-Altenburg"', add
	label define bpld_lbl 45346 `"Sachsen-Coburg"', add
	label define bpld_lbl 45347 `"Sachsen-Gotha"', add
	label define bpld_lbl 45350 `"Probable Saxony"', add
	label define bpld_lbl 45351 `"Schwerin"', add
	label define bpld_lbl 45353 `"Probably Thuringian States"', add
	label define bpld_lbl 45360 `"Prussia, nec"', add
	label define bpld_lbl 45361 `"Hohenzollern"', add
	label define bpld_lbl 45362 `"Niedersachsen"', add
	label define bpld_lbl 45400 `"Hungary"', add
	label define bpld_lbl 45500 `"Poland"', add
	label define bpld_lbl 45510 `"Austrian Poland"', add
	label define bpld_lbl 45511 `"Galicia"', add
	label define bpld_lbl 45520 `"German Poland"', add
	label define bpld_lbl 45521 `"East Prussia"', add
	label define bpld_lbl 45522 `"Pomerania"', add
	label define bpld_lbl 45523 `"Posen"', add
	label define bpld_lbl 45524 `"Prussian Poland"', add
	label define bpld_lbl 45525 `"Silesia"', add
	label define bpld_lbl 45526 `"West Prussia"', add
	label define bpld_lbl 45530 `"Russian Poland"', add
	label define bpld_lbl 45600 `"Romania"', add
	label define bpld_lbl 45610 `"Transylvania"', add
	label define bpld_lbl 45700 `"Yugoslavia"', add
	label define bpld_lbl 45710 `"Croatia"', add
	label define bpld_lbl 45720 `"Montenegro"', add
	label define bpld_lbl 45730 `"Serbia"', add
	label define bpld_lbl 45740 `"Bosnia"', add
	label define bpld_lbl 45750 `"Dalmatia"', add
	label define bpld_lbl 45760 `"Slovonia"', add
	label define bpld_lbl 45770 `"Carniola"', add
	label define bpld_lbl 45780 `"Slovenia"', add
	label define bpld_lbl 45790 `"Kosovo"', add
	label define bpld_lbl 45800 `"Central Europe, ns"', add
	label define bpld_lbl 45900 `"Eastern Europe, ns"', add
	label define bpld_lbl 46000 `"Estonia"', add
	label define bpld_lbl 46100 `"Latvia"', add
	label define bpld_lbl 46200 `"Lithuania"', add
	label define bpld_lbl 46300 `"Baltic States, ns"', add
	label define bpld_lbl 46500 `"Other USSR/Russia"', add
	label define bpld_lbl 46510 `"Byelorussia"', add
	label define bpld_lbl 46520 `"Moldavia"', add
	label define bpld_lbl 46521 `"Bessarabia"', add
	label define bpld_lbl 46530 `"Ukraine"', add
	label define bpld_lbl 46540 `"Armenia"', add
	label define bpld_lbl 46541 `"Azerbaijan"', add
	label define bpld_lbl 46542 `"Republic of Georgia"', add
	label define bpld_lbl 46543 `"Kazakhstan"', add
	label define bpld_lbl 46544 `"Kirghizia"', add
	label define bpld_lbl 46545 `"Tadzhik"', add
	label define bpld_lbl 46546 `"Turkmenistan"', add
	label define bpld_lbl 46547 `"Uzbekistan"', add
	label define bpld_lbl 46548 `"Siberia"', add
	label define bpld_lbl 46590 `"USSR, ns"', add
	label define bpld_lbl 49900 `"Europe, ns."', add
	label define bpld_lbl 50000 `"China"', add
	label define bpld_lbl 50010 `"Hong Kong"', add
	label define bpld_lbl 50020 `"Macau"', add
	label define bpld_lbl 50030 `"Mongolia"', add
	label define bpld_lbl 50040 `"Taiwan"', add
	label define bpld_lbl 50100 `"Japan"', add
	label define bpld_lbl 50200 `"Korea"', add
	label define bpld_lbl 50210 `"North Korea"', add
	label define bpld_lbl 50220 `"South Korea"', add
	label define bpld_lbl 50900 `"East Asia, ns"', add
	label define bpld_lbl 51000 `"Brunei"', add
	label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
	label define bpld_lbl 51200 `"Indonesia"', add
	label define bpld_lbl 51210 `"East Indies"', add
	label define bpld_lbl 51220 `"East Timor"', add
	label define bpld_lbl 51300 `"Laos"', add
	label define bpld_lbl 51400 `"Malaysia"', add
	label define bpld_lbl 51500 `"Philippines"', add
	label define bpld_lbl 51600 `"Singapore"', add
	label define bpld_lbl 51700 `"Thailand"', add
	label define bpld_lbl 51800 `"Vietnam"', add
	label define bpld_lbl 51900 `"Southeast Asia, ns"', add
	label define bpld_lbl 51910 `"Indochina, ns"', add
	label define bpld_lbl 52000 `"Afghanistan"', add
	label define bpld_lbl 52100 `"India"', add
	label define bpld_lbl 52110 `"Bangladesh"', add
	label define bpld_lbl 52120 `"Bhutan"', add
	label define bpld_lbl 52130 `"Burma (Myanmar)"', add
	label define bpld_lbl 52140 `"Pakistan"', add
	label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
	label define bpld_lbl 52200 `"Iran"', add
	label define bpld_lbl 52300 `"Maldives"', add
	label define bpld_lbl 52400 `"Nepal"', add
	label define bpld_lbl 53000 `"Bahrain"', add
	label define bpld_lbl 53100 `"Cyprus"', add
	label define bpld_lbl 53200 `"Iraq"', add
	label define bpld_lbl 53210 `"Mesopotamia"', add
	label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
	label define bpld_lbl 53400 `"Israel/Palestine"', add
	label define bpld_lbl 53410 `"Gaza Strip"', add
	label define bpld_lbl 53420 `"Palestine"', add
	label define bpld_lbl 53430 `"West Bank"', add
	label define bpld_lbl 53440 `"Israel"', add
	label define bpld_lbl 53500 `"Jordan"', add
	label define bpld_lbl 53600 `"Kuwait"', add
	label define bpld_lbl 53700 `"Lebanon"', add
	label define bpld_lbl 53800 `"Oman"', add
	label define bpld_lbl 53900 `"Qatar"', add
	label define bpld_lbl 54000 `"Saudi Arabia"', add
	label define bpld_lbl 54100 `"Syria"', add
	label define bpld_lbl 54200 `"Turkey"', add
	label define bpld_lbl 54210 `"European Turkey"', add
	label define bpld_lbl 54220 `"Asian Turkey"', add
	label define bpld_lbl 54300 `"United Arab Emirates"', add
	label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
	label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
	label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
	label define bpld_lbl 54700 `"Middle East, ns"', add
	label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
	label define bpld_lbl 54900 `"Asia Minor, ns"', add
	label define bpld_lbl 55000 `"South Asia, nec"', add
	label define bpld_lbl 59900 `"Asia, nec/ns"', add
	label define bpld_lbl 60000 `"Africa"', add
	label define bpld_lbl 60010 `"Northern Africa"', add
	label define bpld_lbl 60011 `"Algeria"', add
	label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
	label define bpld_lbl 60013 `"Libya"', add
	label define bpld_lbl 60014 `"Morocco"', add
	label define bpld_lbl 60015 `"Sudan"', add
	label define bpld_lbl 60016 `"Tunisia"', add
	label define bpld_lbl 60017 `"Western Sahara"', add
	label define bpld_lbl 60019 `"North Africa, ns"', add
	label define bpld_lbl 60020 `"Benin"', add
	label define bpld_lbl 60021 `"Burkina Faso"', add
	label define bpld_lbl 60022 `"Gambia"', add
	label define bpld_lbl 60023 `"Ghana"', add
	label define bpld_lbl 60024 `"Guinea"', add
	label define bpld_lbl 60025 `"Guinea-Bissau"', add
	label define bpld_lbl 60026 `"Ivory Coast"', add
	label define bpld_lbl 60027 `"Liberia"', add
	label define bpld_lbl 60028 `"Mali"', add
	label define bpld_lbl 60029 `"Mauritania"', add
	label define bpld_lbl 60030 `"Niger"', add
	label define bpld_lbl 60031 `"Nigeria"', add
	label define bpld_lbl 60032 `"Senegal"', add
	label define bpld_lbl 60033 `"Sierra Leone"', add
	label define bpld_lbl 60034 `"Togo"', add
	label define bpld_lbl 60038 `"Western Africa, ns"', add
	label define bpld_lbl 60039 `"French West Africa, ns"', add
	label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
	label define bpld_lbl 60041 `"Burundi"', add
	label define bpld_lbl 60042 `"Comoros"', add
	label define bpld_lbl 60043 `"Djibouti"', add
	label define bpld_lbl 60044 `"Ethiopia"', add
	label define bpld_lbl 60045 `"Kenya"', add
	label define bpld_lbl 60046 `"Madagascar"', add
	label define bpld_lbl 60047 `"Malawi"', add
	label define bpld_lbl 60048 `"Mauritius"', add
	label define bpld_lbl 60049 `"Mozambique"', add
	label define bpld_lbl 60050 `"Reunion"', add
	label define bpld_lbl 60051 `"Rwanda"', add
	label define bpld_lbl 60052 `"Seychelles"', add
	label define bpld_lbl 60053 `"Somalia"', add
	label define bpld_lbl 60054 `"Tanzania"', add
	label define bpld_lbl 60055 `"Uganda"', add
	label define bpld_lbl 60056 `"Zambia"', add
	label define bpld_lbl 60057 `"Zimbabwe"', add
	label define bpld_lbl 60058 `"Bassas de India"', add
	label define bpld_lbl 60059 `"Europa"', add
	label define bpld_lbl 60060 `"Gloriosos"', add
	label define bpld_lbl 60061 `"Juan de Nova"', add
	label define bpld_lbl 60062 `"Mayotte"', add
	label define bpld_lbl 60063 `"Tromelin"', add
	label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
	label define bpld_lbl 60065 `"Eritrea"', add
	label define bpld_lbl 60070 `"Central Africa"', add
	label define bpld_lbl 60071 `"Angola"', add
	label define bpld_lbl 60072 `"Cameroon"', add
	label define bpld_lbl 60073 `"Central African Republic"', add
	label define bpld_lbl 60074 `"Chad"', add
	label define bpld_lbl 60075 `"Congo"', add
	label define bpld_lbl 60076 `"Equatorial Guinea"', add
	label define bpld_lbl 60077 `"Gabon"', add
	label define bpld_lbl 60078 `"Sao Tome and Principe"', add
	label define bpld_lbl 60079 `"Zaire"', add
	label define bpld_lbl 60080 `"Central Africa, ns"', add
	label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
	label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
	label define bpld_lbl 60090 `"Southern Africa:"', add
	label define bpld_lbl 60091 `"Botswana"', add
	label define bpld_lbl 60092 `"Lesotho"', add
	label define bpld_lbl 60093 `"Namibia"', add
	label define bpld_lbl 60094 `"South Africa (Union of)"', add
	label define bpld_lbl 60095 `"Swaziland"', add
	label define bpld_lbl 60096 `"Southern Africa, ns"', add
	label define bpld_lbl 60099 `"Africa, ns/nec"', add
	label define bpld_lbl 70000 `"Australia and New Zealand"', add
	label define bpld_lbl 70010 `"Australia"', add
	label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
	label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
	label define bpld_lbl 70020 `"New Zealand"', add
	label define bpld_lbl 71000 `"Pacific Islands"', add
	label define bpld_lbl 71010 `"New Caledonia"', add
	label define bpld_lbl 71011 `"Norfolk Islands"', add
	label define bpld_lbl 71012 `"Papua New Guinea"', add
	label define bpld_lbl 71013 `"Solomon Islands"', add
	label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
	label define bpld_lbl 71019 `"Melanesia, ns"', add
	label define bpld_lbl 71020 `"Cook Islands"', add
	label define bpld_lbl 71021 `"Fiji"', add
	label define bpld_lbl 71022 `"French Polynesia"', add
	label define bpld_lbl 71023 `"Tonga"', add
	label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
	label define bpld_lbl 71025 `"Western Samoa"', add
	label define bpld_lbl 71029 `"Polynesia, ns"', add
	label define bpld_lbl 71030 `"Christmas Island"', add
	label define bpld_lbl 71031 `"Cocos Islands"', add
	label define bpld_lbl 71032 `"Kiribati"', add
	label define bpld_lbl 71033 `"Canton and Enderbury"', add
	label define bpld_lbl 71034 `"Nauru"', add
	label define bpld_lbl 71035 `"Niue"', add
	label define bpld_lbl 71036 `"Pitcairn Island"', add
	label define bpld_lbl 71037 `"Tokelau"', add
	label define bpld_lbl 71038 `"Tuvalu"', add
	label define bpld_lbl 71039 `"Micronesia, ns"', add
	label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
	label define bpld_lbl 71041 `"Marshall Islands"', add
	label define bpld_lbl 71042 `"Micronesia"', add
	label define bpld_lbl 71043 `"Kosrae"', add
	label define bpld_lbl 71044 `"Pohnpei"', add
	label define bpld_lbl 71045 `"Truk"', add
	label define bpld_lbl 71046 `"Yap"', add
	label define bpld_lbl 71047 `"Northern Mariana Islands"', add
	label define bpld_lbl 71048 `"Palau"', add
	label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
	label define bpld_lbl 71050 `"Clipperton Island"', add
	label define bpld_lbl 71090 `"Oceania, ns/nec"', add
	label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
	label define bpld_lbl 80010 `"Bouvet Islands"', add
	label define bpld_lbl 80020 `"British Antarctic Terr."', add
	label define bpld_lbl 80030 `"Dronning Maud Land"', add
	label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
	label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
	label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
	label define bpld_lbl 90010 `"Abroad, ns"', add
	label define bpld_lbl 90011 `"Abroad (US citizen)"', add
	label define bpld_lbl 90020 `"At sea"', add
	label define bpld_lbl 90021 `"At sea (US citizen)"', add
	label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
	label define bpld_lbl 95000 `"Other, nec"', add
	label define bpld_lbl 99900 `"Missing/blank"', add
	label values bpld bpld_lbl

	label define yrimmig_lbl 0000 `"N/A"'
	label define yrimmig_lbl 1790 `"1790"', add
	label define yrimmig_lbl 1791 `"1791"', add
	label define yrimmig_lbl 1792 `"1792"', add
	label define yrimmig_lbl 1793 `"1793"', add
	label define yrimmig_lbl 1794 `"1794"', add
	label define yrimmig_lbl 1795 `"1795"', add
	label define yrimmig_lbl 1796 `"1796"', add
	label define yrimmig_lbl 1797 `"1797"', add
	label define yrimmig_lbl 1798 `"1798"', add
	label define yrimmig_lbl 1799 `"1799"', add
	label define yrimmig_lbl 1800 `"1800"', add
	label define yrimmig_lbl 1801 `"1801"', add
	label define yrimmig_lbl 1802 `"1802"', add
	label define yrimmig_lbl 1803 `"1803"', add
	label define yrimmig_lbl 1804 `"1804"', add
	label define yrimmig_lbl 1805 `"1805"', add
	label define yrimmig_lbl 1806 `"1806"', add
	label define yrimmig_lbl 1807 `"1807"', add
	label define yrimmig_lbl 1808 `"1808"', add
	label define yrimmig_lbl 1809 `"1809"', add
	label define yrimmig_lbl 1810 `"1810"', add
	label define yrimmig_lbl 1811 `"1811"', add
	label define yrimmig_lbl 1812 `"1812"', add
	label define yrimmig_lbl 1813 `"1813"', add
	label define yrimmig_lbl 1814 `"1814"', add
	label define yrimmig_lbl 1815 `"1815"', add
	label define yrimmig_lbl 1816 `"1816"', add
	label define yrimmig_lbl 1817 `"1817"', add
	label define yrimmig_lbl 1818 `"1818"', add
	label define yrimmig_lbl 1819 `"1819"', add
	label define yrimmig_lbl 1820 `"1820"', add
	label define yrimmig_lbl 1821 `"1821"', add
	label define yrimmig_lbl 1822 `"1822"', add
	label define yrimmig_lbl 1823 `"1823"', add
	label define yrimmig_lbl 1824 `"1824"', add
	label define yrimmig_lbl 1825 `"1825"', add
	label define yrimmig_lbl 1826 `"1826"', add
	label define yrimmig_lbl 1827 `"1827"', add
	label define yrimmig_lbl 1828 `"1828"', add
	label define yrimmig_lbl 1829 `"1829"', add
	label define yrimmig_lbl 1830 `"1830"', add
	label define yrimmig_lbl 1831 `"1831"', add
	label define yrimmig_lbl 1832 `"1832"', add
	label define yrimmig_lbl 1833 `"1833"', add
	label define yrimmig_lbl 1834 `"1834"', add
	label define yrimmig_lbl 1835 `"1835"', add
	label define yrimmig_lbl 1836 `"1836"', add
	label define yrimmig_lbl 1837 `"1837"', add
	label define yrimmig_lbl 1838 `"1838"', add
	label define yrimmig_lbl 1839 `"1839"', add
	label define yrimmig_lbl 1840 `"1840"', add
	label define yrimmig_lbl 1841 `"1841"', add
	label define yrimmig_lbl 1842 `"1842"', add
	label define yrimmig_lbl 1843 `"1843"', add
	label define yrimmig_lbl 1844 `"1844"', add
	label define yrimmig_lbl 1845 `"1845"', add
	label define yrimmig_lbl 1846 `"1846"', add
	label define yrimmig_lbl 1847 `"1847"', add
	label define yrimmig_lbl 1848 `"1848"', add
	label define yrimmig_lbl 1849 `"1849"', add
	label define yrimmig_lbl 1850 `"1850"', add
	label define yrimmig_lbl 1851 `"1851"', add
	label define yrimmig_lbl 1852 `"1852"', add
	label define yrimmig_lbl 1853 `"1853"', add
	label define yrimmig_lbl 1854 `"1854"', add
	label define yrimmig_lbl 1855 `"1855"', add
	label define yrimmig_lbl 1856 `"1856"', add
	label define yrimmig_lbl 1857 `"1857"', add
	label define yrimmig_lbl 1858 `"1858"', add
	label define yrimmig_lbl 1859 `"1859"', add
	label define yrimmig_lbl 1860 `"1860"', add
	label define yrimmig_lbl 1861 `"1861"', add
	label define yrimmig_lbl 1862 `"1862"', add
	label define yrimmig_lbl 1863 `"1863"', add
	label define yrimmig_lbl 1864 `"1864"', add
	label define yrimmig_lbl 1865 `"1865"', add
	label define yrimmig_lbl 1866 `"1866"', add
	label define yrimmig_lbl 1867 `"1867"', add
	label define yrimmig_lbl 1868 `"1868"', add
	label define yrimmig_lbl 1869 `"1869"', add
	label define yrimmig_lbl 1870 `"1870"', add
	label define yrimmig_lbl 1871 `"1871"', add
	label define yrimmig_lbl 1872 `"1872"', add
	label define yrimmig_lbl 1873 `"1873"', add
	label define yrimmig_lbl 1874 `"1874"', add
	label define yrimmig_lbl 1875 `"1875"', add
	label define yrimmig_lbl 1876 `"1876"', add
	label define yrimmig_lbl 1877 `"1877"', add
	label define yrimmig_lbl 1878 `"1878"', add
	label define yrimmig_lbl 1879 `"1879"', add
	label define yrimmig_lbl 1880 `"1880"', add
	label define yrimmig_lbl 1881 `"1881"', add
	label define yrimmig_lbl 1882 `"1882"', add
	label define yrimmig_lbl 1883 `"1883"', add
	label define yrimmig_lbl 1884 `"1884"', add
	label define yrimmig_lbl 1885 `"1885"', add
	label define yrimmig_lbl 1886 `"1886"', add
	label define yrimmig_lbl 1887 `"1887"', add
	label define yrimmig_lbl 1888 `"1888"', add
	label define yrimmig_lbl 1889 `"1889"', add
	label define yrimmig_lbl 1890 `"1890"', add
	label define yrimmig_lbl 1891 `"1891"', add
	label define yrimmig_lbl 1892 `"1892"', add
	label define yrimmig_lbl 1893 `"1893"', add
	label define yrimmig_lbl 1894 `"1894"', add
	label define yrimmig_lbl 1895 `"1895"', add
	label define yrimmig_lbl 1896 `"1896"', add
	label define yrimmig_lbl 1897 `"1897"', add
	label define yrimmig_lbl 1898 `"1898"', add
	label define yrimmig_lbl 1899 `"1899"', add
	label define yrimmig_lbl 1900 `"1900"', add
	label define yrimmig_lbl 1901 `"1901"', add
	label define yrimmig_lbl 1902 `"1902"', add
	label define yrimmig_lbl 1903 `"1903"', add
	label define yrimmig_lbl 1904 `"1904"', add
	label define yrimmig_lbl 1905 `"1905"', add
	label define yrimmig_lbl 1906 `"1906"', add
	label define yrimmig_lbl 1907 `"1907"', add
	label define yrimmig_lbl 1908 `"1908"', add
	label define yrimmig_lbl 1909 `"1909"', add
	label define yrimmig_lbl 1910 `"1910 (2000-onward: 1910 or earlier)"', add
	label define yrimmig_lbl 1911 `"1911"', add
	label define yrimmig_lbl 1912 `"1912"', add
	label define yrimmig_lbl 1913 `"1913"', add
	label define yrimmig_lbl 1914 `"1914 (1970 PUMS, 2000 5%/1%: 1911-1914)"', add
	label define yrimmig_lbl 1915 `"1915"', add
	label define yrimmig_lbl 1916 `"1916"', add
	label define yrimmig_lbl 1917 `"1917"', add
	label define yrimmig_lbl 1918 `"1918"', add
	label define yrimmig_lbl 1919 `"1919 (2000 5%/1%: 1915-1919; pre 2012 ACS: 1919 or earlier)"', add
	label define yrimmig_lbl 1920 `"1920"', add
	label define yrimmig_lbl 1921 `"1921 (1921 or earlier 2012 ACS)"', add
	label define yrimmig_lbl 1922 `"1922 (1922-1923 2012 ACS)"', add
	label define yrimmig_lbl 1923 `"1923"', add
	label define yrimmig_lbl 1924 `"1924 (1970 PUMS: 1915-1924, 2012 ACS: 1924-1925)"', add
	label define yrimmig_lbl 1925 `"1925"', add
	label define yrimmig_lbl 1926 `"1926 (1926-1927 2012 ACS)"', add
	label define yrimmig_lbl 1927 `"1927"', add
	label define yrimmig_lbl 1928 `"1928 (1928-1929 2012 ACS)"', add
	label define yrimmig_lbl 1929 `"1929"', add
	label define yrimmig_lbl 1930 `"1930 (1930-1931 2012 ACS)"', add
	label define yrimmig_lbl 1931 `"1931"', add
	label define yrimmig_lbl 1932 `"1932: (2005-onward pre 2012 ACS: 1931-1932, 2012 ACS: 1932-1934)"', add
	label define yrimmig_lbl 1933 `"1933"', add
	label define yrimmig_lbl 1934 `"1934 (1970 PUMS: 1925-1934; 2000 5%/1%: 1930-1934; 2005-onward ACS: 1933-1934)"', add
	label define yrimmig_lbl 1935 `"1935 (1935-1936 2012 ACS)"', add
	label define yrimmig_lbl 1936 `"1936"', add
	label define yrimmig_lbl 1937 `"1937 (1937-1938 2012 ACS)"', add
	label define yrimmig_lbl 1938 `"1938"', add
	label define yrimmig_lbl 1939 `"1939"', add
	label define yrimmig_lbl 1940 `"1940"', add
	label define yrimmig_lbl 1941 `"1941"', add
	label define yrimmig_lbl 1942 `"1942"', add
	label define yrimmig_lbl 1943 `"1943 (1943-1944 2012 ACS)"', add
	label define yrimmig_lbl 1944 `"1944 (1970 PUMS: 1935-1944)"', add
	label define yrimmig_lbl 1945 `"1945"', add
	label define yrimmig_lbl 1946 `"1946"', add
	label define yrimmig_lbl 1947 `"1947"', add
	label define yrimmig_lbl 1948 `"1948"', add
	label define yrimmig_lbl 1949 `"1949 (1970 PUMS: 1945-1949; 1980-1990 PUMS: 1949 or earlier)"', add
	label define yrimmig_lbl 1950 `"1950"', add
	label define yrimmig_lbl 1951 `"1951"', add
	label define yrimmig_lbl 1952 `"1952"', add
	label define yrimmig_lbl 1953 `"1953"', add
	label define yrimmig_lbl 1954 `"1954 (1970 PUMS: 1950-1954)"', add
	label define yrimmig_lbl 1955 `"1955"', add
	label define yrimmig_lbl 1956 `"1956"', add
	label define yrimmig_lbl 1957 `"1957"', add
	label define yrimmig_lbl 1958 `"1958"', add
	label define yrimmig_lbl 1959 `"1959 (1970 PUMS: 1955-1959; 1980-1990 PUMS: 1950-1959)"', add
	label define yrimmig_lbl 1960 `"1960"', add
	label define yrimmig_lbl 1961 `"1961"', add
	label define yrimmig_lbl 1962 `"1962"', add
	label define yrimmig_lbl 1963 `"1963"', add
	label define yrimmig_lbl 1964 `"1964 (1970-1990 PUMS: 1960-1964)"', add
	label define yrimmig_lbl 1965 `"1965"', add
	label define yrimmig_lbl 1966 `"1966"', add
	label define yrimmig_lbl 1967 `"1967"', add
	label define yrimmig_lbl 1968 `"1968"', add
	label define yrimmig_lbl 1969 `"1969 (1980-1990 PUMS: 1965-1969)"', add
	label define yrimmig_lbl 1970 `"1970 (1970 PUMS: 1965-1970)"', add
	label define yrimmig_lbl 1971 `"1971"', add
	label define yrimmig_lbl 1972 `"1972"', add
	label define yrimmig_lbl 1973 `"1973"', add
	label define yrimmig_lbl 1974 `"1974 (1980-1990 PUMS: 1970-1974)"', add
	label define yrimmig_lbl 1975 `"1975"', add
	label define yrimmig_lbl 1976 `"1976"', add
	label define yrimmig_lbl 1977 `"1977"', add
	label define yrimmig_lbl 1978 `"1978"', add
	label define yrimmig_lbl 1979 `"1979 (1990 PUMS: 1975-1979)"', add
	label define yrimmig_lbl 1980 `"1980 (1980 PUMS: 1975-1980)"', add
	label define yrimmig_lbl 1981 `"1981 (1990 PUMS: 1980-1981)"', add
	label define yrimmig_lbl 1982 `"1982"', add
	label define yrimmig_lbl 1983 `"1983"', add
	label define yrimmig_lbl 1984 `"1984 (1990 PUMS: 1982-1984)"', add
	label define yrimmig_lbl 1985 `"1985"', add
	label define yrimmig_lbl 1986 `"1986 (1990 PUMS: 1985-1986)"', add
	label define yrimmig_lbl 1987 `"1987"', add
	label define yrimmig_lbl 1988 `"1988"', add
	label define yrimmig_lbl 1989 `"1989"', add
	label define yrimmig_lbl 1990 `"1990 (1990 PUMS: 1987-1990)"', add
	label define yrimmig_lbl 1991 `"1991"', add
	label define yrimmig_lbl 1992 `"1992"', add
	label define yrimmig_lbl 1993 `"1993"', add
	label define yrimmig_lbl 1994 `"1994"', add
	label define yrimmig_lbl 1995 `"1995"', add
	label define yrimmig_lbl 1996 `"1996"', add
	label define yrimmig_lbl 1997 `"1997"', add
	label define yrimmig_lbl 1998 `"1998"', add
	label define yrimmig_lbl 1999 `"1999"', add
	label define yrimmig_lbl 2000 `"2000"', add
	label define yrimmig_lbl 2001 `"2001"', add
	label define yrimmig_lbl 2002 `"2002"', add
	label define yrimmig_lbl 2003 `"2003"', add
	label define yrimmig_lbl 2004 `"2004"', add
	label define yrimmig_lbl 2005 `"2005"', add
	label define yrimmig_lbl 2006 `"2006"', add
	label define yrimmig_lbl 2007 `"2007"', add
	label define yrimmig_lbl 2008 `"2008"', add
	label define yrimmig_lbl 2009 `"2009"', add
	label define yrimmig_lbl 2010 `"2010"', add
	label define yrimmig_lbl 2011 `"2011"', add
	label define yrimmig_lbl 2012 `"2012"', add
	label define yrimmig_lbl 0996 `"Not reported"', add
	label values yrimmig yrimmig_lbl

	label define languaged_lbl 0000 `"N/A or blank"'
	label define languaged_lbl 0100 `"English"', add
	label define languaged_lbl 0110 `"Jamaican Creole"', add
	label define languaged_lbl 0120 `"Krio, Pidgin Krio"', add
	label define languaged_lbl 0130 `"Hawaiian Pidgin"', add
	label define languaged_lbl 0140 `"Pidgin"', add
	label define languaged_lbl 0150 `"Gullah, Geechee"', add
	label define languaged_lbl 0160 `"Saramacca"', add
	label define languaged_lbl 0200 `"German"', add
	label define languaged_lbl 0210 `"Austrian"', add
	label define languaged_lbl 0220 `"Swiss"', add
	label define languaged_lbl 0230 `"Luxembourgian"', add
	label define languaged_lbl 0240 `"Pennsylvania Dutch"', add
	label define languaged_lbl 0300 `"Yiddish, Jewish"', add
	label define languaged_lbl 0310 `"Jewish"', add
	label define languaged_lbl 0320 `"Yiddish"', add
	label define languaged_lbl 0400 `"Dutch"', add
	label define languaged_lbl 0410 `"Dutch, Flemish, Belgian"', add
	label define languaged_lbl 0420 `"Afrikaans"', add
	label define languaged_lbl 0430 `"Frisian"', add
	label define languaged_lbl 0440 `"Dutch, Afrikaans, Frisian"', add
	label define languaged_lbl 0460 `"Belgian"', add
	label define languaged_lbl 0470 `"Flemish"', add
	label define languaged_lbl 0500 `"Swedish"', add
	label define languaged_lbl 0600 `"Danish"', add
	label define languaged_lbl 0700 `"Norwegian"', add
	label define languaged_lbl 0800 `"Icelandic"', add
	label define languaged_lbl 0810 `"Faroese"', add
	label define languaged_lbl 1000 `"Italian"', add
	label define languaged_lbl 1010 `"Rhaeto-Romanic, Ladin"', add
	label define languaged_lbl 1030 `"Romansh"', add
	label define languaged_lbl 1100 `"French"', add
	label define languaged_lbl 1110 `"French, Walloon"', add
	label define languaged_lbl 1120 `"Provencal"', add
	label define languaged_lbl 1130 `"Patois"', add
	label define languaged_lbl 1140 `"French or Haitian Creole"', add
	label define languaged_lbl 1150 `"Cajun"', add
	label define languaged_lbl 1200 `"Spanish"', add
	label define languaged_lbl 1210 `"Catalonian, Valencian"', add
	label define languaged_lbl 1220 `"Ladino, Sefaradit, Spanol"', add
	label define languaged_lbl 1230 `"Pachuco"', add
	label define languaged_lbl 1250 `"Mexican"', add
	label define languaged_lbl 1300 `"Portuguese"', add
	label define languaged_lbl 1310 `"Papia Mentae"', add
	label define languaged_lbl 1400 `"Rumanian"', add
	label define languaged_lbl 1500 `"Celtic"', add
	label define languaged_lbl 1520 `"Welsh"', add
	label define languaged_lbl 1530 `"Breton"', add
	label define languaged_lbl 1540 `"Irish Gaelic, Gaelic"', add
	label define languaged_lbl 1550 `"Gaelic"', add
	label define languaged_lbl 1560 `"Irish"', add
	label define languaged_lbl 1570 `"Scottish Gaelic"', add
	label define languaged_lbl 1580 `"Scotch"', add
	label define languaged_lbl 1590 `"Manx, Manx Gaelic"', add
	label define languaged_lbl 1600 `"Greek"', add
	label define languaged_lbl 1700 `"Albanian"', add
	label define languaged_lbl 1800 `"Russian"', add
	label define languaged_lbl 1810 `"Russian, Great Russian"', add
	label define languaged_lbl 1820 `"Bielo-, White Russian"', add
	label define languaged_lbl 1900 `"Ukrainian, Ruthenian, Little Russian"', add
	label define languaged_lbl 1910 `"Ruthenian"', add
	label define languaged_lbl 1920 `"Little Russian"', add
	label define languaged_lbl 1930 `"Ukranian"', add
	label define languaged_lbl 2000 `"Czech"', add
	label define languaged_lbl 2010 `"Bohemian"', add
	label define languaged_lbl 2020 `"Moravian"', add
	label define languaged_lbl 2100 `"Polish"', add
	label define languaged_lbl 2110 `"Kashubian, Slovincian"', add
	label define languaged_lbl 2200 `"Slovak"', add
	label define languaged_lbl 2300 `"Serbo-Croatian, Yugoslavian, Slavonian"', add
	label define languaged_lbl 2310 `"Croatian"', add
	label define languaged_lbl 2320 `"Serbian"', add
	label define languaged_lbl 2331 `"Dalmatian"', add
	label define languaged_lbl 2332 `"Montenegrin"', add
	label define languaged_lbl 2400 `"Slovene"', add
	label define languaged_lbl 2500 `"Lithuanian"', add
	label define languaged_lbl 2510 `"Lettish"', add
	label define languaged_lbl 2600 `"Other Balto-Slavic"', add
	label define languaged_lbl 2610 `"Bulgarian"', add
	label define languaged_lbl 2620 `"Lusatian, Sorbian,  Wendish"', add
	label define languaged_lbl 2621 `"Wendish"', add
	label define languaged_lbl 2630 `"Macedonian"', add
	label define languaged_lbl 2700 `"Slavic unknown"', add
	label define languaged_lbl 2800 `"Armenian"', add
	label define languaged_lbl 2900 `"Persian, Iranian, Farssi"', add
	label define languaged_lbl 2910 `"Persian"', add
	label define languaged_lbl 3010 `"Pashto, Afghan"', add
	label define languaged_lbl 3020 `"Kurdish"', add
	label define languaged_lbl 3030 `"Balochi"', add
	label define languaged_lbl 3040 `"Tadzhik"', add
	label define languaged_lbl 3050 `"Ossete"', add
	label define languaged_lbl 3100 `"Hindi and related"', add
	label define languaged_lbl 3101 `"Hindi, Hindustani, Indic, Jaipuri, Pali, Urdu"', add
	label define languaged_lbl 3102 `"Hindi"', add
	label define languaged_lbl 3103 `"Urdu"', add
	label define languaged_lbl 3111 `"Sanskrit"', add
	label define languaged_lbl 3112 `"Bengali"', add
	label define languaged_lbl 3113 `"Panjabi"', add
	label define languaged_lbl 3114 `"Marathi"', add
	label define languaged_lbl 3115 `"Gujarathi"', add
	label define languaged_lbl 3116 `"Bihari"', add
	label define languaged_lbl 3117 `"Rajasthani"', add
	label define languaged_lbl 3118 `"Oriya"', add
	label define languaged_lbl 3119 `"Assamese"', add
	label define languaged_lbl 3120 `"Kashmiri"', add
	label define languaged_lbl 3121 `"Sindhi"', add
	label define languaged_lbl 3122 `"Maldivian"', add
	label define languaged_lbl 3123 `"Sinhalese"', add
	label define languaged_lbl 3130 `"Kannada"', add
	label define languaged_lbl 3140 `"India nec"', add
	label define languaged_lbl 3150 `"Pakistan nec"', add
	label define languaged_lbl 3190 `"Other Indo-European languages"', add
	label define languaged_lbl 3200 `"Romany, Gypsy"', add
	label define languaged_lbl 3210 `"Gypsy"', add
	label define languaged_lbl 3300 `"Finnish"', add
	label define languaged_lbl 3400 `"Magyar, Hungarian"', add
	label define languaged_lbl 3401 `"Magyar"', add
	label define languaged_lbl 3402 `"Hungarian"', add
	label define languaged_lbl 3500 `"Uralic"', add
	label define languaged_lbl 3510 `"Estonian, Ingrian, Livonian, Vepsian,  Votic"', add
	label define languaged_lbl 3520 `"Lapp, Inari, Kola, Lule, Pite, Ruija, Skolt, Ume"', add
	label define languaged_lbl 3530 `"Other Uralic"', add
	label define languaged_lbl 3600 `"Turkish"', add
	label define languaged_lbl 3700 `"Other Altaic"', add
	label define languaged_lbl 3701 `"Chuvash"', add
	label define languaged_lbl 3702 `"Karakalpak"', add
	label define languaged_lbl 3703 `"Kazakh"', add
	label define languaged_lbl 3704 `"Kirghiz"', add
	label define languaged_lbl 3705 `"Karachay, Tatar, Balkar, Bashkir, Kumyk"', add
	label define languaged_lbl 3706 `"Uzbek, Uighur"', add
	label define languaged_lbl 3707 `"Azerbaijani"', add
	label define languaged_lbl 3708 `"Turkmen"', add
	label define languaged_lbl 3709 `"Yakut"', add
	label define languaged_lbl 3710 `"Mongolian"', add
	label define languaged_lbl 3711 `"Tungus"', add
	label define languaged_lbl 3800 `"Caucasian, Georgian, Avar"', add
	label define languaged_lbl 3810 `"Georgian"', add
	label define languaged_lbl 3900 `"Basque"', add
	label define languaged_lbl 4000 `"Dravidian"', add
	label define languaged_lbl 4001 `"Brahui"', add
	label define languaged_lbl 4002 `"Gondi"', add
	label define languaged_lbl 4003 `"Telugu"', add
	label define languaged_lbl 4004 `"Malayalam"', add
	label define languaged_lbl 4005 `"Tamil"', add
	label define languaged_lbl 4010 `"Bhili"', add
	label define languaged_lbl 4011 `"Nepali"', add
	label define languaged_lbl 4100 `"Kurukh"', add
	label define languaged_lbl 4110 `"Munda"', add
	label define languaged_lbl 4200 `"Burashaski"', add
	label define languaged_lbl 4300 `"Chinese"', add
	label define languaged_lbl 4301 `"Chinese, Cantonese, Min, Yueh"', add
	label define languaged_lbl 4302 `"Cantonese"', add
	label define languaged_lbl 4303 `"Mandarin"', add
	label define languaged_lbl 4311 `"Hakka, Fukien, Kechia"', add
	label define languaged_lbl 4312 `"Kan, Nan Chang"', add
	label define languaged_lbl 4313 `"Hsiang, Chansa, Hunan,  Iyan"', add
	label define languaged_lbl 4314 `"Fuchow, Min Pei"', add
	label define languaged_lbl 4315 `"Wu"', add
	label define languaged_lbl 4400 `"Tibetan"', add
	label define languaged_lbl 4410 `"Miao-Yao, Mien"', add
	label define languaged_lbl 4420 `"Miao, Hmong"', add
	label define languaged_lbl 4500 `"Burmese, Lisu, Lolo"', add
	label define languaged_lbl 4510 `"Karen"', add
	label define languaged_lbl 4600 `"Kachin"', add
	label define languaged_lbl 4700 `"Thai, Siamese, Lao"', add
	label define languaged_lbl 4710 `"Thai"', add
	label define languaged_lbl 4720 `"Laotian"', add
	label define languaged_lbl 4800 `"Japanese"', add
	label define languaged_lbl 4900 `"Korean"', add
	label define languaged_lbl 5000 `"Vietnamese"', add
	label define languaged_lbl 5110 `"Ainu"', add
	label define languaged_lbl 5120 `"Mon-Khmer, Cambodian"', add
	label define languaged_lbl 5130 `"Siberian, n.e.c."', add
	label define languaged_lbl 5140 `"Yukagir"', add
	label define languaged_lbl 5150 `"Muong"', add
	label define languaged_lbl 5200 `"Indonesian"', add
	label define languaged_lbl 5210 `"Buginese"', add
	label define languaged_lbl 5220 `"Moluccan"', add
	label define languaged_lbl 5230 `"Achinese"', add
	label define languaged_lbl 5240 `"Balinese"', add
	label define languaged_lbl 5250 `"Cham"', add
	label define languaged_lbl 5260 `"Madurese"', add
	label define languaged_lbl 5270 `"Malay"', add
	label define languaged_lbl 5280 `"Minangkabau"', add
	label define languaged_lbl 5290 `"Other Asian languages"', add
	label define languaged_lbl 5310 `"Formosan, Taiwanese"', add
	label define languaged_lbl 5320 `"Javanese"', add
	label define languaged_lbl 5330 `"Malagasy"', add
	label define languaged_lbl 5340 `"Sundanese"', add
	label define languaged_lbl 5400 `"Filipino, Tagalog"', add
	label define languaged_lbl 5410 `"Bisayan"', add
	label define languaged_lbl 5420 `"Sebuano"', add
	label define languaged_lbl 5430 `"Pangasinan"', add
	label define languaged_lbl 5440 `"Llocano, Hocano"', add
	label define languaged_lbl 5450 `"Bikol"', add
	label define languaged_lbl 5460 `"Pampangan"', add
	label define languaged_lbl 5470 `"Gorontalo"', add
	label define languaged_lbl 5480 `"Palau"', add
	label define languaged_lbl 5501 `"Micronesian"', add
	label define languaged_lbl 5502 `"Carolinian"', add
	label define languaged_lbl 5503 `"Chamorro, Guamanian"', add
	label define languaged_lbl 5504 `"Gilbertese"', add
	label define languaged_lbl 5505 `"Kusaiean"', add
	label define languaged_lbl 5506 `"Marshallese"', add
	label define languaged_lbl 5507 `"Mokilese"', add
	label define languaged_lbl 5508 `"Mortlockese"', add
	label define languaged_lbl 5509 `"Nauruan"', add
	label define languaged_lbl 5510 `"Ponapean"', add
	label define languaged_lbl 5511 `"Trukese"', add
	label define languaged_lbl 5512 `"Ulithean, Fais"', add
	label define languaged_lbl 5513 `"Woleai-Ulithi"', add
	label define languaged_lbl 5514 `"Yapese"', add
	label define languaged_lbl 5520 `"Melanesian"', add
	label define languaged_lbl 5521 `"Polynesian"', add
	label define languaged_lbl 5522 `"Samoan"', add
	label define languaged_lbl 5523 `"Tongan"', add
	label define languaged_lbl 5524 `"Niuean"', add
	label define languaged_lbl 5525 `"Tokelauan"', add
	label define languaged_lbl 5526 `"Fijian"', add
	label define languaged_lbl 5527 `"Marquesan"', add
	label define languaged_lbl 5528 `"Rarotongan"', add
	label define languaged_lbl 5529 `"Maori"', add
	label define languaged_lbl 5530 `"Nukuoro, Kapingarangan"', add
	label define languaged_lbl 5590 `"Other Pacific Island languages"', add
	label define languaged_lbl 5600 `"Hawaiian"', add
	label define languaged_lbl 5700 `"Arabic"', add
	label define languaged_lbl 5720 `"Egyptian"', add
	label define languaged_lbl 5750 `"Maltese"', add
	label define languaged_lbl 5800 `"Near East Arabic dialect"', add
	label define languaged_lbl 5810 `"Syriac, Aramaic,  Chaldean"', add
	label define languaged_lbl 5820 `"Syrian"', add
	label define languaged_lbl 5900 `"Hebrew, Israeli"', add
	label define languaged_lbl 6000 `"Amharic, Ethiopian, etc."', add
	label define languaged_lbl 6110 `"Berber"', add
	label define languaged_lbl 6120 `"Chadic, Hamitic, Hausa"', add
	label define languaged_lbl 6130 `"Cushite, Beja, Somali"', add
	label define languaged_lbl 6300 `"Nilotic"', add
	label define languaged_lbl 6301 `"Nilo-Hamitic"', add
	label define languaged_lbl 6302 `"Nubian"', add
	label define languaged_lbl 6303 `"Saharan"', add
	label define languaged_lbl 6304 `"Nilo-Saharan, Fur, Songhai"', add
	label define languaged_lbl 6305 `"Khoisan"', add
	label define languaged_lbl 6306 `"Sudanic"', add
	label define languaged_lbl 6307 `"Bantu (many subheads)"', add
	label define languaged_lbl 6308 `"Swahili"', add
	label define languaged_lbl 6309 `"Mande"', add
	label define languaged_lbl 6310 `"Fulani"', add
	label define languaged_lbl 6311 `"Gur"', add
	label define languaged_lbl 6312 `"Kru"', add
	label define languaged_lbl 6313 `"Efik, Ibibio, Tiv"', add
	label define languaged_lbl 6314 `"Mbum, Gbaya, Sango, Zande"', add
	label define languaged_lbl 6390 `"Other specified African languages"', add
	label define languaged_lbl 6400 `"African, n.s."', add
	label define languaged_lbl 7000 `"American Indian (all)"', add
	label define languaged_lbl 7100 `"Aleut, Eskimo"', add
	label define languaged_lbl 7110 `"Aleut"', add
	label define languaged_lbl 7120 `"Pacific Gulf Yupik"', add
	label define languaged_lbl 7130 `"Eskimo"', add
	label define languaged_lbl 7140 `"Inupik, Innuit"', add
	label define languaged_lbl 7150 `"St Lawrence Isl. Yupik"', add
	label define languaged_lbl 7160 `"Yupik"', add
	label define languaged_lbl 7200 `"Algonquian"', add
	label define languaged_lbl 7201 `"Arapaho"', add
	label define languaged_lbl 7202 `"Atsina, Gros Ventre"', add
	label define languaged_lbl 7203 `"Blackfoot"', add
	label define languaged_lbl 7204 `"Cheyenne"', add
	label define languaged_lbl 7205 `"Cree"', add
	label define languaged_lbl 7206 `"Delaware, Lenni-Lenape"', add
	label define languaged_lbl 7207 `"Fox, Sac"', add
	label define languaged_lbl 7208 `"Kickapoo"', add
	label define languaged_lbl 7209 `"Menomini"', add
	label define languaged_lbl 7210 `"Metis, French Cree"', add
	label define languaged_lbl 7211 `"Miami"', add
	label define languaged_lbl 7212 `"Micmac"', add
	label define languaged_lbl 7213 `"Ojibwa, Chippewa"', add
	label define languaged_lbl 7214 `"Ottawa"', add
	label define languaged_lbl 7215 `"Passamaquoddy, Malecite"', add
	label define languaged_lbl 7216 `"Penobscot"', add
	label define languaged_lbl 7217 `"Abnaki"', add
	label define languaged_lbl 7218 `"Potawatomi"', add
	label define languaged_lbl 7219 `"Shawnee"', add
	label define languaged_lbl 7300 `"Salish, Flathead"', add
	label define languaged_lbl 7301 `"Lower Chehalis"', add
	label define languaged_lbl 7302 `"Upper Chehalis, Chehalis, Satsop"', add
	label define languaged_lbl 7303 `"Clallam"', add
	label define languaged_lbl 7304 `"Coeur dAlene, Skitsamish"', add
	label define languaged_lbl 7305 `"Columbia, Chelan, Wenatchee"', add
	label define languaged_lbl 7306 `"Cowlitz"', add
	label define languaged_lbl 7307 `"Nootsack"', add
	label define languaged_lbl 7308 `"Okanogan"', add
	label define languaged_lbl 7309 `"Puget Sound Salish"', add
	label define languaged_lbl 7310 `"Quinault, Queets"', add
	label define languaged_lbl 7311 `"Tillamook"', add
	label define languaged_lbl 7312 `"Twana"', add
	label define languaged_lbl 7313 `"Kalispel"', add
	label define languaged_lbl 7314 `"Spokane"', add
	label define languaged_lbl 7400 `"Athapascan"', add
	label define languaged_lbl 7401 `"Ahtena"', add
	label define languaged_lbl 7402 `"Han"', add
	label define languaged_lbl 7403 `"Ingalit"', add
	label define languaged_lbl 7404 `"Koyukon"', add
	label define languaged_lbl 7405 `"Kuchin"', add
	label define languaged_lbl 7406 `"Upper Kuskokwim"', add
	label define languaged_lbl 7407 `"Tanaina"', add
	label define languaged_lbl 7408 `"Tanana, Minto"', add
	label define languaged_lbl 7409 `"Tanacross"', add
	label define languaged_lbl 7410 `"Upper Tanana, Nabesena, Tetlin"', add
	label define languaged_lbl 7411 `"Tutchone"', add
	label define languaged_lbl 7412 `"Chasta Costa, Chetco, Coquille, Smith, River Athapascan"', add
	label define languaged_lbl 7413 `"Hupa"', add
	label define languaged_lbl 7420 `"Apache"', add
	label define languaged_lbl 7421 `"Jicarilla, Lipan"', add
	label define languaged_lbl 7422 `"Chiricahua, Mescalero"', add
	label define languaged_lbl 7423 `"San Carlos, Cibecue, White Mountain"', add
	label define languaged_lbl 7424 `"Kiowa-Apache"', add
	label define languaged_lbl 7430 `"Kiowa"', add
	label define languaged_lbl 7440 `"Eyak"', add
	label define languaged_lbl 7450 `"Other Athapascan-Eyak, Cahto, Mattole, Wailaki"', add
	label define languaged_lbl 7490 `"Other Algonquin languages"', add
	label define languaged_lbl 7500 `"Navajo/Navaho"', add
	label define languaged_lbl 7610 `"Klamath, Modoc"', add
	label define languaged_lbl 7620 `"Nez Perce"', add
	label define languaged_lbl 7630 `"Sahaptian, Celilo, Klikitat, Palouse, Tenino, Umatilla, Warm"', add
	label define languaged_lbl 7700 `"Mountain Maidu, Maidu"', add
	label define languaged_lbl 7701 `"Northwest Maidu, Concow"', add
	label define languaged_lbl 7702 `"Southern Maidu, Nisenan"', add
	label define languaged_lbl 7703 `"Coast Miwok, Bodega, Marin"', add
	label define languaged_lbl 7704 `"Plains Mowak"', add
	label define languaged_lbl 7705 `"Sierra Miwok, Miwok"', add
	label define languaged_lbl 7706 `"Nomlaki, Tehama"', add
	label define languaged_lbl 7707 `"Patwin, Colouse, Suisun"', add
	label define languaged_lbl 7708 `"Wintun"', add
	label define languaged_lbl 7709 `"Foothill North Yokuts"', add
	label define languaged_lbl 7710 `"Tachi"', add
	label define languaged_lbl 7711 `"Santiam, Calapooya, Waputa"', add
	label define languaged_lbl 7712 `"Siuslaw, Coos, Lower Umpqua"', add
	label define languaged_lbl 7713 `"Tsimshian"', add
	label define languaged_lbl 7714 `"Upper Chinook, Clackamas, Multnomah, Wasco, Wishram"', add
	label define languaged_lbl 7715 `"Chinook Jargon"', add
	label define languaged_lbl 7800 `"Zuni"', add
	label define languaged_lbl 7900 `"Yuman"', add
	label define languaged_lbl 7910 `"Upriver Yuman"', add
	label define languaged_lbl 7920 `"Cocomaricopa"', add
	label define languaged_lbl 7930 `"Mohave"', add
	label define languaged_lbl 7940 `"Diegueno"', add
	label define languaged_lbl 7950 `"Delta River Yuman"', add
	label define languaged_lbl 7960 `"Upland Yuman"', add
	label define languaged_lbl 7970 `"Havasupai"', add
	label define languaged_lbl 7980 `"Walapai"', add
	label define languaged_lbl 7990 `"Yavapai"', add
	label define languaged_lbl 8000 `"Achumawi"', add
	label define languaged_lbl 8010 `"Atsugewi"', add
	label define languaged_lbl 8020 `"Karok"', add
	label define languaged_lbl 8030 `"Pomo"', add
	label define languaged_lbl 8040 `"Shastan"', add
	label define languaged_lbl 8050 `"Washo"', add
	label define languaged_lbl 8060 `"Chumash"', add
	label define languaged_lbl 8101 `"Crow, Absaroke"', add
	label define languaged_lbl 8102 `"Hidatsa"', add
	label define languaged_lbl 8103 `"Mandan"', add
	label define languaged_lbl 8104 `"Dakota, Lakota, Nakota, Sioux"', add
	label define languaged_lbl 8105 `"Chiwere"', add
	label define languaged_lbl 8106 `"Winnebago"', add
	label define languaged_lbl 8107 `"Kansa, Kaw"', add
	label define languaged_lbl 8108 `"Omaha"', add
	label define languaged_lbl 8109 `"Osage"', add
	label define languaged_lbl 8110 `"Ponca"', add
	label define languaged_lbl 8111 `"Quapaw, Arkansas"', add
	label define languaged_lbl 8210 `"Alabama"', add
	label define languaged_lbl 8220 `"Choctaw, Chickasaw"', add
	label define languaged_lbl 8230 `"Mikasuki"', add
	label define languaged_lbl 8240 `"Hichita, Apalachicola"', add
	label define languaged_lbl 8250 `"Koasati"', add
	label define languaged_lbl 8260 `"Muskogee, Creek, Seminole"', add
	label define languaged_lbl 8300 `"Keres"', add
	label define languaged_lbl 8400 `"Iroquoian"', add
	label define languaged_lbl 8410 `"Mohawk"', add
	label define languaged_lbl 8420 `"Oneida"', add
	label define languaged_lbl 8430 `"Onandaga"', add
	label define languaged_lbl 8440 `"Cayuga"', add
	label define languaged_lbl 8450 `"Seneca"', add
	label define languaged_lbl 8460 `"Tuscarora"', add
	label define languaged_lbl 8470 `"Wyando, Huran"', add
	label define languaged_lbl 8480 `"Cherokee"', add
	label define languaged_lbl 8500 `"Caddoan"', add
	label define languaged_lbl 8510 `"Arikara"', add
	label define languaged_lbl 8520 `"Pawnee"', add
	label define languaged_lbl 8530 `"Wichita"', add
	label define languaged_lbl 8601 `"Comanche"', add
	label define languaged_lbl 8602 `"Mono, Owens Valley Paiute"', add
	label define languaged_lbl 8603 `"Paiute"', add
	label define languaged_lbl 8604 `"Northern Paiute, Bannock, Num, Snake"', add
	label define languaged_lbl 8605 `"Southern Paiute"', add
	label define languaged_lbl 8606 `"Chemehuevi"', add
	label define languaged_lbl 8607 `"Kawaiisu"', add
	label define languaged_lbl 8608 `"Ute"', add
	label define languaged_lbl 8609 `"Shoshoni"', add
	label define languaged_lbl 8610 `"Panamint"', add
	label define languaged_lbl 8620 `"Hopi"', add
	label define languaged_lbl 8630 `"Cahuilla"', add
	label define languaged_lbl 8631 `"Cupeno"', add
	label define languaged_lbl 8632 `"Luiseno"', add
	label define languaged_lbl 8633 `"Serrano"', add
	label define languaged_lbl 8640 `"Tubatulabal"', add
	label define languaged_lbl 8700 `"Pima, Papago"', add
	label define languaged_lbl 8800 `"Yaqui"', add
	label define languaged_lbl 8810 `"Sonoran n.e.c., Cahita, Guassave, Huichole, Nayit, Tarahumar"', add
	label define languaged_lbl 8910 `"Aztecan, Mexicano, Nahua"', add
	label define languaged_lbl 9010 `"Picuris, Northern Tiwa, Taos"', add
	label define languaged_lbl 9020 `"Tiwa, Isleta"', add
	label define languaged_lbl 9030 `"Sandia"', add
	label define languaged_lbl 9040 `"Tewa, Hano, Hopi-Tewa, San Ildefonso, San Juan, Santa Clara"', add
	label define languaged_lbl 9050 `"Towa"', add
	label define languaged_lbl 9100 `"Wiyot"', add
	label define languaged_lbl 9101 `"Yurok"', add
	label define languaged_lbl 9110 `"Kwakiutl"', add
	label define languaged_lbl 9111 `"Nootka"', add
	label define languaged_lbl 9112 `"Makah"', add
	label define languaged_lbl 9120 `"Kutenai"', add
	label define languaged_lbl 9130 `"Haida"', add
	label define languaged_lbl 9131 `"Tlingit, Chilkat, Sitka, Tongass, Yakutat"', add
	label define languaged_lbl 9140 `"Tonkawa"', add
	label define languaged_lbl 9150 `"Yuchi"', add
	label define languaged_lbl 9160 `"Chetemacha"', add
	label define languaged_lbl 9170 `"Yuki"', add
	label define languaged_lbl 9171 `"Wappo"', add
	label define languaged_lbl 9200 `"Misumalpan"', add
	label define languaged_lbl 9210 `"Mayan languages"', add
	label define languaged_lbl 9220 `"Tarascan"', add
	label define languaged_lbl 9230 `"Mapuche"', add
	label define languaged_lbl 9240 `"Oto-Manguen"', add
	label define languaged_lbl 9250 `"Quechua"', add
	label define languaged_lbl 9260 `"Aymara"', add
	label define languaged_lbl 9270 `"Arawakian"', add
	label define languaged_lbl 9280 `"Chibchan"', add
	label define languaged_lbl 9290 `"Tupi-Guarani"', add
	label define languaged_lbl 9300 `"American Indian, n.s."', add
	label define languaged_lbl 9400 `"Native"', add
	label define languaged_lbl 9410 `"Other specified American Indian languages"', add
	label define languaged_lbl 9420 `"South/Central American Indian"', add
	label define languaged_lbl 9500 `"No language"', add
	label define languaged_lbl 9600 `"Other or not reported"', add
	label define languaged_lbl 9601 `"Other n.e.c."', add
	label define languaged_lbl 9602 `"Other n.s."', add
	label values languaged languaged_lbl

	label define speakeng_lbl 0 `"N/A (Blank)"'
	label define speakeng_lbl 1 `"Does not speak English"', add
	label define speakeng_lbl 2 `"Yes, speaks English..."', add
	label define speakeng_lbl 3 `"Yes, speaks only English"', add
	label define speakeng_lbl 4 `"Yes, speaks very well"', add
	label define speakeng_lbl 5 `"Yes, speaks well"', add
	label define speakeng_lbl 6 `"Yes, but not well"', add
	label define speakeng_lbl 7 `"Unknown"', add
	label define speakeng_lbl 8 `"Illegible"', add
	label values speakeng speakeng_lbl

	label define school_lbl 0 `"N/A"'
	label define school_lbl 1 `"No, not in school"', add
	label define school_lbl 2 `"Yes, in school"', add
	label define school_lbl 9 `"Missing"', add
	label values school school_lbl

	label define educd_lbl 000 `"N/A or no schooling"'
	label define educd_lbl 001 `"N/A"', add
	label define educd_lbl 002 `"No schooling completed"', add
	label define educd_lbl 010 `"Nursery school to grade 4"', add
	label define educd_lbl 011 `"Nursery school, preschool"', add
	label define educd_lbl 012 `"Kindergarten"', add
	label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
	label define educd_lbl 014 `"Grade 1"', add
	label define educd_lbl 015 `"Grade 2"', add
	label define educd_lbl 016 `"Grade 3"', add
	label define educd_lbl 017 `"Grade 4"', add
	label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
	label define educd_lbl 021 `"Grade 5 or 6"', add
	label define educd_lbl 022 `"Grade 5"', add
	label define educd_lbl 023 `"Grade 6"', add
	label define educd_lbl 024 `"Grade 7 or 8"', add
	label define educd_lbl 025 `"Grade 7"', add
	label define educd_lbl 026 `"Grade 8"', add
	label define educd_lbl 030 `"Grade 9"', add
	label define educd_lbl 040 `"Grade 10"', add
	label define educd_lbl 050 `"Grade 11"', add
	label define educd_lbl 060 `"Grade 12"', add
	label define educd_lbl 061 `"12th grade, no diploma"', add
	label define educd_lbl 062 `"High school graduate or GED"', add
	label define educd_lbl 063 `"Regular high school diploma"', add
	label define educd_lbl 064 `"GED or alternative credential"', add
	label define educd_lbl 065 `"Some college, but less than 1 year"', add
	label define educd_lbl 070 `"1 year of college"', add
	label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
	label define educd_lbl 080 `"2 years of college"', add
	label define educd_lbl 081 `"Associates degree, type not specified"', add
	label define educd_lbl 082 `"Associates degree, occupational program"', add
	label define educd_lbl 083 `"Associates degree, academic program"', add
	label define educd_lbl 090 `"3 years of college"', add
	label define educd_lbl 100 `"4 years of college"', add
	label define educd_lbl 101 `"Bachelors degree"', add
	label define educd_lbl 110 `"5+ years of college"', add
	label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
	label define educd_lbl 112 `"7 years of college"', add
	label define educd_lbl 113 `"8+ years of college"', add
	label define educd_lbl 114 `"Masters degree"', add
	label define educd_lbl 115 `"Professional degree beyond a bachelors degree"', add
	label define educd_lbl 116 `"Doctoral degree"', add
	label values educd educd_lbl

	label define empstat_lbl 0 `"N/A"'
	label define empstat_lbl 1 `"Employed"', add
	label define empstat_lbl 2 `"Unemployed"', add
	label define empstat_lbl 3 `"Not in labor force"', add
	label values empstat empstat_lbl

	label define labforce_lbl 0 `"N/A"'
	label define labforce_lbl 1 `"No, not in the labor force"', add
	label define labforce_lbl 2 `"Yes, in the labor force"', add
	label values labforce labforce_lbl

	label define classwkrd_lbl 00 `"N/A"'
	label define classwkrd_lbl 10 `"Self-employed"', add
	label define classwkrd_lbl 11 `"Employer"', add
	label define classwkrd_lbl 12 `"Working on own account"', add
	label define classwkrd_lbl 13 `"Self-employed, not incorporated"', add
	label define classwkrd_lbl 14 `"Self-employed, incorporated"', add
	label define classwkrd_lbl 20 `"Works for wages"', add
	label define classwkrd_lbl 21 `"Works on salary (1920)"', add
	label define classwkrd_lbl 22 `"Wage/salary, private"', add
	label define classwkrd_lbl 23 `"Wage/salary at non-profit"', add
	label define classwkrd_lbl 24 `"Wage/salary, government"', add
	label define classwkrd_lbl 25 `"Federal govt employee"', add
	label define classwkrd_lbl 26 `"Armed forces"', add
	label define classwkrd_lbl 27 `"State govt employee"', add
	label define classwkrd_lbl 28 `"Local govt employee"', add
	label define classwkrd_lbl 29 `"Unpaid family worker"', add
	label values classwkrd classwkrd_lbl

	label define wkswork1_lbl 00 `"00"'
	label values wkswork1 wkswork1_lbl

	label define wkswork2_lbl 0 `"N/A"'
	label define wkswork2_lbl 1 `"1-13 weeks"', add
	label define wkswork2_lbl 2 `"14-26 weeks"', add
	label define wkswork2_lbl 3 `"27-39 weeks"', add
	label define wkswork2_lbl 4 `"40-47 weeks"', add
	label define wkswork2_lbl 5 `"48-49 weeks"', add
	label define wkswork2_lbl 6 `"50-52 weeks"', add
	label values wkswork2 wkswork2_lbl

	label define uhrswork_lbl 00 `"00"'
	label values uhrswork uhrswork_lbl

	label define incwage_lbl 999999 `"N/A"'
	label values incwage incwage_lbl
	
	save ./temp/census_raw.dta, replace
		
*
* 1.2: Define variables for immigrants, children of immigrants, and refugee group.
*

	* Collapse US codes
	replace bpld = 09900 if bpld <= 09900
	
	* Generate immigrant dummy
	gen byte immigrant = 1 if bpld != 09900
	replace immigrant = 0 if bpld == 09900
	
	* Identify child immigrants
	* Note that there is some imprecision inherent in these rules.  The reason is that we have age (as of Census/ACS)
	*		(Note: Census is April 1, 2000; ACS is spread evenly throughout the year)
	* and year of immigration.  So we cannot compute exact age at immigration.
	* This has relevance in two ways.  First, age "3" at immigration may mean "2" or "4".  
	* Second, some will have age at immigration of -1 even though they actually immigrated at 0; recode all of these. 
	gen int birthyear = year - age
	gen byte aa = yrimmig - birthyear
	replace aa = 0 if aa == -1 & immigrant == 1
	drop if aa < -1 & immigrant == 1
	replace aa = 0 if bpld == 09900
	
	* Identify those who were potentially born in camps.
	* Focus on ethnic Khmer, Lao, and Hmong from Thailand who immigrated in the right years.
	* Vietnamese and especially ethnic Chinese transited through too many countries and are too difficult to separate
	* from individuals born in the countries of asylum.
	* For example, an ethnic Chinese born in Hong Kong may be a refugee from Vietnam, or a native of Hong Kong. 
	gen byte birc = 1 if (yrimmig >= 1976 & yrimmig <= 1990) &  (bpld == 51700) & (raced == 660 | raced == 661 | raced == 662)
	replace birc = 0 if missing(birc)
	
	* Form immigrants into a few key groups
	* 1: Indochinese refugees.  Cambodians, 1976-1990; Laotians, 1976-1994; Vietnamese, 1976-1996
	* 2: African/Middle Eastern refugees.  Afghanistan, 1980-1993; Ethiopia, 1980-1993
	* 3: Cuban immigrant, likely refugee, all years
	* 4: Generic "poor country" immigrants, whose 2005 PPP GDP p.w. in 2005 prices is less than 5% of US level, according to PWT
	*	Excludes Cambodia and Laos to get some new information.
	*	Haiti, Bangladesh, Nepal, Ghana, Guinea, Liberia, Senegal, Sierra Leone, Kenya, Somalia, Tanzania,
	*   Uganda, Zimbabwe, Eritrea
	* 5: Mexican
	* 6: Germans
	* 7: American
	gen byte countrygroup = 1 if (bpld == 51100 & yrimmig >= 1976 & yrimmig <= 1990) | (bpld == 51300 & yrimmig >= 1976 & yrimmig <= 1994) | (bpld == 51800 & yrimmig >= 1976 & yrimmig <= 1996)
	replace countrygroup = 2 if (bpld == 52000 & yrimmig >= 1980 & yrimmig <= 1993) | (bpld == 60044 & yrimmig >= 1980 & yrimmig <= 1993) 
	replace countrygroup = 3 if bpld == 25000
	replace countrygroup = 4 if bpld == 26020 | bpld == 52100 | bpld == 52400 | bpld == 60023 | bpld == 60024 | bpld == 60027 | bpld == 60032 | bpld == 60033 | bpld == 60045 | bpld == 60053 | bpld == 60054 | bpld == 60055 | bpld == 60057 | bpld == 60065
	replace countrygroup = 5 if bpld == 20000
	replace countrygroup = 6 if bpld == 45300
	replace countrygroup = 7 if bpld == 09900
	
	* Break Indochinese refugees into subgroups for analysis and robustness.
	*   subgroup1 distinguishes 5 ethnic groups; subgroup2 distinguishes 3 country of birth groups
	*	subgroup3 distinguishes early vs. late arrivals; and subgroup4 distinguishes 5 language groups. 
	* 1-1: Indochinese, ethnic Chinese
	* 1-2: Indochinese, ethnic Vietnamese
	* 1-3: Indochinese, ethnic Khmer
	* 1-4: Indochinese, ethnic Hmong
	* 1-5: Indochinese, ethnic Lao
	* 2-1: Cambodian only
	* 2-2: Laotian only
	* 2-3: Vietnamese only
	* 3-1: Indochinese, 1976-1981 (pre-improved medical screening)
	* 3-2: Indochinese, 1982+ (post-improved medical screening)
	* 4-1: Indochinese, speaks Chinese; Chinese-Cantonese, Min, Yueh; Cantonese; or Hsiang, Chansa, Hunan, Iyan (all Chinese variants)
	* 4-2: Indochinese, speaks Miao/Hmong (language of the Hmong)
	* 4-3: Indochinese, speaks Laotian (official language of Laos, mostly for lowland peoples)
	* 4-4: Indochinese, speaks Vietnamese (Vietnamese, non-Chinese)
	* 4-5: Indochinese, speaks Mon-Khmer, Cambodian (Cambodian/Khmer, obviously)
	gen byte subgroup1 = 1 if (countrygroup == 1 | birc == 1) & raced == 400
	replace subgroup1 = 2 if (countrygroup == 1 | birc == 1) & raced == 640
	replace subgroup1 = 3 if (countrygroup == 1 | birc == 1) & raced == 660
	replace subgroup1 = 4 if (countrygroup == 1 | birc == 1) & raced == 661
	replace subgroup1 = 5 if (countrygroup == 1 | birc == 1) & raced == 662
	gen byte subgroup2 = 1 if countrygroup == 1 & bpld == 51100
	replace subgroup2 = 2 if countrygroup == 1 & bpld == 51300
	replace subgroup2 = 3 if countrygroup == 1 & bpld == 51800
	gen byte subgroup3 = 1 if countrygroup == 1 & yrimmig <= 1981
	replace subgroup3 = 2 if countrygroup == 1 & yrimmig >= 1982
	gen byte subgroup4 = 1 if countrygroup == 1 & (languaged == 4300 | languaged == 4301 | languaged == 4302 | languaged == 4313)
	replace subgroup4 = 2 if countrygroup == 1 & languaged == 4420
	replace subgroup4 = 3 if countrygroup == 1 & languaged == 4720
	replace subgroup4 = 4 if countrygroup == 1 & languaged == 5000
	replace subgroup4 = 5 if countrygroup == 1 & languaged == 5120
	
	replace subgroup1 = 0 if bpld == 09900
	replace subgroup2 = 0 if bpld == 09900
	replace subgroup3 = 0 if bpld == 09900
	replace subgroup4 = 0 if bpld == 09900
	
*
* 1.3: Limit sample to people of interest: 23-60 year olds not enrolled in school;
*		if immigrants, those immigrated at the ages of potential interest. 
*

	keep if age >= 23 & age <= 60
	keep if (aa >= 0 & aa <= 22) | immigrant == 0
	drop if school == 2

*
* 1.4: Define wages, schooling, working and so on for relevant groups
*

* Recode schooling 
	drop if educd <= 1
	gen yrschl = 0 if educd == 2 | educd == 11 | educd == 12
	replace yrschl = 2 if educd == 10
	replace yrschl = 2.5 if educd == 13
	replace yrschl = 1 if educd == 14
	replace yrschl = 2 if educd == 15
	replace yrschl = 3 if educd == 16
	replace yrschl = 4 if educd == 17
	replace yrschl = 6.5 if educd == 20
	replace yrschl = 5.5 if educd == 21
	replace yrschl = 5 if educd == 22
	replace yrschl = 6 if educd == 23
	replace yrschl = 7.5 if educd == 24
	replace yrschl = 7 if educd == 25
	replace yrschl = 8 if educd == 26
	replace yrschl = 9 if educd == 30
	replace yrschl = 10 if educd == 40
	replace yrschl = 11 if educd == 50
	replace yrschl = 12 if educd == 60 | educd == 61 | educd == 62 | educd == 63 | educd == 64 | educd == 65
	replace yrschl = 13 if educd == 70 | educd == 71
	replace yrschl = 14 if educd == 80 | educd == 81 | educd == 82 | educd == 83
	replace yrschl = 15 if educd == 90
	replace yrschl = 16 if educd == 100 | educd == 101
	replace yrschl = 17 if educd == 110
	replace yrschl = 18 if educd == 111 | educd == 114
	replace yrschl = 19 if educd == 112
	replace yrschl = 20 if educd == 113 | educd == 115 | educd == 116
	drop educ educd
	
	* Impute weeks worked from the intervalled variable when necessary
	save ./temp/census_sample.dta, replace
	keep if year == 2007
	collapse (mean) wkswork1_avg=wkswork1 [pw=perwt], by(wkswork2)
	save ./temp/hours.dta, replace
	use ./temp/census_sample.dta, clear
	merge wkswork2 using ./temp/hours.dta, uniqusing sort
	drop _merge*
	replace wkswork1 = wkswork1_avg if year >= 2008

	
	* Generate a sample of wage workers, 
	gen byte wagesample = 1 if empstat == 1 & (classwkrd == 21 | classwkrd == 22 | classwkrd == 25 | classwkrd == 27 | classwkrd == 28)
	replace wagesample = 0 if missing(wagesample)
	replace wagesample = 0 if wkswork1 < 30 | uhrswork < 30
	replace wagesample = 0 if incwage == 0 | incwage == 999999
	
	* Generate wages for wage workers. 	
	gen logwage = log(incwage/(uhrswork*wkswork1))
	replace incwage = log(incwage)

	* Generate potential experience 
	gen pe = (age - yrschl - 6)
	replace wagesample = 0 if pe < 0 | pe > 40
	
	* Generate a dummy variable for being institutionalized
	gen byte institution = 1 if gq == 3
	replace institution = 0 if missing(institution) & (year == 2000 | (year >= 2006 & year <= 2012))
	replace wagesample = 0 if institution == 1
	
	* Generate a dummy variable for being separated/divorced. 
	gen byte divorced = 1 if marst == 3 | marst == 4
	replace divorced = 1 if (marst == 1 | marst == 2) & (marrno >= 2) & year >= 2008
	replace divorced = 0 if missing(divorced)
	
	* Generate a dummy variable for being employed
	gen byte employed = 1 if empstat == 1
	replace employed = 0 if missing(employed)
	
	* Generate an integer for four basic regions of US, for immigrants only. 
	gen int region = 1 if statefip == 9 | statefip == 23 | statefip == 25 | statefip == 33 | statefip == 34 | statefip == 36 | statefip == 42 | statefip == 44 | statefip == 50 
	replace region = 2 if statefip == 17 | statefip == 18 | statefip == 19 | statefip == 20 | statefip == 26 | statefip == 27 | statefip == 29 | statefip == 31 | statefip == 38 | statefip == 39 | statefip == 46 |  statefip == 55
	replace region = 3 if statefip == 1 | statefip == 5 | statefip == 10 | statefip == 11 | statefip == 12 | statefip == 13 | statefip == 21 | statefip == 22 | statefip == 24 | statefip == 28 | statefip == 37 | statefip == 40 | statefip == 45 | statefip == 47 | statefip == 48 | statefip == 51 | statefip == 54 
	replace region = 4 if statefip == 2 | statefip == 4 | statefip == 6 | statefip == 8 | statefip == 15 | statefip == 16 | statefip == 30 | statefip == 32 | statefip == 35 | statefip == 41 | statefip == 49 | statefip == 53 | statefip == 56
	replace region = 0 if immigrant == 0
	
	* Renormalize sex so that male is 0 and female 1 (convenient for regressions)
	replace sex = sex - 1
	
	drop uhrswork wkswork1 wkswork1_avg wkswork2 uhrswork empstat classwkrd school gq languaged speakeng marst marrno birthyear
	save ./temp/census_sample.dta, replace
	
	**********
	
		
*
* 1.5: Measure refugees who live in ethnic enclaves.
* 		Since geographic codes are relatively constant from 2000+ this works well.  
*

	use ./temp/census_raw.dta, clear
	
	* Definition 1: A high ethnic concentration in a PUMA
	
	* Fix the one PUMA inconsistency: New Orleans after Katrina
	replace puma = 77777 if (puma == 01801 | puma == 01802 | puma == 0195) & statefip == 22
		
	gen chineseind = 1 if raced == 400
	replace chineseind = 0 if missing(chineseind)
	gen vietind = 1 if raced == 640
	replace vietind = 0 if missing(vietind)
	gen cambind = 1 if raced == 660
	replace cambind = 0 if missing(cambind)
	gen hmongind = 1 if raced == 661
	replace hmongind = 0 if missing(hmongind)
	gen laosind = 1 if raced == 662
	replace laosind = 0 if missing(laosind)
	gen ind = 1
	
	collapse (sum) chineseind vietind cambind hmongind laosind ind [pw=perwt], by(puma statefip)
	
	replace chineseind = chineseind/ind
	replace vietind = vietind/ind
	replace cambind = cambind/ind
	replace hmongind = hmongind/ind
	replace laosind = laosind/ind
	
	drop ind
	save ./temp/enclave1.dta, replace
	
	* Definition 2: A high ethnic concentration in a METAREAD
	
	use ./temp/census_raw.dta, clear
	gen chineseind2 = 1 if raced == 400
	replace chineseind2 = 0 if missing(chineseind2)
	gen vietind2 = 1 if raced == 640
	replace vietind2 = 0 if missing(vietind2)
	gen cambind2 = 1 if raced == 660
	replace cambind2 = 0 if missing(cambind2)
	gen hmongind2 = 1 if raced == 661
	replace hmongind2 = 0 if missing(hmongind2)
	gen laosind2 = 1 if raced == 662
	replace laosind2 = 0 if missing(laosind2)
	gen ind = 1
	
	collapse (sum) chineseind2 vietind2 cambind2 hmongind2 laosind2 ind [pw=perwt], by(metaread)
	
	replace chineseind2 = chineseind2/ind
	replace vietind2 = vietind2/ind
	replace cambind2 = cambind2/ind
	replace hmongind2 = hmongind2/ind
	replace laosind2 = laosind2/ind
	
	drop ind
	save ./temp/enclave2.dta, replace
	
	* Merge back on and define those who live in enclaves
	
	use ./temp/census_sample.dta, clear
	merge statefip puma using ./temp/enclave1.dta, uniqusing sort
	drop _merge* puma
	merge metaread using ./temp/enclave2.dta, uniqusing sort
	drop _merge* metaread
	
	drop if missing(countrygroup) & birc == 0
	
	gen byte enclave = 0
	replace enclave = 1 if raced == 400 & (chineseind > 0.05 | chineseind2 > 0.025)
	replace enclave = 1 if raced == 640 & (vietind > 0.05 | vietind2 > 0.025)
	replace enclave = 1 if raced == 660 & (cambind > 0.05 | cambind2 > 0.025)
	replace enclave = 1 if raced == 661 & (hmongind > 0.05 | hmongind2 > 0.025)
	replace enclave = 1 if raced == 662 & (laosind > 0.05 | laosind2 > 0.025)
	
	summ enclave if subgroup1 > 0 & ~missing(subgroup1)
	* Knocks off about 30% of Indochinese refugees.
	
	drop raced chineseind* vietind* cambind* hmongind* laosind*
	
*
* 1.6: Save a common file for re-use.
*
	
	* All regressions use year, age, and state of origin dummies, so pre-define these to save time.
	xi i.year i.age i.statefip, noomit prefix(_J)
	drop _Jyear_2000 _Jstatefip_1 
	
	compress
	
	save ./temp/census_sample.dta, replace
	
	* Use only 10% of natives - even that's slow to converge.
	gen dummy = runiform() if immigrant == 0
    keep if immigrant == 1 | dummy < 0.1
	
	save ./temp/census_sample_tenPercentDummy.dta, replace
	
	scalar t1 = c(current_time)
	
	* load in this 10% sample takes ~ 129 seconds
	use ./temp/census_sample_tenPercentDummy.dta, clear
	
	* this takes ~ 15+ minutes
	* use ./temp/census_sample.dta, clear
	
	scalar t2 = c(current_time)

	display (clock(t2, "hms") - clock(t1, "hms")) / 1000 " seconds"


*************************************************************************************
*************************************************************************************
*************************************************************************************

Step 2: Main group testing.

For each of the five main group ethnic groups,
Study the effect on outcomes of age at arrival, as compared to natives.
Outcomes are wages, school completion, earnings, and probability of
being employed, institutionalized, college graduate, or divorced. 


*************************************************************************************
*************************************************************************************
*************************************************************************************



* PAPER FIGURE 2 & TABLE 1

*
* 2.1: Outcome 1: Wages
*
	use ./temp/census_sample_tenPercentDummy.dta, clear 
	* use ./temp/census_sample.dta, clear

	keep if wagesample == 1
	keep if birc == 0
	keep if aa <= 5 | immigrant == 0
	keep if countrygroup == 1 | countrygroup == 7
	drop if missing(subgroup1)
	
	
	* overview of immigrants
	tabulate subgroup1 if immigrant == 1
	
	* PAPER TABLE 1: POOLED
	xi i.subgroup1
	reg logwage aa sex _I* _J* [aw=perwt], robust
	estimates store Model1a_pool
	*reg logwage aa sex _I* _J* [aw=perwt], vce(jackknife)
	*estimates store Model1b_pool
	* PAPER TABLE 1: BY ETHNIC GROUP
	xi i.subgroup1 i.subgroup1*aa
	reg logwage aa sex _I* _J* [aw=perwt], robust
	estimates store Model2a_ethnic
	
	* se
	nlcom (_b[aa]+_b[_IsubXaa_1])
	nlcom (_b[aa]+_b[_IsubXaa_2])
	nlcom (_b[aa]+_b[_IsubXaa_3])
	nlcom (_b[aa]+_b[_IsubXaa_4])
	nlcom (_b[aa]+_b[_IsubXaa_5])
	
	esttab Model1a_pool Model2a_ethnic using ./results/table1.tex, replace booktabs

	
		
	* Nonlinear regression to plot.
	xi i.subgroup1*i.aa, noomit
	drop _Iaa* _Isubgroup1* _IsubXaa_0*
	reg logwage sex _I* _J* [aw=perwt], noconstant robust
	parmest, saving(./temp/parameters1.dta,replace)
	
	* First, find the residual wage variance
	predict logwage_res, residuals
	collapse (sd) logwage_res [aw=perwt], by(aa subgroup1)
	
	list if subgroup1 == 0
	drop if subgroup1 == 0
	
	label var subgroup1 "Ethnicity"
	label define grouptype 1 "Chinese", add
	label define grouptype 2 "Vietnamese", add
	label define grouptype 3 "Khmer", add
	label define grouptype 4 "Hmong", add
	label define grouptype 5 "Lao", add
	label values subgroup1 grouptype
	
	line logwage_res aa, by(subgroup1,ix) xtitle("Age at Arrival") ytitle("Standard Deviation of Residual Wages") xlabel(0(1)5)
	graph export ./results/sd.pdf, replace
	
	
	* Plot the nonlinear regression results
	use ./temp/parameters1.dta, clear
	keep estimate parm min95 max95
	keep if substr(parm,1,8) == "_IsubXaa"
	gen group = substr(parm,10,1)
	gen aa = substr(parm,12,2)
	destring group aa, replace
	drop parm
	
	label var group "Ethnicity"
	label define grouptype 1 "Chinese", add
	label define grouptype 2 "Vietnamese", add
	label define grouptype 3 "Khmer", add
	label define grouptype 4 "Hmong", add
	label define grouptype 5 "Lao", add
	label values group grouptype
	
	set scheme stsj
	line estimate min95 max95 aa, by(group,ix note("") legend(at(6) pos(0) textwidth(6)) ) lpattern(solid dash dash) lwidth(medthick medium medium)  xtitle("Age at Arrival") ytitle("Log Wages, Relative to Natives") legend(order(1 2) label(1 "Parameter estimate") label(2 "95% Confidence Interval") rows(2) forces size(small)) xlabel(0(1)5)
	graph export ./results/Figure2_wages.pdf, replace
    	* PAPER FIGURE 2
	
 
    
************************************************************************************* 


* PAPER FIGURE 4A    
*
* 2.3: Outcome 3: Wages - Later Arrivals
*

	use ./temp/census_sample_tenPercentDummy.dta, clear
	* use ./temp/census_sample.dta, clear
    
    
	keep if wagesample == 1
	keep if birc == 0
	keep if aa <= 22 | immigrant == 0
	keep if countrygroup == 1 | countrygroup == 7
	drop if missing(subgroup1)


	* Nonlinear regression to plot.
	xi i.subgroup1*i.aa, noomit
	drop _Iaa* _Isubgroup1* _IsubXaa_0*
	reg logwage sex _I* _J* [aw=perwt], noconstant robust
	
	parmest, norestore
	keep estimate parm min95 max95
	keep if substr(parm,1,8) == "_IsubXaa"
	gen group = substr(parm,10,1)
	gen aa = substr(parm,12,2)
	destring group aa, replace
	drop parm
	
	label var group "Ethnicity"
	label define grouptype 1 "Chinese", add
	label define grouptype 2 "Vietnamese", add
	label define grouptype 3 "Khmer", add
	label define grouptype 4 "Hmong", add
	label define grouptype 5 "Lao", add
	label values group grouptype
	
	
	set scheme stsj
	
	line estimate min95 max95 aa, by(group,ix note("") legend(at(6) pos(0) textwidth(6))) lpattern(solid dash dash) lwidth(medthick medium medium)  xtitle("Age at Arrival") ytitle("Log-Wages, Relative to Natives") legend(order(1 2) label(1 "Parameter estimate") label(2 "95% Confidence Interval") rows(2) forces size(small)) xlabel(0(5)20)
	graph export ./results/Figure4a_longwages.pdf, replace
	save ./results/wagedata.dta, replace
	
 *************************************************************************************   
    
* PAPER FIGURE 3 & TABLE 1
*	
* 2.4: Outcome 4: Completion
*
	use ./temp/census_sample_tenPercentDummy.dta, clear
	* use ./temp/census_sample.dta, clear
   
	
	keep if birc == 0
	keep if aa <= 5 | immigrant == 0
	keep if countrygroup == 1 | countrygroup == 7
	drop if missing(subgroup1)
	
	* Linear regression to test for trend effects formally.
	
	* overview of immigrants
	tabulate subgroup1 if immigrant == 1
	
	
	* PAPER TABLE 1: POOLED
	xi i.subgroup1
	reg yrschl aa sex _I* _J* [aw=perwt], robust
	estimates store Model3a_pool
	* PAPER TABLE 1: BY ETHNIC GROUP
	xi i.subgroup1 i.subgroup1*aa
	reg yrschl aa sex _I* _J* [aw=perwt], robust
	estimates store Model4a_ethnic
	
	* se
	nlcom (_b[aa]+_b[_IsubXaa_1])
	nlcom (_b[aa]+_b[_IsubXaa_2])
	nlcom (_b[aa]+_b[_IsubXaa_3])
	nlcom (_b[aa]+_b[_IsubXaa_4])
	nlcom (_b[aa]+_b[_IsubXaa_5])
	
	esttab Model3a_pool Model4a_ethnic using ./results/table1b.tex, replace booktabs
	
	
	* Nonlinear regression to plot.
	xi i.subgroup1*i.aa, noomit
	drop _Iaa* _Isubgroup1* _IsubXaa_0*
	reg yrschl sex _I* _J* [aw=perwt], noconstant robust

	parmest, norestore
	keep estimate parm min95 max95
	keep if substr(parm,1,8) == "_IsubXaa"
	gen group = substr(parm,10,1)
	gen aa = substr(parm,12,2)
	destring group aa, replace
	drop parm
	
	label var group "Ethnicity"
	label define grouptype 1 "Chinese", add
	label define grouptype 2 "Vietnamese", add
	label define grouptype 3 "Khmer", add
	label define grouptype 4 "Hmong", add
	label define grouptype 5 "Lao", add
	label values group grouptype
	
	
	set scheme stsj
	
	line estimate min95 max95 aa, by(group,ix note("") legend(at(6) pos(0) textwidth(6))) lpattern(solid dash dash) lwidth(medthick medium medium) xtitle("Age at Arrival") ytitle("Years of Schooling, Relative to Natives") legend(order(1 2) label(1 "Parameter estimate") label(2 "95% Confidence Interval") rows(2) forces size(small)) xlabel(0(1)5)
	graph export ./results/Figure3_school.pdf, replace
    * PAPER FIGURE 3
	
 *************************************************************************************   
    
* PAPER FIGURE 4B    
*	
* 2.5: Outcome 5: Completion  - Older Arrivals
*
	
	use ./temp/census_sample_tenPercentDummy.dta, clear
	* use ./temp/census_sample.dta, clear
    
	
	keep if birc == 0
	keep if aa <= 22 | immigrant == 0
	keep if countrygroup == 1 | countrygroup == 7
	drop if missing(subgroup1)


	* Nonlinear regression to plot.	
	xi i.subgroup1*i.aa, noomit
	drop _Iaa* _Isubgroup1* _IsubXaa_0*
	reg yrschl sex _I* _J* [aw=perwt], noconstant robust
	
	parmest, norestore
	keep estimate parm min95 max95
	keep if substr(parm,1,8) == "_IsubXaa"
	gen group = substr(parm,10,1)
	gen aa = substr(parm,12,2)
	destring group aa, replace
	drop parm
	
	label var group "Ethnicity"
	label define grouptype 1 "Chinese", add
	label define grouptype 2 "Vietnamese", add
	label define grouptype 3 "Khmer", add
	label define grouptype 4 "Hmong", add
	label define grouptype 5 "Lao", add
	label values group grouptype
	
	set scheme stsj
	
	line estimate min95 max95 aa, by(group,ix note("") legend(at(6) pos(0) textwidth(6))) lpattern(solid dash dash) lwidth(medthick medium medium) xtitle("Age at Arrival") ytitle("Years of Schooling, Relative to Natives") legend(order(1 2) label(1 "Parameter estimate") label(2 "95% Confidence Interval") rows(2) forces size(small)) xlabel(0(5)20)
	graph export ./results/Figure4b_longschool.pdf, replace
    	* PAPER FIGURE 4B 

************************************************************************************* 

* PAPER FIGURE 5

*
* 4.2: Other immigrants Wages
*

	use ./temp/census_sample_tenPercentDummy.dta, clear
	* use ./temp/census_sample.dta, clear
    
    
	keep if wagesample == 1
	keep if birc == 0
	keep if aa <= 5 | immigrant == 0
	keep if countrygroup >= 2 & countrygroup != 6
	
	
	* Nonlinear regression to plot.
	xi i.countrygroup*i.aa, noomit
	drop _Iaa* _Icountrygr* _IcouXaa_7*
	reg logwage sex _I* _J* [aw=perwt], noconstant robust
	
	parmest, norestore
	keep estimate parm min95 max95
	keep if substr(parm,1,8) == "_IcouXaa"
	gen group = substr(parm,10,1)
	gen aa = substr(parm,12,2)
	destring group aa, replace
	drop parm
	
	label var group "Immigrant Group"
	label define grouptype 2 "Ethiopian/Afghani Refugee", add
	label define grouptype 3 "Cuban Immigrant", add
	label define grouptype 4 "Poor Country Immigrant", add
	label define grouptype 5 "Mexican Immigrant", add
	label values group grouptype
	
	set scheme stsj
	
	line estimate min95 max95 aa, by(group,ix note("") legend(textwidth(6))) lpattern(solid dash dash) lwidth(medthick medium medium) xtitle("Age at Arrival") ytitle("Log Wages, Relative to Natives") legend(order(1 2) label(1 "Parameter estimate") label(2 "95% Confidence Interval") forces size(small)) xlabel(0(1)5) ylabel(-1(0.5)0.5)
	graph export ./results/Figure5_othergroup_wage.pdf, replace
    	* PAPER FIGURE 5

	
************************************************************************************* 

	log close
	
*
* Program Finished.
*
	
	
