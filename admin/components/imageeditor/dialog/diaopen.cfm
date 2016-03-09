<!---delete temp image if there is one--->
<cfif isdefined('cookie.imagefile')>
	<cfif fileexists('#request.catalogpath#temp#request.bslash##cookie.imagefile#')>
    	<cffile action="delete" file="#request.catalogpath#temp#request.bslash##cookie.imagefile#">
    </cfif>
</cfif>

<cfparam name = "request.baseurl" default="#request.HomeURL#">
<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">

<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">

<script language = "javascript" type="text/javascript">
function getImage( fileUrl, fname, ffield )
{
	window.top.opener.SetUrl( fileUrl ) ;
	window.top.close() ;
	window.top.opener.focus() ;
}
</SCRIPT>

<cfset fullpath = "#request.CatalogPath#images#request.bslash##dir#">
<cfset fullpath = replacenocase(FullPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
<cfset Dir = replacenocase(Dir, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfdirectory  action = "List"   
	directory = "#fullpath#"   
	name = "qryFiles"
	sort = "name ASC">
	
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

<cfquery name = "qryFileNames" dbtype="query">
SELECT * FROM WithoutDotParents WHERE type = 'File'
ORDER BY Name ASC
</cfquery>	

<h2>Open an Image:</h2>
<table width="100%" border="0" cellpadding="4" cellspacing="0">

<tr>
  <td colspan="4">
</tr>
<tr>
	<td colspan="5" bgcolor="#000066">&nbsp;</td>
</tr>
    
<cfif NOT Dir IS '#request.bslash#'>
<!---figure out which directory is up one from this one--->
	<cfset PathLength = listlen(dir, "#request.bslash#")>
	<cfset UpDirName = ListDeleteAt(dir, PathLength, '#request.bslash#')>
	<cfif UpDirName IS ''><cfset UpDirName = '#request.bslash#'></cfif>
</cfif>
<!---If it's not the main folder then display the list of folders in this directory--->
<cfoutput Query = "qryDirectories">
  <cfset ImageName = 'folder.gif'>
</cfoutput>
<cfset dcount = 0>
<cfset colcount = 0>
<tr>

<!---Show the images--->
<cfoutput query = "qryFileNames">
<!---Figure out what action to use on this file from it's file type--->
<cfset theaction='browse'>
<cfset theicon='document_filetype.gif'>
<cfset thetype='none'>

<cfif Right(name, 4) IS '.gif' OR right(name, 4) IS '.jpg' OR right(name, 4) IS '.png' or right(name,4) IS 'jpeg'>
	<cfset theaction='viewimage'>
	<cfset theicon='image_filetype.gif'>
	<cfset thetype='Image'>
</cfif>

<!---Display the list of files--->
	<cfif thetype IS 'Image'>
    <cfset dCount = dCount + 1>
    <cfset colcount = colcount + 1>
		<td height="150" width="25%" valign="middle" align="center" style="border: ##000000 1px solid;">
        <table width="100%" cellpadding="4" cellspacing="0" align="center">
        <tr>
        <td height="115" valign="middle" align="center">

		<cfset choiceURL = "#name#">
                
        <a href = "##" onclick="getImage('#ChoiceURL#');">
        <div align="center" style="height: 150px; overflow: hidden; width: 175px">
		<cfif fileexists('#request.catalogpath#images#request.bslash#thumbs#request.bslash##name#')>
        <img src = "#request.BaseURL#images/thumbs/#name#" border="0">
        <cfelse>
        <img src = "#request.BaseURL#images/#dir##name#" border="0">
        </cfif>
        </div><br />
        <center>#name#</center>
        </a>       
        </td>
        </tr>
        </table>
        </td>
	<cfif colcount IS 4>
    </tr><tr><cfset colcount = 0>
    </cfif>
	</cfif>
</cfoutput>
</table>

















