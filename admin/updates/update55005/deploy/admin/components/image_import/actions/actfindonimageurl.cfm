<cfset maxcount = 50>
<cfquery name = "qryProducts" datasource="#request.dsn#">
SELECT imageURL, itemid FROM products
</cfquery>
<cfsetting requesttimeout="1200">
<cfflush interval="50">

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
Note:  You can only import 50 at a time.
<br />
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

<!---loop over the products and use the imageURL to find the file in imageURL--->
<cfset image_files = "">
<cfset imagecount = 1>
<cfset stopcount = 1>
<cfloop query = "qryProducts">

	<cfif stopcount GT 50>
    	You must refresh the page to continue.
		<cfabort>
   </cfif>        

	<cfset progresscount = progresscount + 1>   

		<cfif fileexists('#request.catalogpath#photos#request.bslash#large#request.bslash##qryProducts.imageurl#')>
			
			<cfset imagecount = imagecount + 1>

			<cfset photo = "#qryProducts.imageurl#">
			<cfset thumb = "#qryProducts.imageurl#">
            <cfset iHeight = "400">
            <cfset iWidth = "400">
            <cfset ithumbHeight = "100">
            <cfset ithumbWidth = "100">
			<cfset itinyHeight = "75">
            <cfset itinyWidth = "75">
            <cfset iMediumheight = "300">               
			<cfset iMediumwidth = "300">
            
			<cfif NOT fileexists('#request.catalogpath#photos#request.bslash#medium#request.bslash##qryProducts.imageurl#')>
				<cfset stopcount = stopcount + 1>
                <cfinclude template = "../../products/photomanager/actions/actProcessImage.cfm">
            </cfif>			

            <cfquery name = "qDuplicate" datasource="#request.dsn#">
            SELECT * FROM products_images
            WHERE iFilename = '#photo#' AND ItemID = '#qryProducts.itemid#'
            </cfquery>

            <!---Update the image dimensions in the db--->
            
            <cfif qDuplicate.recordcount IS 0>
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
	
	<cfset imagecount = imagecount + 1>
    
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