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
	<cfif NOT #CategoryImage# IS 'None'>
		<cfif FILEEXISTS('#request.CatalogPath#images#request.bslash##CategoryImage#')>
        	<CFFILE action = "delete" FILE = "#request.CatalogPath#images#request.bslash##CategoryImage#">
        </cfif>
    </cfif>
	<cfif NOT #CategoryRImage# IS 'None'>
		<cfif FILEEXISTS('#request.CatalogPath#images#request.bslash##CategoryRImage#')>
        	<CFFILE action = "delete" FILE = "#request.CatalogPath#images#request.bslash##CategoryRImage#">
        </cfif>
    </cfif>
</cfoutput>

<cfquery name = "RemoveThePic" datasource="#request.dsn#">
UPDATE categories
SET CategoryImage = 'None',
CategoryRImage = 'None'
WHERE CategoryID = #url.CategoryID#
</cfquery>

<cflocation url = "index.cfm">





















