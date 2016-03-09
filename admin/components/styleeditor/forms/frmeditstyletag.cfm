<cfparam name = "editing" default="no">

<cfif form.editstyle IS ''>
	<cflocation url = "index.cfm?action=settings.customcss.default&mytoken=#mytoken#&isplugin=no&error=yes">
</cfif>

<!---check for duplicate style if adding not editing--->
<cfif editing IS 'no'>
<cfloop from = "1" to="#listlen(form.currentstyles, '^')#" index="mycount">
	<cfset sname = listgetat(form.currentstyles, mycount, "^")>
	<cfif rtrim(sname) IS form.editstyle>
		<cflocation url = "index.cfm?action=settings.customcss.default&mytoken=#mytoken#&isplugin=no&duplicate=yes">
	</cfif>
</cfloop>	
</cfif>

<!---Read the custom style sheet and load variables for each setting that is specified in the css.--->
<!---load default values for all the styles they can use--->
<cfset fullpath = "#request.catalogpath#global.css">
<cffile action = "read" file="#fullpath#" variable="FileContents">

<cfif editing IS 'yes'>
	<!---Find the tag that they want to edit and select only this style block--->
	<cfset startpos = findnocase(".#form.editstyle#", FileContents, 1)>
	<cfset endpos = findnocase("}", FileContents, startpos)>
	<cfset charcount = endpos - startpos>
	<cfset charcount = charcount + 1>
	<cfset styleblock = mid(FileContents, startpos, charcount)>
	
	<!---Now that we have a style block to deal with, we want to select everything between { and }--->
	<cfset startpos = findnocase("{", styleblock, 1)>
	<cfset endpos = findnocase("}", styleblock, startpos)>
	<cfset charcount = endpos - startpos>
	<cfset startpos = startpos + 1>
	<cfset stylelist = mid(styleblock, startpos, charcount)>
	<cfset stylelist = ltrim(stylelist)>
	<cfset stylelist = rtrim(stylelist)>
	
	<cfloop from = "1" to="#listlen(stylelist, ';')#" index="mycount">
	<cfset thistag = listgetat(stylelist, mycount, ";")>
	<cfif listlen(thistag, ":") GT 1>
		<!---Get the value of this tag and the tag name--->
		<cfset tagname = listgetat(thistag, 1, ":")>
		<!---remove the hyphen if this tag uses it--->
		<cfset tagname = replace(tagname, "-", "", "ALL")>
		<cfset tagval = listgetat(thistag, 2, ":")>
		<cfset tagname = ltrim(tagname)>
		<cfset tagval = ltrim(tagval)>
		<!---If it's the backgroundimage style then it will have 3 in the list since the url will contain
			the ":" which is our delimiter--->
		<cfif tagname IS 'backgroundimage'>
			<cfif listlen(thistag, ":") GT 2>
				<cfset tagval = '#tagval#:#listgetat(thistag, 3, ":")#'>
			</cfif>
		</cfif>
		
		<!---setup the default value for this tag--->
		<cfparam name = "#tagname#" default="#tagval#">
	</cfif>
	</cfloop>
</cfif>

<!---setup the default values if they don't exist--->
<cfif NOT isdefined('fontfamily')>
	<cfparam name = "fontfamily" default = "">
</cfif>
<cfif NOT isdefined('fontsize')>
	<cfparam name = "fontsize" default = "">
</cfif>
<cfif NOT isdefined('lineheight')>
	<cfparam name = "lineheight" default = "">
</cfif>
<cfif NOT isdefined('fontweight')>
	<cfparam name = "fontweight" default = "">
</cfif>
<cfif NOT isdefined('color')>
	<cfparam name = "color" default="">
</cfif>
<cfif NOT isdefined('textdecoration')>
	<cfparam name = "textdecoration" default = "">
</cfif>
<cfif NOT isdefined('backgroundcolor')>
	<cfparam name = "backgroundcolor" default = "">
</cfif>
<cfif NOT isdefined('backgroundimage')>
	<cfparam name = "backgroundimage" default = "">
</cfif>
<cfif NOT isdefined('backgroundrepeat')>
	<cfparam name = "backgroundrepeat" default = "">
</cfif>
<cfif NOT isdefined('backgroundposition')>
	<cfparam name = "backgroundposition" default = "">
</cfif>
<cfif NOT isdefined('textalign')>
	<cfparam name = "textalign" default = "">
</cfif>
<cfif NOT isdefined('verticalalign')>
	<cfparam name = "verticalalign" default="">
</cfif>
<cfif NOT isdefined('height')>
	<cfparam name = "height" default="">
</cfif>
<cfif NOT isdefined('width')>
	<cfparam name = "width" default="">
</cfif>
<cfif NOT isdefined('paddingleft')>
	<cfparam name = "paddingleft" default="">
</cfif>
<cfif NOT isdefined('paddingtop')>
	<cfparam name = "paddingtop" default="">
</cfif>
<cfif NOT isdefined('paddingright')>
	<cfparam name = "paddingright" default="">
</cfif>
<cfif NOT isdefined('paddingbottom')>
	<cfparam name = "paddingbottom" default="">
</cfif>
<cfif NOT isdefined('border')>
	<cfparam name = "border" default="">
</cfif>

<!---load the form--->
<cfinclude template = "frmstyleeditor.cfm">
