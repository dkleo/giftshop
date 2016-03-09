<cfparam name = "request.baseurl" default="#request.HomeURL#photos/tiny/">
<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="40">

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

<cfset Dir = replacenocase(Dir, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullpath = "#request.CatalogPath#photos#request.bslash#tiny#dir#">
<cfset fullpath = replacenocase(FullPath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cfset fullpath2 = "#request.CatalogPath#photos#request.bslash#large#dir#">
<cfset fullpath2 = replacenocase(FullPath2, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>


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

<cfdirectory  action = "List"   
	directory = "#fullpath2#"   
	name = "qryFiles2"
	sort = "name ASC">
	
<cfquery name="WithoutDotParents2" dbtype="Query">
	SELECT  	*
	FROM    	qryFiles2
	WHERE   	Name <> '.'
	AND			Name <> '..'
	ORDER BY 	Type
</cfquery>

<cfif qryFiles2.recordcount GT qryFiles.recordcount>

	<cfoutput><center><b>Attention!</b>  You have images that do not have thumbnails generated, so they are not showing up here. <a href = "dophotomanager.cfm?action=makethumbs&ffield=#ffield#&fname=#fname#&dir=#dir#">Click here to generate thumbnails for those images</a>.</center></cfoutput>
    <p>&nbsp;</p>
</cfif>
<cfquery name = "qryDirectories" dbtype="query">
SELECT * FROM WithoutDotParents WHERE type = 'Dir'
ORDER BY Name ASC
</cfquery>

<cfquery name = "qryFileNames" dbtype="query">
SELECT * FROM WithoutDotParents WHERE type = 'File'
ORDER BY Name ASC
</cfquery>	

<CFSET end=Start + disp>

<CFIF Start + disp GREATER THAN qryFileNames.RecordCount>
	<CFSET end=999>
<CFELSE>
	<CFSET end=Start + disp - 1>
</CFIF>


<h2>Select an Image</h2>
<table width="100%" border="0" cellpadding="4" cellspacing="0">

<tr>
		<td width="15%">
    
             <form name = "PageSelect" method="Post" Action="dophotomanager.cfm?action=browse">
              <select name="start" OnChange="this.form.submit();">
                <cfset PageCount = 1>
                <cfloop Index="Pages" FROM="1" TO="#qryFileNames.RecordCount#" Step="#disp#">
                  <cfoutput>
                  <option value = "#Pages#" <cfif Pages IS Start>SELECTED</cfif>>Page 
                  #PageCount#</option></a>
                  <cfset PageCount = PageCount + 1>
                  </cfoutput>
                </cfloop>
              </select>
             </form>   
    </td>
	<td width="15%"><form name="Displayoptions" method="POST" Action="dophotomanager.cfm?action=browse">
		<select name = "disp" onchange="this.form.submit();">
			<option value="12" <cfif disp IS '12'>SELECTED</cfif>>Display 12</option>
			<option value="24" <cfif disp IS '24'>SELECTED</cfif>>Display 24</option>
			<option value="40" <cfif disp IS '40'>SELECTED</cfif>>Display 40</option>
			<option value="80" <cfif disp IS '80'>SELECTED</cfif>>Display 80</option>
		</select>
	</form>
    </td>
    <td colspan="3">&nbsp;
    
    </td>
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
<cfloop query = "qryFileNames" startrow="#start#" endrow="#end#">
<cfoutput>
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
		<td height="110" width="25%" valign="middle" align="center" style="border: ##000000 1px solid;">
        <table width="100%" cellpadding="4" cellspacing="0" align="center">
        <tr>
        <td height="100" valign="middle" align="center">

		<cfset choiceURL = "#name#">
                
        <a href = "##" onclick="getImage('#ChoiceURL#', '#fname#', '#ffield#');">
        <div align="center" style="height: 90px; overflow: hidden; width: 175px">
        <img src = "#request.BaseURL##dir##name#" border="0">
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
</cfloop>
</table>































