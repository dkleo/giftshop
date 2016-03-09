<cfoutput>
<a href = "index.cfm?action=filemanager.files.browse&dir=#url.dir#">[X] CLOSE</a>
</cfoutput>
<p>
<cfset actualfolder = replace(url.dir, "#request.bslash#", "/", "ALL")>
<cfoutput>
	<img src = "#request.homeURL#/#actualfolder##url.filename#" />
</cfoutput>





















