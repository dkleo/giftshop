<cfquery name = "qry_Areplies" datasource="#request.dsn#">
SELECT * FROM comments 
WHERE approved = '1'
</cfquery>





















