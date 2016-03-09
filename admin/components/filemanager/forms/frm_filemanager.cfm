<cfset request.catalogpath = request.catalogpath>
<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
}
.style4 {color: #FFFFFF; font-weight: bold; }
.HighlightRow {background-color:#FFFF99; }
.NoHighlight {background-color:; }
-->
</style>

<script LANGUAGE="JavaScript">
	function ConfirmDelete(dir,FileName)
	{
	var agree=confirm("Are you sure you want to delete this file?");
	if (agree)
		location.replace('index.cfm?action=files.DeleteFile&FileName='+FileName+'&dir='+dir); 
	else
		return false ;
	}
</script>

<script LANGUAGE="JavaScript">
	function ConfirmDeleteFolder(dir,FolderName)
	{
	var agree=confirm("Are you sure you want to delete this folder and everything in it!?  If you delete one of the default folders, your website might stop working correctly!");
	if (agree)
		location.replace('index.cfm?action=files.DeleteFolder&FolderName='+FolderName+'&dir='+dir); 
	else
		return false ;
	}
</script>


<script language = "javascript" type="text/javascript">
		function HideNewFolderForm() {
				NewFolder.style.display = "None";
				NewPage.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function HideNewFolderForm() {
				NewFolder.style.display = "None";
				NewPage.style.display = "None";
				UploadFile.style.display = "None";
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowNewFolderForm() {
			NewPage.style.display = "None";
			UploadFile.style.display = "None";
			NewFolder.style.display = "block";
			document.NewFolderForm.FolderName.focus();
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowRenameForm(FName) {
			RenameSpanName = 'rename_' + FName;
			NoRenameSpanName = 'norename_' + FName;
			RenameFormName = 'renameform_' + FName;

			Rename_Span = document.getElementById(RenameSpanName);
			NoRename_Span = document.getElementById(NoRenameSpanName);
					
			Rename_Span.style.display = "block";
			NoRename_Span.style.display = "None";
			document.forms[RenameFormName].PageName.focus();
			document.forms[RenameFormName].PageName.select();
		}
</script>

<script language = "javascript" type="text/javascript">
		function HideRenameForm(FName) {
			RenameSpanName = 'rename_' + FName;
			NoRenameSpanName = 'norename_' + FName;
			RenameFormName = 'renameform_' + FName;
				
			Rename_Span = document.getElementById(RenameSpanName);
			NoRename_Span = document.getElementById(NoRenameSpanName);
					
			Rename_Span.style.display = "None";
			NoRename_Span.style.display = "Block";
		}
</script>


<script language = "javascript" type="text/javascript">
		function ShowNewPageForm() {
			NewFolder.style.display = "None";
			UploadFile.style.display = "None";
			NewPage.style.display = "block";
			document.NewPageForm.PageName.focus();
		}
</script>

<script language = "javascript" type="text/javascript">
		function ShowUploadForm() {
			NewFolder.style.display = "None";
			NewPage.style.display = "None";
			UploadFile.style.display = "block";
			document.UploadForm.filefield.focus();
		}
</script>

<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "image-window.html?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script>

<script language="Javascript"> 
   function LoadStatusWin() { 
     UploadFile.style.display = "None";
	 UploadFileStatus.style.display = "Block";
   } 
   </script>   
  
<cfparam name = "Dir" default="#request.bslash#">
<cfparam name = "Start" default = "1">
<cfparam name = "Disp" default = "50">
<cfparam name = "end" default="999">

<!---if the dir passed does not match any of the allowed directories as set in the datasource.cfm file, then return to the root folder--->
<cfif Dir IS '#request.bslash#'>
	<cfset has_access = 'Yes'>
<cfelse>
	<cfset has_access = 'No'>
    <cfloop from = "1" to = "#listlen(request.folder_accesslist)#" index="f">
        <cfset folder_name = listgetat(request.folder_accesslist, f)>
        <cfif #listgetat(Dir, 1, "#request.bslash#")# IS #folder_name#>
            <cfset has_access = 'Yes'>
        </cfif>
    </cfloop>
</cfif>

<cfif has_access IS 'No'>
	<cfset Dir = '#request.bslash#'>
</cfif>

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

<cfquery name = "qryFileNames" dbtype="query">
SELECT * FROM WithoutDotParents WHERE type = 'File'
ORDER BY Name ASC
</cfquery>	

<!---Set up variables for paginating--->
 <CFSET end=Start + disp>
 <CFIF Start + disp GREATER THAN qryFileNames.recordcount>
   <CFSET end=999>
   <CFELSE>
   <CFSET end=Start + disp>
 </CFIF>

<table width="100%" border="0" cellpadding="4" cellspacing="0">
<tr>
  <td colspan="3" align="left" valign="top"><span class="style1">File Manager </span><br />
    Current Path: <cfoutput>#dir#</cfoutput></td>
  <td colspan="2" align="right" valign="middle">
  <!---show create folder link if they are not in root folder, but they can only create folders so deep.--->
  <cfif NOT dir IS '#request.bslash#' AND NOT listlen(dir, request.bslash) GT 3>
  <img src="images/newfolder.png" border = "0" style="Cursor:Pointer;" alt="New Folder" title="New Folder" onclick="javascript:ShowNewFolderForm(); " />
  <cfif dir CONTAINS '#request.bslash#docs'>
      &nbsp;<img src="images/document_add.png" border = "0" style="Cursor:Pointer;" alt="New Page" title="New Page" onclick="javascript:ShowNewPageForm(); " /></cfif>
&nbsp;<cfoutput><a href = "index.cfm?action=files.upload&dir=#dir#"><img src="images/disk_blue.png" border = "0" style="Cursor:Pointer;" alt="Upload Files" title="Upload Files" /></a></cfoutput>
</cfif></td>
  </tr>
<tr>
	<td width="200" bgcolor="#000066" colspan="2"><span class="style4">File or Folder</span></td>
	<td bgcolor="#000066"><span class="style4">Size</span></td>
	<td bgcolor="#000066"><span class="style4">Date last modified</span></td>
	<td bgcolor="#000066">&nbsp;</td>
</tr>
<cfif NOT Dir IS '#request.bslash#'>
<!---figure out which directory is up one from this one--->
	<cfset PathLength = listlen(dir, "#request.bslash#")>
	<cfset UpDirName = ListDeleteAt(dir, PathLength, '#request.bslash#')>
	<cfif UpDirName IS ''><cfset UpDirName = '#request.bslash#'></cfif>
  <tr>
    <td colspan="4" valign="middle"><img src="images/folder_up.png"> <cfoutput><a href = "index.cfm?action=files.browse&Dir=#UpDirName#">[Parent Folder]</a></cfoutput></td>
		<td></td>
  </tr>
</cfif>
<!---If this is the main folder then display the default folders--->
<cfif Dir IS '#request.bslash#'>
<cfset ImageName = 'folder.gif'>
<cfloop from = "1" to = "#listlen(request.folder_accesslist)#" index="f">

<cfset folder_name = listgetat(request.folder_accesslist, f)>
<cfoutput>
<tr>
	<td colspan="4"><img src="images/#ImageName#"> <a href = "index.cfm?action=files.browse&Dir=#Dir##folder_name##request.bslash#">#folder_name#</a></td>
	<td></td>
</tr>
</cfoutput>
</cfloop>
</cfif>
<!---If it's not the main folder then display the list of folders in this directory--->
<cfif NOT Dir IS '#request.bslash#'>
<cfoutput Query = "qryDirectories">
  <cfset ImageName = 'folder.gif'>
  <cfif Name IS 'My Forms'><cfset ImageName = 'folder_forms.gif'></cfif>
  <tr>
    <td colspan="4"><img src="images/#ImageName#"> <a href = "index.cfm?action=files.browse&Dir=#Dir##request.bslash##Name##request.bslash#">#Name#</a></td>
	<td>
	<a href = "##" onclick="javascript:ConfirmDeleteFolder('#UrlEncodedFormat(dir)#','#name#');"><img src="images/folder_delete.png" alt="Delete this folder" border="0"></a>	</td>
  </tr>
</cfoutput>
</cfif>

<!---if it's not the main folder then list the files--->

<cfif NOT Dir IS '#request.bslash#'>
<cfoutput query = "qryFileNames">
<!---Figure out what action to use on this file from it's file type--->
<cfset theaction='download'>
<cfset theicon='document.gif'>
<cfset thetype='none'>

<cfif Right(name, 4) IS '.gif' OR right(name, 4) IS '.jpg' OR right(name, 4) IS '.png' OR right(name, 4) IS 'jpeg'>
	<cfset theaction='viewimage'>
	<cfset theicon='image.gif'>
	<cfset thetype='Image'>
</cfif>
<cfif Right(name, 4) IS '.cfm' OR right(name, 5) IS '.html' OR right(name, 4) IS '.txt' OR right(name, 4) IS '.asp' OR right(name, 4) IS '.cfm' OR right(name, 4) IS '.php' OR right(name, 4) IS '.htm'>
	<cfset theaction='editpage'>
    <cfset theicon='document.gif'>
    <cfset thetype='webpage'>
</cfif>
<cfif Right(name, 4) IS '.pdf'>
	<cfset theaction='viewpdf'>
	<cfset theicon='pdffile.gif'>
	<cfset thetype='pdf'>
</cfif>
<cfif Right(name, 4) IS '.doc'>
	<cfset theaction='viewdoc'>
	<cfset theicon='document_word.gif'>
	<cfset thetype='word'>
</cfif>
<cfif Right(name, 4) IS '.avi' OR right(name, 4) IS 'mov' OR right(name, 4) IS '.mpg'>
	<cfset theaction='viewvideo'>
	<cfset theicon='movie.png'>
	<cfset thetype='video'>
</cfif>
<cfif Right(name, 4) IS '.swf'>
	<cfset theaction='viewvideo'>
	<cfset theicon='flash.gif'>
	<cfset thetype='flash'>
</cfif>
<cfif Right(name, 4) IS '.csv' OR Right(name, 4) IS '.txt'>
	<cfset theaction='download'>
	<cfset theicon='document_text.png'>
	<cfset thetype='datafile'>
</cfif>
<cfif Right(name, 4) IS '.zip'>
	<cfset theaction='download'>
	<cfset theicon='document_zip.gif'>
	<cfset thetype='compressedfile'>
</cfif>
<cfif Right(name, 4) IS '.rar'>
	<cfset theaction='download'>
	<cfset theicon='document_rar.gif'>
	<cfset thetype='compressedfile'>
</cfif>


<!---Display the list of files and the appropriate icon next to it--->
<form name = "renameform_#Name#" id="renameform_#Name#" action="index.cfm?action=files.RenameFile" method="Post">
	<tr onmouseover="this.className='HighlightRow'" onmouseout="this.className='NoHighLightRow'" class="NoHighLightRow">
		<td valign="middle" width="18">
		<img src="images/#theicon#"></td>
		<td valign="middle">
		   <span id = "norename_#Name#" style="display: block;">
				<a href="index.cfm?action=files.#theaction#&dir=#dir#&filename=#name#">#Name#</a>		  </span>
		  <span id = "rename_#Name#" style="display: none;">
			<cfset FieldSize = #len(name)# + 10>
			<cfif FieldSize GT 45><cfset FieldSize = 45></cfif>
			<input type = "text" size="#FieldSize#" name = "PageName" id="PageName" style="border:none; background:##CCCCCC; font:Arial, Helvetica, sans-serif; font-size:14px" value="#Name#">
			<input type = "hidden" value="#Dir#" name="Dir">
			<input type = "hidden" value="#Name#" name="Name">
			<input type="image" src="images/greenarrow.gif" name="InputArrow">
			&nbsp;<img src="images/abort.gif" name="Abort" alt="Abort Rename" style="cursor:pointer;" onclick="Javascript:HideRenameForm('#Name#')">		  </span>		</td>
		<td width="50">
		<div align="right">
		<cfif Size LT 1000><cfset mySize = #size#>#mySize# b
		</cfif>
		<cfif Size GT 999 AND Size LT 1000000>
		    <cfset mySize = #Size# / 1000>
		    #Round(mySize)# kb
		</cfif>
		<cfif Size GT 999999><cfset mySize = #Size# / 1000000>#Round(MySize)# mb</cfif>
        </div>
        </td>
		<td width="150">#dateformat(dateLastModified, "mm/dd/yyyy")# #timeformat(dateLastModified, "hh:mm tt")#</td>
		<td width="85" align="center" valign="middle">
		  <div align="left"><a href = "index.cfm?action=files.MoveAfile&filetomove=#Dir##Name#&Dir=#dir#">
		      <img src="images/cut.png" alt="Move" title="Move" border="0"></a> 
		        <a href = "index.cfm?action=files.CopyAfile&filetocopy=#Name#&copyfrom=#dir#&Dir=#dir#">
                <img src="images/copy.png" alt="Copy" title="Copy" border="0"></a> 
		        <a href = "##" onclick="javascript:ConfirmDelete('#UrlEncodedFormat(dir)#','#name#');">
                <img src="images/delete.png" alt="Delete" title="Delete" border="0"></a>
		        <a href = "##" onclick="javascript:ShowRenameForm('#Name#');">
              <img src="images/refresh.png" alt="Rename" title="Renameborder" border="0" /></a>	        </div></td>
	</tr>
	</form>
</cfoutput>
</cfif>
<cfoutput>
	<tr>
	  <td colspan = "4">
	  <span id = "NewFolder" style="display: none;">
	  <form name = "NewFolderForm" action="index.cfm?action=files.CreateFolder" method="Post">
	  <input type = "text" size="30" name = "FolderName" id="FolderName" style="border:none; background:##CCCCCC; font:Arial, Helvetica, sans-serif; font-size:14px"><input type = "hidden" value="#Dir#" name="Dir"><input type="image" src="images/greenarrow.gif" name="InputArrow">
	  &nbsp;<img src="images/abort.gif" name="Abort" alt="Abort New Folder" style="cursor:pointer;" onclick="javascript:HideNewFolderForm();">
	  </form>
	  </span></td>
    </tr>
	<tr>
	  <td colspan = "4">
	  <span id = "NewPage" style="display: none;">
	  <form name = "NewPageForm" action="index.cfm?action=files.CreatePage" method="Post">
	  <input type = "text" size="30" name = "PageName" id="PageName"style="border:none; background:##CCCCCC; font:Arial, Helvetica, sans-serif; font-size:14px"><input type = "hidden" value="#Dir#" name="Dir"><input type="image" src="images/greenarrow.gif" name="InputArrow">
	  &nbsp;<img src="images/abort.gif" name="Abort" alt="Abort" style="cursor:pointer;" onclick="javascript:HideNewFolderForm();">
	  </form>
	  </span></td>
    </tr>
	<tr>
	  <td colspan="4">
	  <span id = "UploadFile" style="display: none;">
	  <form id="UploadForm" name="UploadForm" enctype="multipart/form-data" method="post" action="index.cfm?action=files.UploadFile">
	    <input name="filefield" type="file" size="45" />
		<input type = "hidden" name = "dir" value = "#dir#" style="border:none; background:##CCCCCC; font:Arial, Helvetica, sans-serif; font-size:14px" />
	    <input type="submit" name="Submit" value="Upload Here" onclick = "javascript:LoadStatusWin();" />
		<img src="images/abort.gif" name="Abort" alt="Abort" style="cursor:pointer;" onclick="javascript:HideNewFolderForm();">
	    </form>
	  </span>	  </td>
	  </tr>
</cfoutput>
	<tr>
	  <td colspan="4">
	  <span id = "UploadFileStatus" style="display: none;">
			<img src = "images/uploadanim.gif" /><br />
			Your file is being uploaded.  Please wait...	  </span>	  </td>
	  </tr>
</table>




















