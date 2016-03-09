<!---reads the images directory in the userfiles folder and inserts the images into the database--->

<cfinclude template = "../queries/qry_checktoken.cfm">

<cfoutput query = "qry_checktoken">
	<cfset theusername = '#username#'>
</cfoutput>

<cf_filemanager action = "list"
		name="mydirectory"
		directory="#request.catalogpath#docs#request.bslash##request.bslash#images"
		TagsToUse="#request.TagsToUse#"
		username="#request.TagUsername#"
		password="#request.TagPassword#"
		>


<cfquery name="qWithoutDotParents" dbtype="Query">
	SELECT  	*
	FROM    	cffile.dirlist
	WHERE   	Name <> '.'
	AND			Name <> '..'
	ORDER BY 	Type
</cfquery>

<cfquery name = "qryFileNames" dbtype="query">
SELECT * FROM qWithoutDotParents WHERE type = 'File'
ORDER BY Name ASC
</cfquery>

<!---query the user_files and then make sure that the file isn't already referenced.  If it is then
	ignore it--->

<cfloop query = "qryFileNames">
	<cfquery name = "qry_userfiles" datasource="#request.dsn#">
	SELECT * FROM user_files WHERE name = '#qryFileNames.Name#'
	</cfquery>

	<cfif qry_userfiles.recordcount IS 0>
	<!---Only import if it's a jpg or gif file--->
		<cfif right(qryFileNames.Name, 3) IS 'jpg' OR right(qryFileNames.Name, 3) IS 'gif'>

			<cfquery name = "qry_InsertFile" datasource="#request.dsn#">
			INSERT INTO user_files
			(name, folder, username, filetype, datelastmodified, size, actualfolder)
			VALUES
			('#qryFileNames.Name#', '/images', '#theusername#', 'image', 
			#CreateODBCdatetime(qryFileNames.DateLastModified)#, '#qryFileNames.Size#', 'images/')
			</cfquery>
		</cfif>			
	</cfif>

</cfloop>

The import process has been completed.  You can now access your product images in the file manager.



















