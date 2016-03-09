<!---This file reads the image based on settings in the database.  It determines which tag (if any) 
to use to read the image--->

<!---
*********************************************************
User created their own thumbnails so just set defaults   
*********************************************************
--->

<cfif request.ImageProcessor IS 'None'>
	<!---Set the height and width to the default since there is no tag to read the image info--->
	<cfset iHeight = 350>
	<cfset iWidth = 400>
	<cfset iMediumHeight=135>
	<cfset iMediumWidth=#request.ImageSize#>
  	<cfset iThumbHeight = 175>
	<cfset iThumbWidth = #request.ThumbSize#>
	<cfset iTinyHeight = 75>
	<cfset iTinyWidth = 75>
</cfif>

<!---*********************************************************
Read using the cfx_image tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_image'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#large#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#medium#request.bslash##photo#">
		<cfset iMediumHeight = #IMG_HEIGHT#>
		<cfset iMediumWidth = #IMG_WIDTH#>
			
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#small#request.bslash##photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
	
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#tiny#request.bslash##photo#">
		<cfset iTinyHeight = #IMG_HEIGHT#>
		<cfset iTinyWidth = #IMG_WIDTH#>
</cfif>	
	
<!---
*********************************************************
Read with the cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#photos#request.bslash#large#request.bslash##Photo#">
		<cfset iHeight = #imagecr.height#>
		<cfset iWidth = #imagecr.width#>
			
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#photos#request.bslash#medium#request.bslash##Photo#">
		<cfset iMediumHeight = #imagecr.height#>
		<cfset iMediumWidth = #imagecr.width#>

	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#photos#request.bslash#small#request.bslash##Photo#">
		<cfset iThumbHeight = #imagecr.height#>
		<cfset iThumbWidth = #imagecr.width#>
	
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#photos#request.bslash#tiny#request.bslash##Photo#">
		<cfset iTinyHeight = #imagecr.height#>
		<cfset iTinyWidth = #imagecr.width#>
</cfif>

<!---*********************************************************
Read using  the imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
	<!---Read the widths and heights--->
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#photos#request.bslash#large#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iHeight = #IMG_HEIGHT#>
	<cfset iWidth = #IMG_WIDTH#>

	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#photos#request.bslash#medium#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iMediumHeight = #IMG_HEIGHT#>
	<cfset iMediumWidth = #IMG_WIDTH#>

			
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#photos#request.bslash#small#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>

	<cfset iThumbHeight = #IMG_HEIGHT#>
	<cfset iThumbWidth = #IMG_WIDTH#>
	
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#photos#request.bslash#Tiny#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>

	<cfset iTinyHeight = #IMG_HEIGHT#>
	<cfset iTinyWidth = #IMG_WIDTH#>
	
</cfif>

<!---
*********************************************************
Read using the cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#large#request.bslash##photo#">
		<cfset iHeight = #variables.IMG_HEIGHT#>
		<cfset iWidth = #variables.IMG_WIDTH#>
			
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#small#request.bslash##photo#">
		<cfset iThumbHeight = #variables.IMG_HEIGHT#>
		<cfset iThumbWidth = #variables.IMG_WIDTH#>

	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#medium#request.bslash##photo#">
		<cfset iMediumHeight = #variables.IMG_HEIGHT#>
		<cfset iMediumWidth = #variables.IMG_WIDTH#>
	
	<CFX_Image Action = "Read" File="#request.Catalogpath#photos#request.bslash#tiny#request.bslash##photo#">
		<cfset iTinyHeight = #variables.IMG_HEIGHT#>
		<cfset iTinyWidth = #variables.IMG_WIDTH#>
</cfif>

<!---
*********************************************************
Read using the cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#photos\large\#photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#photos\medium\#photo#">
		<cfset iMediumHeight = #IMG_HEIGHT#>
		<cfset iMediumWidth = #IMG_WIDTH#>
			
	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#photos\small\#photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
	
	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#photos\tiny\#photo#">
		<cfset iTinyHeight = #IMG_HEIGHT#>
		<cfset iTinyWidth = #IMG_WIDTH#>
</cfif>

<!---
*********************************************************
*Read using the cfimage built into cf8*
*********************************************************
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfinclude template = "actprocessimage8.cfm">
</cfif>

<!---
*********************************************************
*Read image using cfx_jpegresize tag by chestysoft
*Thanks goes to michael for this one!
*********************************************************
--->
<cfif request.ImageProcessor is 'cfxjpegresize'>
      <!---Now read all three so that the height and width can be stored in the db for future use--->
   <CFX_ImageInfoMX FILE="#request.Catalogpath#photos\large\#photo#">
      <cfset iHeight = #imageinfomx.height#>
      <cfset iWidth = #imageinfomx.width#>

   <CFX_ImageInfoMX FILE="#request.Catalogpath#photos\medium\#photo#">
      <cfset iMediumHeight = #imageinfomx.height#>
      <cfset iMediumWidth = #imageinfomx.width#>
         
   <CFX_ImageInfoMX FILE="#request.Catalogpath#photos\small\#photo#">
      <cfset iThumbHeight = #imageinfomx.height#>
      <cfset iThumbWidth = #imageinfomx.width#>
   
   <CFX_ImageInfoMX FILE="#request.Catalogpath#photos\tiny\#photo#">
      <cfset iTinyHeight = #imageinfomx.height#>
      <cfset iTinyWidth = #imageinfomx.width#>
</cfif>
