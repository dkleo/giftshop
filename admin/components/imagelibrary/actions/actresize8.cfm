<cfif request.ImageProcessor is 'cf8image'>

	<!---by width--->
	<cfif len(form.newwidth) GT 0>
		<cfimage action="resize"
		source="#request.Catalogpath#images#request.bslash##Photo#"
		width="#form.newwidth#"
		height=""
		destination="#request.Catalogpath#images#request.bslash##Photo#"
		overwrite="yes">
     </cfif>

	<!---not by height--->
	<cfif len(form.newheight) GT 0>
		<cfimage action="resize"
		source="#request.Catalogpath#images#request.bslash##Photo#"
		height="#form.newheight#"
		width=""
		destination="#request.Catalogpath#images#request.bslash##Photo#"
		overwrite="yes">
     </cfif>
     
	<cfimage Action = "info" source="#request.Catalogpath#images#request.bslash##photo#" structName="imginfo">
		<cfset iHeight = #imginfo.HEIGHT#>
		<cfset iWidth = #imginfo.WIDTH#>
</cfif>



















