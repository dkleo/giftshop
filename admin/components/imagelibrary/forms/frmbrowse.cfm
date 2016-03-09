<cfparam name = "request.baseurl" default="#request.HomeURL#">
<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="40">
<cfparam name = "stxt" default="">

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
AND name LIKE '%#stxt#%'
ORDER BY Name ASC
</cfquery>	

<CFSET end=Start + disp>

<CFIF Start + disp GREATER THAN qryFileNames.RecordCount>
	<CFSET end=999>
<CFELSE>
	<CFSET end=Start + disp - 1>
</CFIF>

<h2>Website Images:</h2>
<table width="100%" border="0" cellpadding="4" cellspacing="0">

<tr>
  <td colspan="4"><table width="100%" cellpadding="4" cellspacing="0">
  <tr>
  <td width="25%"><div align="left"><!---NewFolder--->
  <cfoutput>
<div align="left" style="background: ##FFFFCC; padding: 5px;"><!---Upload Image---><form method="post" enctype="multipart/form-data" name="form1" id="form1" action="doimagelibrary.cfm?action=upload&dir=#dir#&wasdoing=browsing&fname=#fname#&ffield=#ffield#">
	        <b>Upload</b> Image: <input name="ImageFile" type="file" size="30" />
            <cfif request.ImageProcessor IS 'None'>
             Thumb: <input name="ThumbFile" type="file" size="30" />
            </cfif>
            <input type="submit" name="Submit" value="Upload" />
            <input type="hidden" name="disp" value="#disp#" />
            <input type="hidden" name="start" value="1" />
			<input type="hidden" name="dir" value="#dir#">
	  </form>
 </cfoutput></div></td>
   </tr>
   </table>
</tr>
<tr>
    <td width="15%">
    
     <form name = "PageSelect" method="Post" Action="doimagelibrary.cfm?action=browse">
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
            
      <cfoutput><input type="hidden" name="disp" value="#disp#" />
      <input type="hidden" name="stxt" value="#stxt#" /></cfoutput>
     </form>   
    </td>
    <td width="15%"><form name="Displayoptions" method="POST" Action="doimagelibrary.cfm?action=browse">
        <select name = "disp" onchange="this.form.submit();">
        <option value="12" <cfif disp IS '12'>SELECTED</cfif>>Display 12</option>
        <option value="24" <cfif disp IS '24'>SELECTED</cfif>>Display 24</option>
        <option value="40" <cfif disp IS '40'>SELECTED</cfif>>Display 40</option>
        <option value="80" <cfif disp IS '80'>SELECTED</cfif>>Display 80</option>
        </select>
        <cfoutput><input type="hidden" name="stxt" value="#stxt#" /></cfoutput>
    </form>
    </td>
    <td colspan="3">
    
      <div align="right">
        <form id="form2" name="form2" method="post" action="">
         <cfoutput>Search: <input type="text" name="stxt" id="stxt" value="#stxt#" />
         <input type="hidden" name="disp" value="#disp#" />
         <input type="hidden" name="start" value="1" />
         </cfoutput>
         <input type = "submit" value="Apply" name="submitbtn" id="submitbtn" />
        </form>
    </div></td>
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
		<td height="150" width="25%" valign="middle" align="center" style="border: ##000000 1px solid;">
        <table width="100%" cellpadding="4" cellspacing="0" align="center">
        <tr>
        <td height="115" valign="middle" align="center">

		<cfset choiceURL = "images/#name#">
                
        <a href = "##" onclick="getImage('#ChoiceURL#', '#fname#', '#ffield#');">
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
</cfloop>
</table>



















