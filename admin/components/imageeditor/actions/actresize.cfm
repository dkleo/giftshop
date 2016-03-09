<!---resizes the temp image to specified size using cfimage--->
<cfset waserror = 'No'>
<cfif len(form.newwidth) IS 0 AND len(form.newheight) IS 0>
	<cfset waserror = 'Yes'>
</cfif>

<!----values must be numeric or they will be ignored--->
<cfif len(form.newwidth) GT 0>
	<cfif NOT isnumeric(form.newwidth)>
    	<cfset waserror = 'Yes'>
    </cfif>
</cfif>

<cfif len(form.newheight) GT 0>
	<cfif NOT isnumeric(form.newheight)>
    	<cfset waserror = 'Yes'>
    </cfif>
</cfif>

<cfif waserror IS 'No'>
	<cfset destinationcopy = cookie.imagefile>
    <cfset newfile = '#replace(cookie.imagefile, lastcount, nextcount)#'>
	<cfset destinationcopy = "#request.CatalogPath#temp#request.bslash##replace(cookie.imagefile, lastcount, nextcount)#">
	<cfset destinationcopy = replace(destinationcopy, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
	
	<cfset sourceimage = cookie.imagefile>
	<cfset sourceimage = "#request.CatalogPath#temp#request.bslash##sourceimage#">
	<cfset sourceimage= replace(sourceimage, "#request.bslash##request.bslash#", "#request.bslash#", "ALL")>
	
	<!---resize by pixels--->
	<cfif resizeby IS 'pixels'>
	<cfimage
		action = "resize"
		height = "#form.newheight#"
		source = "#sourceimage#"
		width = "#form.newwidth#"
		destination = "#destinationcopy#"
		overwrite = "yes">
	</cfif>
	
	<!---resize by percentage--->
	<cfif resizeby IS 'percentage'>
		<cfif len(newheight) GT 0>
			<cfset hsymbol = "%">
		<cfelse>
			<cfset hsymbol = "">
		</cfif>
		
		<cfif len(newwidth) GT 0>
			<cfset wsymbol = "%">
		<cfelse>
			<cfset wsymbol = "">
		</cfif>
		
	<cfimage
		action = "resize"
		height = "#form.newheight##hsymbol#"
		source = "#sourceimage#"
		width = "#form.newwidth##wsymbol#"
		destination = "#destinationcopy#"
		overwrite = "yes">
	</cfif>
</cfif>

<cfcookie name="imagefile" value="#newfile#">

<cfset nextstep = cookie.current_step + 1>
<cfcookie name = "current_step" value="#nextstep#">

<cflocation url = "index.cfm">















