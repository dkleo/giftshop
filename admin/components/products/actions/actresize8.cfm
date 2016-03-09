<cfif request.ImageProcessor is 'cf8image'>
<cfimage action="resize"
source="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##inFile#"
width="#newWidth#"
height=""
destination="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##outFile#"
overwrite="yes"> 
</cfif>















