<cfinclude template = "frmmenu.cfm">
<br />

<div id="editor_area" class="editor_area">
<cfif isdefined('url.imagefile')>
	<cfoutput><cfcookie name="imagefile" expires="NEVER" value="#url.imagefile#"></cfoutput>
    
	<!---clear temp directory--->
    <cfdirectory name="qclear" action="list" directory="#request.catalogpath#temp#request.bslash#">
    <cfloop query="qclear">
        <cffile action="delete" file="#request.catalogpath#temp#request.bslash##name#">
    </cfloop>

	<!---copy the image to edit to the temp folder so we can save changes--->
    <cffile action = "copy" source = "#request.catalogpath#images#request.bslash##cookie.imagefile#" destination="#request.catalogpath#temp#request.bslash#1_#cookie.imagefile#" nameconflict="overwrite" mode="777">

	<cfoutput><cfcookie name="imagefile" value="1_#url.imagefile#"></cfoutput>
	<cfcookie name = "current_step" value="1">
	<cflocation url="index.cfm">

</cfif>

<cfif isdefined('cookie.imagefile')>

<cfoutput><img src="#request.homeurl#temp/#cookie.imagefile#" alt="#cookie.imagefile#" title="#cookie.imagefile#" id="editImage" name="#cookie.imagefile#" /></cfoutput>

<!---for cropper, these values chagne for selection area--->
<form method = "post" action="index.cfm?action=crop" name="cropform" id="cropform">
<input type="hidden" name="x1" id="x1" />
<input type="hidden" name="y1" id="y1" />
<input type="hidden" name="x2" id="x2" />
<input type="hidden" name="y2" id="y2" />
<input type="hidden" name="width" id="width" />
<input type="hidden" name="height" id="height" />
</form>

<script type="text/javascript" language="javascript">
  Event.observe( window, 'load', function() {
      new Cropper.Img(
          'editImage',
          { onEndCrop: onEndCrop }
      );
  } );
</script>
</cfif>

<cfif NOT isdefined('cookie.imagefile')>
	Open the file menu and choose open to select an image to edit.
</cfif>

</div>