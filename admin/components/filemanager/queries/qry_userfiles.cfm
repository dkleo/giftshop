<cfquery name = "qry_UserFiles" datasource="#request.dsn#" username="#request.dsnun#" password="#request.dsnpw#">
SELECT * FROM user_files
WHERE Folder = '#dir#'
ORDER BY name ASC
</cfquery>





















