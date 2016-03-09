<!---read the custom style sheet--->
<cfset fullpath = "#request.catalogpath#global.css">
<cffile action = "read" file="#fullpath#" variable="FileContents">

<cfset stylenameslist = rereplacenocase(FileContents, "{.*?}", "", "ALL")>

<!---break it down into lists to seperate out the css style names.  The custom styles are separated by a "." then {} then ;--->

<h2>Global Stylesheet Editor</h2>
<p>You can edit the custom style sheet that is applied to your website that was written when you setup a default site layout. Read the help manual for more information on how to use this feature. Tip: If you don't want a style to apply then just keep all fields blank and set all drop down boxes to &quot;Not Specified&quot;.</p>
<cfif isdefined('url.stylesaved')>
<b><font color="#FF0000">The custom style was saved!</font></b>
</cfif>
<cfif isdefined('url.error')>
<b><font color="#FF0000">You must give your new style a name!</font></b>
</cfif>
<cfif isdefined('url.duplicate')>
<b><font color="#FF0000">You cannot duplicate a style name.</font></b>
</cfif>
<cfset currentstyles = 0>
<p>Select a  tag to edit:</p>
<form method = "post" <cfoutput>action="index.cfm?action=editstyle"</cfoutput>>
<select name = "editstyle">
<cfloop from = "1" to="#Listlen(stylenameslist, '.')#" index="mycount">
	<cfset stylename = listgetat(stylenameslist, mycount, ".")>
	<cfoutput><option>#stylename#</option></cfoutput>
	<cfset currentstyles = listappend(currentstyles, stylename, "^")>
</cfloop>
</select><input type = "hidden" name = "editing" value = "yes">
<input type = "submit" name="submit" value="Edit Style"> 
or
</form>
<form method = "post" <cfoutput>action="index.cfm?action=editstyle"</cfoutput>>
  Add a new one: 

  <input name="editstyle" type="text" id="editstyle" value="mystyle" size="20" maxlength="250">
  <input type = "hidden" name = "editing" value = "no">
	<cfoutput><input type = "hidden" name = "currentstyles" value = "#currentstyles#"></cfoutput>
<input type = "submit" name="submit" value="Add New Style">
</form>