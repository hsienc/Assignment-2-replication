/*
*************************************************************************************
*************************************************************************************
*************************************************************************************

master.do

Calls the other necessary stata files. Cleans up results & temporary folders
to make sure all results are new and all temporary files are destroyed. 

*************************************************************************************
*************************************************************************************
*************************************************************************************

*/

 	! rm -r ./temp/
 	! mkdir ./temp/
 	! rm -r ./results/
	! mkdir ./results/
	
	* for Table/Figure output
	ssc install estout, replace 
	ssc install parmest, replace

************************************************************
******* Download my "ec_adult_modified.do" on Github *******
************************************************************	
	
*	do ec_adolesc.do
*	do ec_family.do
	do ec_adult-modified.do   
*	do ec_sim.do

 	! rm -r ./temp/
 	! mkdir ./temp/


*
* Program Finished.
*
	
	