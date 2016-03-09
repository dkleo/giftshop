<cfquery name = "qry_Page" datasource="#request.dsn#" username="#request.dsnun#" password="#request.dsnpw#">
SELECT * FROM user_files
WHERE fileid = #url.fileid#
</cfquery>




















