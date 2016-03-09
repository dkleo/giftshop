<cfquery name = "qry_UserFolders" datasource="#request.dsn#" username="#request.dsnun#" password="#request.dsnpw#">
SELECT * FROM user_folders
WHERE FolderPath = '#dir#'
ORDER BY name ASC
</cfquery>





















