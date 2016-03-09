<cfif request.ImageProcessor is 'cf8image'>

	<!---resize the image and create thumbnails--->
							
	<cfimage action = "info" source="#request.Catalogpath#images#request.bslash##photo#" structName="imginfo">
	
	<!---Thumbnail--->	
	<cfif imginfo.width GT #request.ThumbSize#>
		<cfimage action="resize"
		source="#request.Catalogpath#images#request.bslash##Photo#"
		width="#request.ThumbSize#"
		height=""
		destination="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##Photo#"
		overwrite="yes"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images#request.bslash##photo#" destination="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##photo#" nameconflict="overwrite" mode="777">
	</cfif>

	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfimage Action = "info" source="#request.Catalogpath#images#request.bslash##photo#" structName="imginfo">
		<cfset iHeight = #imginfo.HEIGHT#>
		<cfset iWidth = #imginfo.WIDTH#>
			
	<cfimage Action = "info" source="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##photo#" structName="imginfo">
		<cfset iThumbHeight = #imginfo.HEIGHT#>
		<cfset iThumbWidth = #imginfo.WIDTH#>
</cfif>



















