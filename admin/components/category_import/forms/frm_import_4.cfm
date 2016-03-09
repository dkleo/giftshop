<!---Open the progress bar import window--->
<h2><strong>Category Import Step 4</strong></h2>
<cfsetting requesttimeout="1200">
<cfflush interval="50">

<cfinclude template = "../displays/dsp_progressbar.cfm">  

<cfflush interval="50">

<cfinclude template = "../actions/act_writeimportdata.cfm">

<strong>Items were successfully imported into your catalog! </strong>



















