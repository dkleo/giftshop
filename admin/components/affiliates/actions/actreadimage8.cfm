<cfif request.ImageProcessor is 'cf8image'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfimage Action = "info" source="#request.Catalogpath#images#request.bslash#banners#request.bslash##photo#" structName="imginfo">
		<cfset iHeight = #imginfo.HEIGHT#>
		<cfset iWidth = #imginfo.WIDTH#>
</cfif>











