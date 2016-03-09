<!---Reads the image based on the tag used--->
<cfset photo = #name#>

<!---
*********************************************************
cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
		
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #imagecr.height#>
		<cfset iWidth = #imagecr.width#>

</cfif>

<!---*********************************************************
imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#images#request.bslash##photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iHeight = #IMG_HEIGHT#>
	<cfset iWidth = #IMG_WIDTH#>
</cfif>

<!---
*********************************************************
cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>
	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #variables.IMG_HEIGHT#>
		<cfset iWidth = #variables.IMG_WIDTH#>
</cfif>

<!---
*********************************************************
*cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>
	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>
</cfif>

<!---
*********************************************************
fimage built into cf8
*********************************************************
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfinclude template = "actprocessimage8.cfm">
</cfif>

<!---
*********************************************************
cfx_jpegresize tag by chestysoft
*********************************************************
--->
<cfif request.ImageProcessor is 'cfxjpegresize'>
   
   <CFX_ImageInfoMX FILE="#request.Catalogpath#images#request.bslash##photo#">
      <cfset iHeight = #imageinfomx.height#>
      <cfset iWidth = #imageinfomx.width#>
         
</cfif>