<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>


<cfif isdefined('form.PageName')>
	<!---Remove illegal characters--->
	<cfset NewFileName = replace(form.PageName, "'", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, '"', '', 'ALL')>
	<cfset NewFileName = replace(NewFileName, "*", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "&", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "(", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ")", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ";", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, ":", "", "ALL")>
	<cfset NewFileName = replace(NewFileName, "!", "", "ALL")>

	<!---Now check to see if the extension is acceptable--->
	<cfset thepagename = '#NewFileName#'>
	<cfif NOT right(thepagename, 4) IS '.cfm' AND NOT right(thepagename, 4) IS '.txt' AND NOT right(thepagename, 4) IS '.gif' AND NOT right(thepagename, 4) IS '.jpg' AND NOT right(thepagename, 4) IS '.pdf' AND NOT right(thepagename, 4) IS '.doc' AND NOT right(thepagename, 4) IS '.swf' AND NOT right(thepagename, 4) IS '.mov' AND NOT right(thepagename, 4) IS '.htm' AND NOT right(thepagename, 4) IS 'html' AND NOT right(thepagename, 4) IS '.csv' AND NOT right(thepagename, 4) IS '.zip' AND NOT right(thepagename, 4) IS '.rar'>
		<!---It's not acceptable so just display a javascript error and redirect back--->
		<cfoutput>
		<script language="javascript">
			alert('You did not specify a valid file extension. The file was NOT renamed.');
			location.replace('index.cfm?action=filemanager.files.browse&dir=#URLEncodedFormat(form.dir)#');
		</script>
		</cfoutput>
		<cfabort>
	</cfif>

	<cfset fullDespath = "#request.catalogpath##form.Dir##request.bslash##form.pagename#">
	<cfset fullDespath = replacenocase(FullDesPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
	
	<cfset fullFrompath = "#request.catalogpath##form.dir##request.bslash##form.name#">
	<cfset fullFrompath = replacenocase(FullFromPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

	<cffile action = "rename"   
		source = "#fullfrompath#"   
		destination = "#fulldespath#"    
	>
	
    <cfquery name = "qryUpdateMemberPages" datasource="#request.dsn#">
    UPDATE member_pages
    SET name = '#form.pagename#'
    WHERE name = '#form.name#'
    </cfquery>
    
</cfif>



















