<cfif request.ImageProcessor is 'cf8image'>

	<!---resize the image and create thumbnails--->
	<cfimage action = "info" source="#request.imagespath#large#request.bslash##photo#" structName="imginfo">
	
	<!---Image--->
	<cfif imginfo.width GT #request.ImageSize#>
		<cfimage action="resize"
		source="#request.imagespath#large#request.bslash##Photo#"
		width="#request.ImageSize#"
		height=""
		destination="#request.imagespath#medium#request.bslash##Photo#"
		overwrite="yes"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Thumbnail--->	
	<cfif imginfo.width GT #request.ThumbSize#>
		<cfimage action="resize"
		source="#request.imagespath#large#request.bslash##Photo#"
		width="#request.ThumbSize#"
		height=""
		destination="#request.imagespath#small#request.bslash##Photo#"
		overwrite="yes"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif imginfo.width GT #request.tinySize#>
		<cfimage action="resize"
		source="#request.imagespath#large#request.bslash##Photo#"
		width="#request.tinySize#"
		height=""
		destination="#request.imagespath#tiny#request.bslash##Photo#"
		overwrite="yes"> 

	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>
	
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfimage Action = "info" source="#request.imagespath#large#request.bslash##photo#" structName="imginfo">
		<cfset iHeight = #imginfo.HEIGHT#>
		<cfset iWidth = #imginfo.WIDTH#>
			
	<cfimage Action = "info" source="#request.imagespath#medium#request.bslash##photo#" structName="imginfo">
		<cfset imediumHeight = #imginfo.HEIGHT#>
		<cfset imediumWidth = #imginfo.WIDTH#>
		
	<cfimage Action = "info" source="#request.imagespath#small#request.bslash##photo#" structName="imginfo">
		<cfset iThumbHeight = #imginfo.HEIGHT#>
		<cfset iThumbWidth = #imginfo.WIDTH#>
	
	<cfimage Action = "info" source="#request.imagespath#tiny#request.bslash##photo#" structName="imginfo">
		<cfset itinyHeight = #imginfo.HEIGHT#>
		<cfset itinyWidth = #imginfo.WIDTH#>

</cfif>

