<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfif isdefined('form.PageName')>

	<cfset ThePageName = #form.PageName#>
	
	<!---Check to see if they specified an extension--->
	<cfif NOT #form.PageName# CONTAINS '.'>
		<cfset ThePageName = '#form.PageName#.cfm'>
	</cfif>
	
	<!---Now check to see if the extension is acceptable--->
	<cfif NOT right(thepagename, 4) IS '.cfm' AND NOT right(thepagename, 4) IS '.txt'>
		<cfset InvalExtension = right(form.pagename, 4)>
			<!---Change it if there is an extension--->
			<cfif InvalExtension CONTAINS ".">
				<cfset stringlength = len(thepagename)>
				<cfset stringtocut = stringlength - 4>
				<cfset ThisFileName = left(thepagename, stringtocut)>
				<cfset ThePageName = '#ThisFileName#.cfm'>
			</cfif>
			<!---If there is not one just add one--->
			<cfif NOT InvalExtension CONTAINS ".">
				<cfset ThePageName = '#ThePageName#.cfm'>	
			</cfif>
	</cfif>

	<cfset NewFileName = replace(ThePageName, "'", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, '"', '', 'ALL')>
	<cfset NewFileName = replace(NewFileName, "*", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "&", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "(", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ")", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ";", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ":", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "!", "", "ALL")>

	<cfset fullpath = "#request.catalogpath##form.Dir##request.bslash##NewFileName#">
	<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cffile action = "write" file = "#fullpath#" output = "&nbsp;">

The page was created.  Click on it to edit its contents.<br />

</cfif>



















