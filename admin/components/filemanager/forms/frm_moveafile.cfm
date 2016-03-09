<cfparam name = "Dir" default="#request.bslash#">
<cfset fullpath = "#request.catalogpath##Dir#">
<cfset fullpath = replacenocase(FullPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
<cfset Dir = replacenocase(Dir, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfdirectory  action = "List"   
	directory = "#fullpath#"   
	name = "qryFiles">
	
<cfquery name="WithoutDotParents" dbtype="Query">
	SELECT  	*
	FROM    	qryFiles
	WHERE   	Name <> '.'
	AND			Name <> '..'
	ORDER BY 	Type
</cfquery>

<cfquery name = "qryDirectories" dbtype="query">
SELECT * FROM WithoutDotParents WHERE type = 'Dir'
ORDER BY Name ASC
</cfquery>

<h2>Choose folder to move it to</h2>
<p>
<cfoutput>
<cfif NOT dir IS '#request.bslash#'><a href = "index.cfm?action=files.MoveFileHere&filetoMove=#url.filetoMove#&dir=#dir#">Move File here</a></cfif>
</cfoutput>
<p>

<table width="100%" border="0" cellpadding="4" cellspacing="0">
<tr>
  <td colspan="4"><cfoutput>#dir#</cfoutput></td>
  </tr>
<tr>
	<td width="200" bgcolor="#000066"><span class="style4">Folder Name</span></td>
	<td bgcolor="#000066"><span class="style4"></span></td>
	<td bgcolor="#000066"><span class="style4"></span></td>
	<td bgcolor="#000066"><span class="style4"></span></td>
</tr>
<cfif NOT Dir IS '#request.bslash#'>
<!---figure out which directory is up one from this one--->
	<cfset PathLength = listlen(dir, "#request.bslash#")>
	<cfset UpDirName = ListDeleteAt(dir, PathLength, '#request.bslash#')>
	<cfif UpDirName IS ''><cfset UpDirName = '#request.bslash#'></cfif>
  <tr>
    <td colspan="3"><cfoutput><img src="images/folder_up.png"> <a href = "index.cfm?action=files.MoveAFile&Dir=#UpDirName#&filetoMove=#url.filetoMove#">[Parent Foler]</a></cfoutput></td>
	<td></td>
  </tr>
</cfif>
<!---if at root level display only folders they are allowed to access--->
<cfif Dir IS '#request.bslash#'>
	<cfset ImageName = 'folder.gif'>
    <cfloop from = "1" to = "#listlen(request.folder_accesslist)#" index="f">
    
    	<cfset folder_name = listgetat(request.folder_accesslist, f)>
    	<cfoutput>
        <tr>
            <td colspan="4"><img src="images/#ImageName#"> <a href = "index.cfm?action=files.MoveAFile&Dir=#Dir##folder_name##request.bslash#&filetoMove=#url.filetoMove#">
            #folder_name#</a>
            </td>
            <td></td>
        </tr>
        </cfoutput>
    </cfloop>
</cfif>
<!---If it's not the main folder then display the list of folders in this directory--->
<cfif NOT Dir IS '#request.bslash#'>
<cfoutput Query = "qryDirectories">
  <cfset ImageName = 'folder.gif'>
  <tr>
    <td colspan="3"><img src="images/#ImageName#"> <a href = "index.cfm?action=files.MoveAFile&Dir=#Dir##request.bslash##Name##request.bslash#&filetoMove=#url.filetoMove#">#Name#</a></td>
	<td>
	</td>
  </tr>
</cfoutput>
</cfif>
</table>



















