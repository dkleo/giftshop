<!---Write custom.css file to the server--->
<cfset fullpath = "#request.catalogpath#global.css">
<cffile action = "read" file="#fullpath#" variable="FileContents">

<!---Find the tag that they want to edit and select only this style block if editing--->
<cfif form.editing IS 'yes'>
	<cfset startpos = findnocase(".#form.editstyle#", FileContents, 1)>
	<cfset endpos = findnocase("}", FileContents, startpos)>
	<cfset charcount = endpos - startpos>
	<cfset charcount = charcount + 1>
	<cfset styleblock = mid(FileContents, startpos, charcount)>
	<!---delete the old one from the file--->
	<cfset NewFileContent = replacenocase(FileContents, styleblock, "", "ALL")>
<cfelse>
	<cfset NewFileContent = #FileContent#>	
</cfif>

<!---create the new styleblock from what they entered in the form--->
<cfsavecontent variable="newcustomstyle"><cfoutput>
.#form.editstyle# {
	<cfif NOT form.fontfamily IS 'None'>font-family: #form.fontfamily#;
	</cfif>
	<cfif NOT form.fontsize IS 'None'>font-size: #form.fontsize#px;
	</cfif>
	<cfif NOT form.lineheight IS ''>line-height: #form.lineheight#px;
	</cfif>
	<cfif NOT form.fontweight IS 'None'>font-weight: #form.fontweight#;
	</cfif>
	<cfif NOT form.color IS ''>color: #form.color#;
	</cfif>
	<cfif NOT form.textdecoration IS 'None'>text-decoration: #textdecoration#;
	</cfif>
	<cfif NOT form.backgroundcolor IS ''>background-color: #form.backgroundcolor#;
	</cfif>
	<cfif ISDEFINED('useimage')>background-image: #form.backgroundimage#;
	</cfif><cfif NOT form.backgroundrepeat IS ''>background-repeat: #form.backgroundrepeat#;
	</cfif>
	<cfif NOT form.backgroundpositionH IS 'None' AND NOT form.backgroundpositionV IS 'None'>background-position: #form.backgroundpositionH# #form.backgroundpositionV#;
	</cfif>
	<cfif NOT form.textalign IS 'None'>text-align: #form.textalign#;
	</cfif>
	<cfif NOT form.verticalalign IS 'None'>vertical-align: #form.verticalalign#;
	</cfif>
	<cfif NOT form.bordersize IS ''>border: #form.bordersize#px #form.borderstyle# #form.bordercolor#
	</cfif>
	<cfif NOT form.width IS ''>width: #form.width#px;
	</cfif>
	<cfif NOT form.height IS ''>height: #form.height#px;
	</cfif>
	<cfif NOT form.paddingtop IS ''>padding-top: #form.paddingtop#px;
	</cfif>
	<cfif NOT form.paddingbottom IS ''>padding-bottom: #form.paddingbottom#px;
	</cfif>
	<cfif NOT form.paddingright IS ''>padding-right: #form.paddingright#px;
	</cfif>
	<cfif NOT form.paddingleft IS ''>padding-left: #form.paddingleft#px;
	</cfif>
}
</cfoutput>
</cfsavecontent>

<cfset NewFileContent = "#NewFileContent##newcustomstyle#">

<cffile action = "write" file="#request.catalogpath#stylesheets#request.bslash#custom.css" output="#NewFileContent#">

<cflocation url = "index.cfm?stylesaved=yes">