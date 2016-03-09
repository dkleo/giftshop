<!---for ckeditor when browsing for images for emails, the full home url is used instead of the absolute path--->
<div style = "width: 100%; height: 100%; overflow: auto;">
<link href="../../../../../controlpanel.css" rel="stylesheet" type="text/css" />
<cfparam name = "request.baseurl" default="#request.SecureURL#images/">
<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">
<cfparam name = "parentdir" default="#request.bslash#">
<cfparam name = "CKEditorFuncNum" default="1">

<cfset request.homeurl = replace(request.homeurl, "/", "//")>

<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">


<script language = "javascript" type="text/javascript">

function getImage( funcNum, fileUrl )
{
	window.opener.CKEDITOR.tools.callFunction( funcNum, fileUrl )
	window.top.close() ;
	window.top.opener.focus() ;
}
</SCRIPT>

<cfset fullpath = "#request.CatalogPath#images#request.bslash##dir#">
<cfset fullpath = replacenocase(FullPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
<cfset Dir = replacenocase(Dir, "\\", "\", "ALL")>

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

<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
}
.HighlightRow {background-color:#FFFF99; cursor:pointer;}
.NoHighlight {background-color:; cursor:pointer;}
.style5 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<!---get the parent directories parent--->
<cfif listlen(parentdir, "\") GT 1>
	<cfset parentlocation = listlen(parentdir, "\")>
    <cfset lastparent = listdeleteat(parentdir, parentlocation, "\")>
<cfelse>
	<cfset lastparent = "\">
</cfif>

<span class="style1">Website Images: <cfif NOT dir IS "\"><cfoutput>[<a href = "browse.cfm?action=library&dir=#parentdir#&parentdir=#lastparent#&fname=#fname#&ffield=#ffield#">Parent Directory</a>]</cfoutput></cfif></span>
<table width="100%" border="0" cellpadding="4" cellspacing="0">
      
<cfif NOT Dir IS '\'>
<!---figure out which directory is up one from this one--->
	<cfset PathLength = listlen(dir, "\")>
	<cfset UpDirName = ListDeleteAt(dir, PathLength, '\')>
	<cfif UpDirName IS ''><cfset UpDirName = '\'></cfif>
</cfif>
<!---If it's not the main folder then display the list of folders in this directory--->
<cfoutput Query = "qryDirectories">
  <cfset ImageName = 'folder.gif'>
</cfoutput>
<cfset dcount = 0>
<cfset colcount = 0>
<tr>
<!--- This will be included in the next release.  A full filemanager is on the way!
<!---First show any folders that have been created--->
<cfoutput query = "qryDirectories">
<cfset colcount = colcount + 1>
<td height="150" width="200" valign="middle" align="center" style="border: ##000000 1px solid;">
	<a href = "browse.cfm?action=library&dir=#dir##name#\&parentdir=#dir#&fname=#fname#&ffield=#ffield#"><img src="folder.gif" border="0" /><br />#name#</a>
<cfif colcount GT 2>
</tr><tr><cfset colcount = 0>
</cfif>
</cfoutput>
--->

<!---Now show the images--->
<cfoutput query = "qryFileNames">
<cfset colcount = colcount + 1>
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
	<cfset dCount = dCount + 1>
	<cfif thetype IS 'Image'>
		<td height="150" width="200" valign="middle" align="center" style="border: ##000000 1px solid;">
        <table width="100%" cellpadding="4" cellspacing="0" align="center">
        <tr>
        <td height="115">
        <cfset pathto = replace(dir, "\", "/", "ALL")>
		<cfset choiceURL = "#request.homeurl#images/#pathto##name#">
        <cfset choiceURL = replace(choiceURL, "//", "/", "ALL")>
        <a href = "##" onclick="getImage(#CKEditorFuncNum#, '#ChoiceURL#');">
		<div align="center" style="height: 150px; overflow: hidden; width: 300px">
		<cfif fileexists('#request.catalogpath#images\thumbs\#name#')>
        <center><img src = "#request.BaseURL#thumbs\#name#" border="0"></center><br />
        <cfelse>
        <center><img src = "#request.BaseURL##dir##name#" border="0"></center><br />
        </cfif>
        </div>
        <center>#name#</center>
        </a></td>
        </tr>
        </table>
        </td>
	<cfif colcount GT 2>
    </tr><tr><cfset colcount = 0>
    </cfif>
	</cfif>
</cfoutput>
</table>
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">

<cfoutput>#url.ckeditorfuncnum#</cfoutput>
<div>

