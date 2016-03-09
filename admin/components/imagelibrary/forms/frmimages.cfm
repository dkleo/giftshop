<cfparam name = "fname" default="myform">
<cfparam name = "ffield" default="myformfield">
<cfparam name = "Dir" default="#request.bslash#">
<cfparam name = "start" default="1">
<cfparam name = "disp" default="40">
<cfparam name = "searchtxt" default="">

<!---check to see if cfimageeffects is installed to see what image editor should be used--->
<cfif fileexists('#request.catalogpath#admin#request.bslash#components#request.bslash#imageeditor#request.bslash#actions#request.bslash#cfimageeffects.cfc')>
	<cfset usepe = 'Yes'>
<cfelse>
	<cfset usepe = 'No'>
</cfif>

<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">

<script language = "javascript" type="text/javascript">

function OpenImageEditor( url )
{
	var winwidth = ( screen.width * .8);
	var winheight = ( screen.height * .8);
	var iLeft = ( screen.width  - winwidth ) / 2 ;
	var iTop  = ( screen.height - winheight ) / 2 ;

	var sOptions = "toolbar=no,status=yes,resizable=no,dependent=yes,scrollbars=1" ;
	sOptions += ",width=" + winwidth ;
	sOptions += ",height=" + winheight ;
	sOptions += ",left=" + iLeft ;
	sOptions += ",top=" + iTop ;

	window.open( url, 'FileBrowserWindow', sOptions ) ;
}

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
ORDER BY Name ASC
</cfquery>	

<cfquery name = "qryFileNames" dbtype="query">
SELECT * FROM qryFileNames WHERE name LIKE '%#searchtxt#%'
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
<div align="left" style="background: ##FFFFCC; padding: 5px;"><!---Upload Image---><form method="post" enctype="multipart/form-data" name="form1" id="form1" action="doimagelibrary.cfm?action=upload&dir=#dir#">
	        <b>Upload</b> Image: <input name="ImageFile" type="file" size="30" />
            <cfif request.ImageProcessor IS 'None'>
             Thumb: <input name="ThumbFile" type="file" size="30" /> 
            </cfif>
            <input type="submit" name="Submit" value="Upload" />
			<input type="hidden" name="dir" value="#dir#">
            <input type="hidden" size="20" value="#searchtxt#" name="searchtxt" />
            <input type="hidden" size="20" value="#start#" name="start" />
            <input type="hidden" size="20" value="#disp#" name="disp" /> <br />Note: To upload multiple images at once, use the file manager.
	  </form>
 </cfoutput></div></td>
   </tr>
  </table>
</tr>
<tr>
	<td colspan="5">
    	<table width="100%" cellpadding="4" cellspacing="0">
        	<tr>
            	<td width="15%">
               		<form name = "PageSelect" method="Post" Action="doimagelibrary.cfm">
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
                        <cfoutput><input type="hidden" size="20" value="#searchtxt#" name="searchtxt" /></cfoutput>
                     </form>         
				</td>
				<td width="15%">                
                   <form name="Displayoptions" method="POST" Action="doimagelibrary.cfm">
                    <select name = "disp" onchange="this.form.submit();">
                        <option value="12" <cfif disp IS '12'>SELECTED</cfif>>Display 12</option>
                        <option value="24" <cfif disp IS '24'>SELECTED</cfif>>Display 24</option>
                        <option value="40" <cfif disp IS '40'>SELECTED</cfif>>Display 40</option>
                        <option value="80" <cfif disp IS '80'>SELECTED</cfif>>Display 80</option>
                    </select>
                    <cfoutput><input type="hidden" size="20" value="#searchtxt#" name="searchtxt" /></cfoutput>
                         </form>
				 </td>             
                 <td>
                 <form method="POST" action="doimagelibrary.cfm" name="searchform">
    Search: <cfoutput><input type="text" size="20" value="#searchtxt#" name="searchtxt" />
	<input type="hidden" name="disp" value="#disp#" />
	<input type="hidden" name="start" value="1" /></cfoutput>
    <input type="submit" name="submitbtn" value="Apply" id="submitbtn" />
    </form>  
    </td>
    </tr>
    </table>
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
	    <cfset colcount = colcount + 1>
		<cfset dCount = dCount + 1>
		<td height="150" width="25%" valign="middle" align="center" style="border: ##CCCCCC groove 1px;">
        <table width="100%" cellpadding="4" cellspacing="0" align="center">
        <tr>
        <td height="115" align="center">
        
        <cfif usepe IS 'Yes'>
        	<cfset onclickevent = "javascript: OpenImageEditor('#request.adminpath#components/imageeditor/index.cfm?dir=#dir#&imagefile=#name#')">
        <cfelse>
        	<cfset onclickevent = "location.replace('doimagelibrary.cfm?action=viewimage&dir=#dir#&name=#name#&disp=#disp#&start=#start#&searchtxt=#searchtxt#');">
        </cfif>
		
		<cfif fileexists('#request.catalogpath#images#request.bslash#thumbs#request.bslash##name#')>
        	<cfset imgsrc = "#request.HomeURL#images/thumbs/#name#">
        <cfelse>
        	<cfset imgsrc = "#request.HomeURL#images/#name#">
        </cfif>        
        <div align="center" style="height: 150px; overflow: hidden; width: 175px; cursor: pointer;">
        <center><img src = "#imgsrc#" border="0" alt="#name# - click to edit" title="#name# - click to edit" onclick="#onclickevent#"></center><br />
        </div>
        <center>
       	<span onclick="#onclickevent#" style="cursor:pointer;">#name#</span></center>
        </a>
        <form action = "doimagelibrary.cfm?imgsrc=#dir##name#&imgfile=#name#&dir=#dir#" method="post">
          <div align="center">
          <p>&nbsp;</p>
            <input name="action" type = "submit" value="DELETE" style="cursor: pointer;" />
            <input type = "hidden" name="imagename" value="#fullpath#" />
            </div>
        </form>        
        </td>
        </tr>
        </table>        </td>
	<cfif colcount GT 3>
    </tr><tr><cfset colcount = 0>
    </cfif>
	</cfif>
</cfoutput>
</cfloop>
</table>