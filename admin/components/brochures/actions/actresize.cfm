



<!---
*********************************************************
User created their own thumbnails so just upload the files they chose
*********************************************************
--->

<cfif request.ImageProcessor IS 'None'>
	<!---don't try to resize it then--->
</cfif>

<!---
*********************************************************
Process the thumbnails with the cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
    <cfx_imagecr3 load ="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##inFile#"
    resize = "#newWidth#x"
    save = "#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##outFile#">
</cfif>

<!---*********************************************************
Process Thumbnails using the cfx_image tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_image'>
<cfx_image action="iml"
file="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##inFile#"
commands="resize #newWidth#
sample
segment
setjgpdpi 300
setjpgquality 95
antialias
write #request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##outFile# 
">
</cfif>

<!---*********************************************************
Process the thumnail using  the imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
<cfscript>
image = createObject("component","ImageJ");
image.open("#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##inFile#");
image.resize(#newWidth#, 'width');
image.saveAs("#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename##request.bslash##outFile#");
</cfscript>
</cfif>

<!---
*********************************************************
Process the thumbnails using the cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>
<CFX_IMAGE ACTION="RESIZE"
FILE="#request.CatalogPath##request.bslash#brochures#request.bslash##form.brochurename#\#inFile#"
WIDTH="#newWidth#"
OUTPUT="#request.CatalogPath#\brochures\#form.brochurename#\#outFile#"
QUALITY="100">
</cfif>

<!---
*********************************************************
Process the thumbnails using the cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>
<cfx_openimage action="iml"
file="#request.CatalogPath#\brochures\#form.brochurename#\#inFile#"
commands="resize #newWidth# 
write #request.CatalogPath#\brochures\#form.brochurename#\#outFile#">
</cfif>

<!---
*********************************************************
*Process the image using cfx_jpegresize tag by chestysoft
Thanks goes to michael for this one!
*********************************************************
--->
<cfif request.ImageProcessor is 'cfxjpegresize'>
<cfx_jpegresize action = "resize"
source = "#request.CatalogPath#\brochures\#form.brochurename#\#inFile#"
filename = "#request.Catalogpath#images\thumbs\#photo#"
quality = "100"
width = "#request.CatalogPath#\brochures\#form.brochurename#\#outFile#">
</cfif>

<!---
*********************************************************
*Process the thumbnails using the cfimage built into cf8*
*********************************************************
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfinclude template = "actresize8.cfm">
</cfif>



















