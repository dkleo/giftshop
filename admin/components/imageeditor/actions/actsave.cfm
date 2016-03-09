<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>You cannot save changes to images in the demo.</strong></font>
	<cfabort>
</cfif>

<!---saves the image, overwriting the original.--->
<cfset cur_step = '#cookie.current_step#_'>
<cfset orig_imagename = replace(cookie.imagefile, cur_step, '')>
<cffile action = "copy" source = "#request.catalogpath#temp#request.bslash##cookie.imagefile#" destination="#request.catalogpath#images#request.bslash##orig_imagename#" nameconflict="overwrite" mode="777">

<script language="javascript">
	alert('Your image has been saved!');
	
	window.location.href = "index.cfm";
</script>
















