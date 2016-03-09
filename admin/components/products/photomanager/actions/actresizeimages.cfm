<!---Loops over the "large" image folder which is the original size of the images and recreates all the thumbnails for the image based
on the settings in the companyinfo table--->
<cfsetting requesttimeout="1200">
<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">
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
    <td id="TitleMsg" class="StatusTable" align="center"><div align="left">Please wait!</div></td>
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
<center>
  <span name="MsgArea" id="MsgArea" style="text-align: center;">Generating missing thumbnails.  Please wait!</span>
</center>
</td>
</tr>
</table>
</span>
<cfflush interval="100">

<cfset ProgressCount = 0>

<!---This script reads the photos directory and creates the tiny thumb and regular thumb for the
new multi_image feature--->
<cfdirectory action="list" directory="#request.catalogpath#photos#request.bslash#large#request.bslash#" name="qryDir">

<cfset TotalFiles = #qryDir.recordcount#>

<cfif TotalFiles GT 0>
    <cfloop query = "qryDir">
        <cfset ProgressCount = ProgressCount + 1>
        <cfif qryDir.type IS 'file'>
            <cfif right(qryDir.name, 3) is 'jpg' OR right(qryDir.name, 3) IS 'gif' OR right(qryDir.name, 3) IS 'png' 
            OR right(qryDir.name, 4) IS 'jpeg'>						
                <cfset photo = "#qryDir.name#">
                <cfset thumb = "#qryDir.name#">				
    
    			<!---if a thumbnail doesn't already exist for this one, create it--->
    			<cfif NOT fileexists('#request.catalogpath#photos#request.bslash#tiny#request.bslash##photo#')>
    
                    <cfinclude template = "actProcessImage.cfm">
        
                    <!---Update the image dimensions in the db if it's in there already (probably not, but just in case).--->
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
            </cfif>
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
</cfif>
<p>
<center>Thumbnail Generation Completed!</center>
<p>
<cfoutput><center><a href = "dophotomanager.cfm?action=browse&ffield=#ffield#&fname=#fname#&dir=#dir#">Select Your Image</a></center></cfoutput>































