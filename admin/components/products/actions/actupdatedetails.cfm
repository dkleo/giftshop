<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif directoryexists('#request.catalogpath##request.bslash#docs#request.bslash#products#request.bslash#')>
	<cfif NOT directoryexists('#request.catalogpath#docs#request.bslash#products#request.bslash#')>
    	<cfdirectory action="create" directory="#request.catalogpath#docs#request.bslash#products#request.bslash#">
    </cfif>
	
    <cffile action="write" file="#request.catalogpath#docs#request.bslash#products#request.bslash#item#form.itemid#.cfm" output="#form.details#">

<cfelse>
	Failed to write the details HTML because the path #request.catalogpath#docs#request.bslash#products#request.bslash# seems to be inaccessible.  Please check your setting.
	<p>&nbsp;</p>
</cfif>

Details for this item was saved <a href = "doproducts.cfm">Back to products</a>















