
<cfinclude template = "../queries/qryproducts.cfm">
      
<cfoutput query = "qryproducts">

<!---if the details file doesn't exist create it from what is in the db....read the file--->
<cfif NOT fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
	<cffile action="write" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm" output="#details#">
</cfif>

<cfif fileexists('#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm')>
	<cffile action="read" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#itemid#.cfm" variable="thedetails">
</cfif>   

<strong><font size="3" face="Verdana, Arial, Helvetica, sans-serif">Editing 
  Details for #ProductName#</font></strong></cfoutput> 
<center>
<form method="POST" action="doproducts.cfm">
<cfoutput query = "qryproducts">

<textarea name="details" style="width: 100% height: 500px;">#thedetails#</textarea>
<input type="hidden" Name="Action" Value="UpdateDetails">
<input type="hidden" Name="ItemID" Value="#url.ItemID#">
<center><input type="Submit" value="Save" Name="Submit"></center>
</p>
</cfoutput>
</form>
</center>


<script type="text/javascript">
	CKEDITOR.replace( 'details',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '/admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '/admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '/admin/filebrowser/browseflash.cfm'		
	});
</script>