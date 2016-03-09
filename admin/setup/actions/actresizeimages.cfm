<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Loops over the "large" image folder which is the original size of the images and recreates all the thumbnails for the image based
on the settings in the companyinfo table--->
<cfsetting requesttimeout="1200">
<cfparam name = "start" default="1">
<cfparam name = "end" default="1">
<cfparam name = "intvl" default="100">
<cfparam name = "TotalFiles" default="0">

<cfflush interval="50">

<!---Show the progress bar--->
<style type="text/css">
<!--
.StatusTable {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	background-position: center center;
}
-->
</style>

<span name = "progressbararea" id="progressbararea">
<p align="center">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td valign="middle">

<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td id="TitleMsg" class="StatusTable" align="center"><div align="left">Image Resize</div></td>
  </tr>
</table>
<table width="75%" align="center" cellpadding="0" cellspacing="0">
<tr>
<td width = "0%" height = "25" bgcolor="#0000CC" id="progpos">&nbsp;</td>
<td width = "100%" height = "25" bgcolor="#000000" id="progneg">&nbsp;</td>
</tr>
</table>
<table width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
   <td class="StatusTable"><span name="StatusMsg" id="StatusMsg">0% Completed</span></td>
  </tr>
</table>
<center><span name="MsgArea" id="MsgArea" style="text-align: center;"></span></center>
</td>
</tr>
</table>
</span>


<cfif start IS 1>
	<cfset progresscount = 0>
	<cfdirectory action="list" directory="#request.catalogpath#photos#request.bslash#large#request.bslash#" name="qryDir">
    <cffile action = "write" file="#request.catalogpath#images_process.txt" output="">
    <cfset totalrecords = qryDir.recordcount>
	<cfset totalfiles = 0>
    <cfloop query = "qryDir">
    	<cfset progresscount = progresscount + 1>
  		<cfif qryDir.type IS 'file'>
		<cfif right(qryDir.name, 3) is 'jpg' OR right(qryDir.name, 3) IS 'gif' OR right(qryDir.name, 3) IS 'png' 
		OR right(qryDir.name, 4) IS 'jpeg'>	
        	<cfset totalfiles = totalfiles + 1>
	        <cffile action = "append" file="#request.catalogpath#images_process.txt" output="#qryDir.name#|">
            
			 <!---Modify the progress bar--->
        
            <cfset ProgressPercentage = ProgressCount / TotalRecords>
            <cfset ProgressPercentage = ProgressPercentage * 100>
            <cfset ProgressPercentage = #Round(ProgressPercentage)#>
            
            <cfset NegProgress = 100 - ProgressPercentage>
            
            <cfoutput>
               
            <cfif ProgressPercentage LT 100>
            <script language="JavaScript">
                document.getElementById('progpos').style.width = "#ProgressPercentage#%";
                document.getElementById('progneg').style.width = "#NegProgress#%";
                document.getElementById("StatusMsg").innerHTML = 'Reading #ProgressPercentage#% file (#ProgressCount# of #TotalRecords#).  Please wait...';
            </script>
            </cfif>
            
            <cfif ProgressPercentage IS 100>
            <script language="JavaScript">
                document.getElementById('progpos').style.width = "#ProgressPercentage#%";
                document.getElementById('progneg').style.width = "#NegProgress#%";
                document.getElementById("StatusMsg").innerHTML = '#ProgressPercentage#% Completed!  Finished reading files.  Resize will now begin...';
            </script>
            </cfif>
            </cfoutput>
            <!---end progress bar update--->            
            
            
		</cfif>        
		</cfif>
	</cfloop>
</cfif> 

<cffile action = "read" file="#request.catalogpath#images_process.txt" variable="qDir">

<cfset ProgressCount = start>

<cfif TotalFiles IS 0>
	ERROR:  It appears as though you have no images uploaded yet!  You need to upload images for your products in order to perform this function.
	<cfabort>
</cfif>

<cfset end = start + intvl>
<cfif end GT listlen(qDir, "|")>
	<cfset end = listlen(qDir, "|")>
</cfif>

<cfloop from="#start#" to="#end#" index="fcount">
	<cfset ProgressCount = ProgressCount + 1>						
		<cfset photo = "#trim(listgetat(qDir, fcount, "|"))#">
        <cfset thumb = "#trim(listgetat(qDir, fcount, "|"))#">			

		<cfset imgok = 'Yes'>

        <cftry> 		      
        <cfinclude template = "../../components/products/photomanager/actions/actProcessImage.cfm">
        <cfcatch type="any">
            <cfoutput>Bad image format: #listgetat(qDir, fcount, "|")# - skipping<br /></cfoutput>
            <cfset imgok = 'No'>
        </cfcatch>
        </cftry>            

        <!---Update the image dimensions in the db--->
        <cfif imgok IS 'Yes'>
        <cfquery name = "qry_InsertImageInfo" datasource = "#request.dsn#">
        UPDATE products_images
        SET iHeight = #iHeight#,
        iWidth = #iWidth#, 
        thumbHeight= #ithumbHeight#, 
        thumbWidth = #ithumbWidth#, 
        tinyHeight = #itinyHeight#, 
        tinyWidth = #itinyWidth#, 
        mediumwidth = #iMediumwidth#, 
        mediumheight = #iMediumheight#
        WHERE iFileName = '#photo#'
        </cfquery>
        </cfif>
	
     <!---Modify the progress bar--->

	<cfset ProgressPercentage = ProgressCount / TotalFiles>
	<cfset ProgressPercentage = ProgressPercentage * 100>
	<cfset ProgressPercentage = #Round(ProgressPercentage)#>
	
	<cfset NegProgress = 100 - ProgressPercentage>
	
	<cfoutput>
	   
	<cfif ProgressPercentage LT 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.getElementById("StatusMsg").innerHTML = '#ProgressPercentage#% images (#ProgressCount# of #TotalFiles#).  Please wait...';
	</script>
	</cfif>
	
	<cfif ProgressPercentage IS 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.getElementById("StatusMsg").innerHTML = '#ProgressPercentage#% Completed!';
	</script>
	</cfif>
	</cfoutput>
	<!---end progress bar update--->		  	  
</cfloop>

<cfif end LT totalfiles>
	<cfset start = end + 1>
    <cfset end = start + 500>
    <cfif end GT totalfiles>
    	<cfset end = totalfiles>
    </cfif>
	 <cfoutput>
	 <center>Preparing for next set of images.  Please wait...</center>
	 <script language="JavaScript">
        <!--
        window.location.replace("dosetup.cfm?action=resizeimages&start=#start#&end=#end#&intvl=#intvl#&totalfiles=#totalfiles#");
        -->	
      </script>
      </cfoutput>
<cfelse>
<p>
<center>Resize complete!</center>
</p>
<p>
<center><a href = "doSetup.cfm?action=variables">View Settings</a></center>
</p>
</cfif>







