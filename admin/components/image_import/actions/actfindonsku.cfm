<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT sku, itemid FROM products
</cfquery>

<cfset totalrecordstoimport = qryProducts.recordcount>
<cfset progresscount = 0>

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
<center><span name="MsgArea" id="MsgArea" style="text-align: center;">Looking for images.  Please wait!</span></center>
</td>
</tr>
</table>
</span>
<cfflush interval="100">

<!---loop over the products and use the sku to find files that contain the sku number--->
<cfset image_files = "">

<cfdirectory action="list" directory="#request.catalogpath#photos#request.bslash#large#request.bslash#" name="qryFiles">

<cfloop query = "qryProducts">
	<cfset progresscount = progresscount + 1>
    
	<!---check only files that are valid image formats...if it contains the sku then add it to this one--->
    <cfset imagecount = 1>
    <cfloop query="qryFiles">
		<cfif qryFiles.type IS 'file'>
	        <cfif right(qryFiles.name, 3) is 'jpg' OR right(qryFiles.name, 3) IS 'gif' OR right(qryFiles.name, 3) IS 'png' 
		OR right(qryFiles.name, 4) IS 'jpeg'>
        		<cfset filenoext = replacenocase(qryFiles.name, '.jpg', '')>
				<cfset filenoext = replacenocase(filenoext, '.jpeg', '')>
                <cfset filenoext = replacenocase(filenoext, '.gif', '')>
                <cfset filenoext = replacenocase(filenoext, '.png', '')> 
                                
				<cfif qryFiles.name CONTAINS '#qryProducts.sku#' OR qryProducts.sku CONTAINS '#filenoext#'>
                	<cfset photo = "#qryFiles.name#">
					<cfset thumb = "#qryFiles.name#">				
        
                    <cfinclude template = "../../products/photomanager/actions/actProcessImage.cfm">
        
                    <!---Update the image dimensions in the db--->
                    <cfquery name = "qry_InsertImageInfo" datasource = "#request.dsn#">
                    INSERT INTO products_images
                    (iFilename, ItemID, iHeight, iWidth, thumbHeight, thumbWidth, tinyHeight, tinyWidth, mediumwidth, 
                    mediumheight, OrderValue)
                    VALUES
                    ('#photo#', '#qryProducts.itemid#', #iHeight#, #iWidth#, #ithumbHeight#, #ithumbWidth#, #itinyHeight#,
                    #itinyWidth#, #iMediumwidth#, #iMediumheight#, #imagecount#)
                    </cfquery>
                        
                </cfif>
            </cfif>
		</cfif>
		<cfset imagecount = imagecount + 1>
    </cfloop>
    
    <!---Modify the progress bar--->
	<cfset ProgressPercentage = ProgressCount / totalrecordstoimport>
	<cfset ProgressPercentage = ProgressPercentage * 100>
	<cfset ProgressPercentage = #Round(ProgressPercentage)#>
	
	<cfset NegProgress = 100 - ProgressPercentage>
	
	<cfoutput>
	   
	<cfif ProgressPercentage LT 100>
	<script language="JavaScript">
		document.getElementById('progpos').style.width = "#ProgressPercentage#%";
		document.getElementById('progneg').style.width = "#NegProgress#%";
		document.getElementById("StatusMsg").innerHTML = '#ProgressPercentage#% images (#ProgressCount# of #totalrecordstoimport#).  Please wait...';
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



















