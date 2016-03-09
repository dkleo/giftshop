<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---Removes a picture from a category and deletes the picture from the server if it exists--->
<cfquery name = "GetOldPic" datasource="#request.dsn#">
SELECT *
FROM categories
WHERE CategoryID = #url.CategoryID#
</cfquery>

<cfoutput query = "GetOldPic">
	<cfif NOT #LinkImage# IS 'None'>
		<cfif FILEEXISTS('#request.CatalogPath#images#request.bslash##LinkImage#')>
			<CFFILE action = "delete" FILE = "#request.CatalogPath#images#request.bslash##LinkImage#">
		</cfif>
	</cfif>
	<cfif NOT #LinkRImage# IS 'None'>
		<cfif FILEEXISTS('#request.CatalogPath#images#request.bslash##LinkRImage#')>
			<CFFILE action = "delete" FILE = "#request.CatalogPath#images#request.bslash##LinkRImage#">
		</cfif>
	</cfif>
</cfoutput>

<cfquery name = "RemoveThePic" datasource="#request.dsn#">
UPDATE categories
SET LinkImage = 'None',
LinkRImage = 'None'
WHERE CategoryID = #url.CategoryID#
</cfquery>

<cflocation url = "index.cfm">





















