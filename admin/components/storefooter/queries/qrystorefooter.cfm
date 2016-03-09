<cfif NOT fileexists('#request.catalogpath#docs#request.bslash#header.cfm')>
	<cffile action = 'write' file="#request.catalogpath#docs#request.bslash#footer.cfm" output=" ">
</cfif>

<cffile action="read" file="#request.catalogpath#docs#request.bslash#footer.cfm" variable="StoreFooter">















