<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">

<script language = "javascript" type="text/javascript">
function getImage( fileUrl, fname, ffield )
{
	window.top.opener.SetUrl( fileUrl, fname, ffield ) ;
	window.top.close() ;
	window.top.opener.focus() ;
}
</SCRIPT>

<cfset Dir = "#request.bslash#">

<!---get the available themes--->
<cfdirectory action="list" directory="#request.catalogpath#themes#request.bslash#" name="themefiles">
	
<cfquery name="WithoutDotParents" dbtype="Query">
	SELECT  	*
	FROM    	themefiles
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
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
<h3>Choose a Theme Below:</h3>
<table width="500" border="0" cellpadding="4" cellspacing="0">
<tr>
	<td colspan="5" bgcolor="#000066"><span class="style1">Warning: Some themes will overwrite your homepage, header, and footer! A backup of each will be made.</span></td>
</tr>  
<cfset ImageName = 'folder.gif'>
<cfset dcount = 0>
<cfset colcount = 0>
<tr>

<!---Show the images--->
<cfoutput query = "qryDirectories">
<cfif NOT name IS 'A_Custom_Theme'>
	<cfset colcount = colcount + 1>
    
    <cfif fileexists('#request.catalogpath#themes#request.bslash##name##request.bslash#thumb#request.bslash##name#.gif')>
        <cfset thumbfile = '#request.HomeURL#themes/#name#/thumb/#name#.gif'>
    <cfelse>
        <cfset thumbfile = '#request.HomeURL#admin/images/nothumbnail.gif'>
    </cfif>
    
    <!---Display the list of themes--->
        <cfset dCount = dCount + 1>
            <td height="150" width="250" valign="middle" align="center" style="border: ##000000 1px solid;">
            <table width="100%" cellpadding="4" cellspacing="0" align="center">
            <tr>
            <td height="115" valign="middle">
    
            <cfset choiceURL = "images/#name#">
                    
            <a href = "dosetup.cfm?action=selecttheme&themename=#name#">
            <div align="center" style="height: 214px; overflow: hidden; width: 272px">
            <center><img src = "#thumbfile#" border="0" align="middle"></center>
            </div><br />
            <center>#name#</center>
            </a>      
            </td>
            </tr>
            </table>
            </td>
        <cfif colcount IS 2>
        </tr><tr><cfset colcount = 0>
        </cfif>
</cfif>
</cfoutput>
</tr>
</table>







