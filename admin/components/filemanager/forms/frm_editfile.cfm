<!---Read the contents of the file and then put it in the editor--->
<cfset fullpath = "#request.catalogpath##url.Dir##request.bslash##url.FileName#">
<cfset fullpath = replacenocase(fullpath, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>

<cffile action = "read" file="#fullpath#" variable="FileContents">

<style type="text/css">
<!--
.style1 {
	font-size: 14pt;
	font-weight: bold;
}
-->
</style>

<cfset TheFileContents = FileContents>

<cfsavecontent variable="thefilecontents">
<cfoutput>
<html>
<head>
<title>#FileName#</title>
<link rel="stylesheet" href="#request.homeURL#stylesheets/mainstyles.css">
<link rel="stylesheet" href="#request.homeURL#stylesheets/custom.css">
</head>
<body class="editdiv content">
#FileContents#
</body>
</html>
</cfoutput>
</cfsavecontent>

<form method="POST" <cfoutput>action="index.cfm?action=files.SaveFile&dir=#url.dir#"</cfoutput>>
<cfoutput>
<table border="0" cellspacing="0"  width="100%" id="AutoNumber1">
<tr>
<td width="100%">
<span class="style1">Editing: #FileName#</span><input type = "submit" name="submit" value="Save Page" /><br />
<center>
<input type = "hidden" name = "FileName" value="#url.FileName#" />
<textarea name="FileContents" id="FileContents" style="width: 100%;" rows="300">#TheFileContents#</textarea>            
</td>
</tr>
</table>
</cfoutput>
</form>

<cfoutput>
<script type="text/javascript">


	CKEDITOR.replace( 'FileContents',
	{
		height:"600", width:"100%",
		filebrowserBrowseUrl : '#request.absolutepath#admin/filebrowser/browselinks.cfm',
		filebrowserImageBrowseUrl : '#request.absolutepath#admin/filebrowser/browse.cfm',
		filebrowserFlashBrowseUrl : '#request.absolutepath#admin/filebrowser/browseflash.cfm',
		stylesCombo_stylesSet: 'site_styles:#request.homeurl#config/ckstyles.js'				
	});

</script>
</cfoutput>