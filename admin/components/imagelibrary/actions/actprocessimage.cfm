<!---This file processes the image to make a thumbnail (this differs from the other one in photomanager as this only generates
a thumbnail for previewing.

It determines which tag (if any) to use to process the image and then processes it--->

<!---
*********************************************************
User created their own thumbnails so just upload the files they chose
*********************************************************
--->

<cfif request.ImageProcessor IS 'None'>
	<!---If it's none then they need to specify each file to upload--->
	
	<cfif form.ImageFiles IS '' OR form.ThumbFile IS ''>
	You must specify a file for both the image and the thumbnail since you have not specified an image processor to use in the settings section of the control panel.
	<cfabort>
	</cfif>
	
	<CFFILE	Action="Upload"
	FileField = "form.ThumbFile"
	Destination = "#request.Catalogpath#images#request.bslash#thumbs#request.bslash#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">

	<!---Set the height and width to the default since there is no tag to read the image info--->
	<cfset iHeight = 350>
	<cfset iWidth = 400>
	<cfset iThumbHeight=135>
	<cfset iThumbWidth=#request.ImageSize#>
</cfif>

<!---*********************************************************
Process Thumbnails using the cfx_image tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_image'>

	<!---resize the image and create thumbnails--->
	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
	
	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
				<cfx_image action="iml"
				file="#request.Catalogpath#images#request.bslash##photo#"
				commands="resize #request.ThumbSize#
				sample
				segment
				setjgpdpi 300
				setjpgquality 95
				antialias
				write #request.Catalogpath#images#request.bslash#thumbs#request.bslash##Photo# 
				">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images#request.bslash##photo#" destination="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
</cfif>	
	
<!---
*********************************************************
Process the thumbnails with the cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
		
	<!---resize the image and create thumbnails--->
							
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#images#request.bslash##photo#">
	<cfset IMG_WIDTH = #imagecr.width#>
	
	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
				<cfx_imagecr3 load="#request.Catalogpath#images#request.bslash##photo#"
				resize="#request.ThumbSize#x"
				save="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##Photo#"
				cache="0">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images#request.bslash##photo#" destination="#request.Catalogpath#images#request.bslash#thumbs#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #imagecr.height#>
		<cfset iWidth = #imagecr.width#>
			
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#images\thumbs\#Photo#">
		<cfset iThumbHeight = #imagecr.height#>
		<cfset iThumbWidth = #imagecr.width#>
</cfif>

<!---*********************************************************
Process the thumnail using  the imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
		
	<!---resize the image and create thumbnails--->
							
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#images\#photo#");
	IMAGE_WIDTH = image.getWidth();
	</cfscript>
	
	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.Catalogpath#images\#photo#");
		image.resize(#request.ThumbSize#, 'width');
		image.saveAs("#request.Catalogpath#images\thumb\#Photo#");
		</cfscript>
		<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images\#photo#" destination="#request.Catalogpath#images\thumb\#photo#" nameconflict="overwrite">
	</cfif>

	<!---Read the widths and heights--->
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#images\#photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iHeight = #IMG_HEIGHT#>
	<cfset iWidth = #IMG_WIDTH#>

	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.Catalogpath#images\thumbs\#Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iThumbHeight = #IMG_HEIGHT#>
	<cfset iThumbWidth = #IMG_WIDTH#>

	<cfset iTinyHeight = #IMG_HEIGHT#>
	<cfset iTinyWidth = #IMG_WIDTH#>
	
</cfif>

<!---
*********************************************************
Process the thumbnails using the cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>

	<!---resize the image and create thumbnails--->
							
	<CFX_Image action = "Read" File="#request.Catalogpath#images\#photo#">
	
	<!---Thumbnail--->	
	<cfif variables.img_width GT #request.ThumbSize#>
				<CFX_IMAGE ACTION="RESIZE"
				FILE="#request.Catalogpath#images\#photo#"
				WIDTH="#request.ThumbSize#"
				OUTPUT="#request.Catalogpath#images\thumbs\#Photo#"
				QUALITY="100">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images\#photo#" destination="#request.Catalogpath#images\thumbs\#photo#" nameconflict="overwrite">
	</cfif>

	<CFX_Image Action = "Read" File="#request.Catalogpath#images\#photo#">
		<cfset iHeight = #variables.IMG_HEIGHT#>
		<cfset iWidth = #variables.IMG_WIDTH#>
			
	<CFX_Image Action = "Read" File="#request.Catalogpath#images\thumbs\#photo#">
		<cfset iThumbHeight = #variables.IMG_HEIGHT#>
		<cfset iThumbWidth = #variables.IMG_WIDTH#>

</cfif>

<!---
*********************************************************
Process the thumbnails using the cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>

	<!---resize the image and create thumbnails--->
							
	<CFX_OpenImage action = "READ" File="#request.Catalogpath#images\#photo#">
	
	<!---Thumbnail--->	
	<cfif img_width GT #request.ThumbSize#>
				<cfx_openimage action="iml"
				file="#request.Catalogpath#images\#photo#"
				commands="resize #request.ThumbSize# 
				write #request.Catalogpath#images\thumbs\#Photo#">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.Catalogpath#images\#photo#" destination="#request.Catalogpath#images\thumbs\#photo#" nameconflict="overwrite">
	</cfif>

	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#images\#photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#images\thumbs\#photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
</cfif>

<!---
*********************************************************
*Process the thumbnails using the cfimage built into cf8*
*********************************************************
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfinclude template = "actprocessimage8.cfm">
</cfif>

<!---
*********************************************************
*Process the image using cfx_jpegresize tag by chestysoft
Thanks goes to michael for this one!
*********************************************************
--->
<cfif request.ImageProcessor is 'cfxjpegresize'>
   
   <!---Resize image and create thumbnails--->
   
   <CFX_ImageInfoMX FILE = "#request.Catalogpath#images\#photo#">
   
   <!---Thumbnail--->
   <cfif imageinfomx.width GT #request.ThumbSize#>
         <cfx_jpegresize action = "resize"
               source = "#request.Catalogpath#images\#photo#"
               filename = "#request.Catalogpath#images\thumbs\#photo#"
              quality = "100"
               width = "#request.ThumbSize#">
      <cfelse><!---Just copy it--->
         <cffile action = "copy" source="#request.Catalogpath#images\#photo#" destination="#request.Catalogpath#images\thumbs\#photo#" nameconflict="overwrite">
   </cfif>

   <CFX_ImageInfoMX FILE="#request.Catalogpath#images\#photo#">
      <cfset iHeight = #imageinfomx.height#>
      <cfset iWidth = #imageinfomx.width#>

   <CFX_ImageInfoMX FILE="#request.Catalogpath#images\thumbs\#photo#">
      <cfset iThumbHeight = #imageinfomx.height#>
      <cfset iThumbWidth = #imageinfomx.width#>
         
</cfif>



















