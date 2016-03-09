<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>You cannot save changes to images in the demo.</strong></font>
	<cfabort>
</cfif>

<!---saves the image, overwriting the original.--->
<cfset new_imageFilename = form.imageFilename>
<cfset new_imageFilename = replacenocase(new_imageFilename, ' ', '_', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '?', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '/', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '#request.bslash#', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '!', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '##', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '$', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '%', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '^', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '(', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, ')', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '&', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '!', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, ':', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, ';', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, '"', '', 'ALL')>
<cfset new_imageFilename = replacenocase(new_imageFilename, "'", "", "ALL")>

<cfif NOT right(new_imageFilename, 4) IS right(cookie.imagefile, 4)>
	<cfset new_imageFilename = replacenocase(new_imageFilename, right(new_imageFilename, 4), right(cookie.imagefile, 4))>
</cfif>

<cffile action = "copy" source = "#request.catalogpath#temp#request.bslash##cookie.imagefile#" destination="#request.catalogpath#images#request.bslash##new_imageFilename#" nameconflict="overwrite" mode="777">

<script language="javascript">
	alert('Your image has been saved!');
	
	window.location.href = "index.cfm";
	
</script>















