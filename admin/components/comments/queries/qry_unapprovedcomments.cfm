<cfquery name = "qry_UAreplies" datasource="#request.dsn#">
SELECT * FROM comments 
WHERE approved = '0'
</cfquery>





















