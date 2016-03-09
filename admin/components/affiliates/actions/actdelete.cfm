<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfquery name = "qryDeleteMember" datasource="#request.dsn#">
DELETE FROM afl_affiliates WHERE id = #url.id#
</cfquery>

<!---delete their directory and page--->
<cfif fileexists('#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#.cfm')>
    <cffile action="delete" file="#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#.cfm">
</cfif>

<cfif fileexists('#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#f.cfm')>
    <cffile action="delete" file="#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#b.cfm">
</cfif>

<cfif fileexists('#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#b.cfm')>
    <cffile action="delete" file="#request.catalogpath#docs#request.bslash#affiliates#request.bslash##affiliateid#f.cfm">
</cfif>

<cfif directoryexists('#request.catalogpath##affiliateid#')>
    <cffile action="delete" file="#request.catalogpath##affiliateid#\index.cfm">
    <cfdirectory action="delete" directory="#request.catalogpath##affiliateid#">
</cfif>

<cfif directoryexists('#request.catalogpath##affiliateid#b')>
    <cffile action="delete" file="#request.catalogpath##affiliateid#b\index.cfm">
    <cfdirectory action="delete" directory="#request.catalogpath##affiliateid#b">
</cfif>

<cfif directoryexists('#request.catalogpath##affiliateid#f')>
    <cffile action="delete" file="#request.catalogpath##affiliateid#f\index.cfm">
    <cfdirectory action="delete" directory="#request.catalogpath##affiliateid#f">
</cfif>

<cflocation url = "index.cfm">












