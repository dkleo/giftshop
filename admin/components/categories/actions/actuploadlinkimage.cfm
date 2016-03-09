<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif #form.filecontents# IS ''>
	<font face="Verdana" size="2"><b>ERROR:  You did not specify a file to upload.  Hit your browsers back button and try again</b></font>
	<cfabort>
</cfif>

<!---find the old picture and delete to save space on the server--->
<cfquery name = "GetOldPic" datasource="#request.dsn#">
SELECT *
FROM categories
WHERE CategoryID = #form.CategoryID#
</cfquery>

	<!---First delete the old file if there is one--->
	<cfoutput query = "GetOldPic">
	<cfif NOT #LinkImage# IS 'None'>
		<cfif FILEEXISTS('#request.CatalogPath#images#request.bslash##LinkImage#')>
			<cffile action = "delete" FILE = "#request.CatalogPath#images#request.bslash##LinkImage#">
		</cfif>
	</cfif>
	</cfoutput>

<!---Now upload the file--->
	<cfoutput>
	<CFFILE Action="Upload"
				FileField = "Form.filecontents"
				Destination = "#request.CatalogPath#images#request.bslash#"
				NameConflict = "overwrite"
				Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg">
			
		<cfset ThumbNail = #cffile.ServerFile#>
        
		<cfif NOT form.filecontents2 IS ''>
        <CFFILE Action="Upload"
				FileField = "Form.filecontents2"
				Destination = "#request.CatalogPath#images#request.bslash#"
				NameConflict = "overwrite"
				Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg">
			
		<cfset ThumbNail2 = #cffile.ServerFile#>        
        
        <cfelse>
			<cfset ThumbNail2 = 'none'>
		</cfif>
	</cfoutput>

<cfquery name= "UpdatePicture" datasource=#request.dsn#>
UPDATE categories
SET LinkImage='#Thumbnail#',
LinkRImage='#Thumbnail2#'
WHERE CategoryID = #form.CategoryID#
</cfquery>

<cflocation URL = "index.cfm">





















