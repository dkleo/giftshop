<cfif request.ImageProcessor is 'cf8image'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfimage Action = "info" source="#request.Catalogpath#photos#request.bslash#large#request.bslash##photo#" structName="imginfo">
		<cfset iHeight = #imginfo.HEIGHT#>
		<cfset iWidth = #imginfo.WIDTH#>
			
	<cfimage Action = "info" source="#request.Catalogpath#photos#request.bslash#medium#request.bslash##photo#" structName="imginfo">
		<cfset iMediumHeight = #imginfo.HEIGHT#>
		<cfset iMediumWidth = #imginfo.WIDTH#>
		
	<cfimage Action = "info" source="#request.Catalogpath#photos#request.bslash#small#request.bslash##photo#" structName="imginfo">
		<cfset iThumbHeight = #imginfo.HEIGHT#>
		<cfset iThumbWidth = #imginfo.WIDTH#>
	
	<cfimage Action = "info" source="#request.Catalogpath#photos#request.bslash#tiny#request.bslash##photo#" structName="imginfo">
		<cfset iTinyHeight = #imginfo.HEIGHT#>
		<cfset iTinyWidth = #imginfo.WIDTH#>
</cfif>































