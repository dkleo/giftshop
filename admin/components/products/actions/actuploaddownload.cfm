<!---uploads a file attachment for a product--->

<cfif NOT isnumeric(form.allowedDls)>
	<cfset TheAllowedDls = 5>
<cfelse>
	<cfset TheAllowedDls = #form.AllowedDls#>
</cfif>

<cfif NOT form.attachmentfile IS ''>
	<CFFILE	Action="Upload"
	FileField = "form.attachmentfile"
	Destination = "#request.eItemsPath#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg">
				
	<cfset filename = "#cffile.ServerFile#">
	<cfset filesize = "#cffile.FileSize#">

	<!---Insert into the db if it's not already in there--->
	<cfinclude template = "../queries/qry_attachments.cfm">
	
	<cfif qry_Duplicates.recordcount IS 0>	
		<cfquery name = "qryInsertFile" datasource="#request.dsn#">
		INSERT INTO catalog_files
		(filename, filesize, allowedDls, timesdownloaded, itemid)
		VALUES
		('#filename#','#filesize#',#TheAllowedDls#,0,'#url.itemid#')
		</cfquery>
	</cfif>
</cfif>
















