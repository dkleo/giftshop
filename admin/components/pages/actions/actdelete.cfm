<!---Delete the product after confirmation--->
<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<cfif NOT directoryexists('#request.catalogpath##request.bslash#docs_deleted')>
	<cfdirectory action="create" directory="#request.catalogpath##request.bslash#docs_deleted">
</cfif>

<cfif NOT isdefined ('url.Confirm')>
  <p align = "center">Confirm Delete</p>
  <p align = "center"><cfoutput>You are deleting #url.id#</cfoutput>
  <br />
	<p align="center"><strong>Are you sure you want to delete this page?</strong><br>
    <cfoutput><a href="dopages.cfm?action=DeletePage&DeleteID=#url.ID#&Confirm=Yes<cfif ISDEFINED('url.WasSearch')>&WasSearch=Yes</cfif>">Yes</a></cfoutput> 
    | <a href="dopages.cfm<cfif ISDEFINED('url.WasSearch')>?action=search</cfif>">No</a>
    <cfabort>
</cfif>

<cfif isdefined('url.Confirm')>
	<cffile action="move" source="#request.catalogpath#docs#request.bslash##url.deleteid#" destination="#request.catalogpath#docs_deleted#request.bslash##url.deleteid#">

	<cflocation url="dopages.cfm">
</cfif>















