<!---This file processes the image to make a thumbnail, a medium image, and a tiny Thumbnail based on settings 
in the database.  It determines which tag (if any) to use to process the image and then processes it--->

<!---
*********************************************************
User created their own thumbnails so just upload the files they chose
*********************************************************
--->

<cfif request.ImageProcessor IS 'None'>
	<!---If it's none then they mediumfile, smallfile, and tinyfile fields should found so upload them to the correct
	directories--->
	
	<cfif form.mediumfile IS '' OR form.smallfile IS '' OR form.tinyfile IS ''>
	You must specify a file for each image size, because you have not specified in your settings how the images should be processed.
	Consider installing a custom tag to process the images or hit your back button and provide a file name for each one.
	<cfabort>
	</cfif>
	
	<CFFILE	Action="Upload"
	FileField = "form.mediumfile"
	Destination = "#request.imagespath#medium#request.bslash#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">

	<CFFILE	Action="Upload"
	FileField = "form.smallfile"
	Destination = "#request.imagespath#small#request.bslash#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">

	<CFFILE	Action="Upload"
	FileField = "form.tinyfile"
	Destination = "#request.imagespath#tiny#request.bslash#"
	NameConflict = "overwrite"
	Accept = "image/gif, image/pjpeg, image/jpg, image/jpeg, image/png">

	<!---Set the height and width to the default since there is no tag to read the image info--->
	<cfset iHeight = 350>
	<cfset iWidth = 400>
	<cfset imediumHeight=135>
	<cfset imediumWidth=#request.ImageSize#>
  	<cfset iThumbHeight = 175>
	<cfset iThumbWidth = #request.ThumbSize#>
	<cfset itinyHeight = 75>
	<cfset itinyWidth = 75>
</cfif>

<!---*********************************************************
Process Thumbnails using the cfx_image tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_image'>

	<!---resize the image and create thumbnails--->
							
	<!---Convert it to a gif--->
	<CFX_Image Action = "Convert" 
	File="#request.imagespath#large#request.bslash##photo#"
	Output="#request.imagespath#large#request.bslash##photo#.gif">
	
	<cfset photo = "#photo#.gif">
	
	<CFX_Image Action = "Read" File="#request.imagespath#large#request.bslash##photo#">
	
	<!---medium Image--->
	<cfif IMG_WIDTH GT #request.ImageSize#>
				<cfx_image action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				sample
				commands="resize #request.ImageSize# 
				write #request.imagespath#medium#request.bslash##Photo#
				"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>


	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
				<cfx_image action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				commands="resize #request.ThumbSize#
				sample
				segment
				setjgpdpi 300
				setjpgquality 95
				antialias
				write #request.imagespath#small#request.bslash##Photo# 
				">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif IMG_WIDTH GT #request.tinySize#>
				<cfx_image action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				commands="resize #request.tinySize#
				sample
				segment
				setjgpdpi 300
				setjpgquality 95
				antialias
				write #request.imagespath#tiny#request.bslash##Photo#
				">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_Image Action = "Read" File="#request.imagespath#large#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_Image Action = "Read" File="#request.imagespath#medium#request.bslash##photo#">
		<cfset imediumHeight = #IMG_HEIGHT#>
		<cfset imediumWidth = #IMG_WIDTH#>
			
	<CFX_Image Action = "Read" File="#request.imagespath#small#request.bslash##photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
	
	<CFX_Image Action = "Read" File="#request.imagespath#tiny#request.bslash##photo#">
		<cfset itinyHeight = #IMG_HEIGHT#>
		<cfset itinyWidth = #IMG_WIDTH#>
</cfif>	
	
<!---
*********************************************************
Process the thumbnails with the cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
		
	<!---resize the image and create thumbnails--->
							
	<cfx_imagecr3 GetImageInfo = "#request.imagespath#large#request.bslash##Photo#">
	<cfset IMG_WIDTH = #imagecr.width#>
	
	<!---medium--->
	<cfif IMG_WIDTH GT #request.ImageSize#>
				<cfx_imagecr3 load="#request.imagespath#large#request.bslash##Photo#"
				resize="#request.ImageSize#x"
				save="#request.imagespath#medium#request.bslash##Photo#"
				cache="0"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
				<cfx_imagecr3 load="#request.imagespath#large#request.bslash##Photo#"
				resize="#request.ThumbSize#x"
				save="#request.imagespath#small#request.bslash##Photo#"
				cache="0">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif IMG_WIDTH GT #request.tinySize#>
				<cfx_imagecr3 load="#request.imagespath#large#request.bslash##Photo#"
				resize="#request.tinySize#x"
				save="#request.imagespath#tiny#request.bslash##Photo#"
				cache="0">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<cfx_imagecr3 GetImageInfo = "#request.imagespath#large#request.bslash##Photo#">
		<cfset iHeight = #imagecr.height#>
		<cfset iWidth = #imagecr.width#>
			
	<cfx_imagecr3 GetImageInfo = "#request.imagespath#medium#request.bslash##Photo#">
		<cfset imediumHeight = #imagecr.height#>
		<cfset imediumWidth = #imagecr.width#>

	<cfx_imagecr3 GetImageInfo = "#request.imagespath#small#request.bslash##Photo#">
		<cfset iThumbHeight = #imagecr.height#>
		<cfset iThumbWidth = #imagecr.width#>
	
	<cfx_imagecr3 GetImageInfo = "#request.imagespath#tiny#request.bslash##Photo#">
		<cfset itinyHeight = #imagecr.height#>
		<cfset itinyWidth = #imagecr.width#>

</cfif>

<!---*********************************************************
Process the thumnail using  the imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
		
	<!---resize the image and create thumbnails--->
							
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.imagespath#large#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	</cfscript>
	
	<!---Image--->
	<cfif IMG_WIDTH GT #request.ImageSize#>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.imagespath#large#request.bslash##Photo#");
		image.resize(#request.ImageSize#, 'width');
		image.saveAs("#request.imagespath#medium#request.bslash##Photo#");
		</cfscript>	
		<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Thumbnail--->	
	<cfif IMG_WIDTH GT #request.ThumbSize#>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.imagespath#large#request.bslash##Photo#");
		image.resize(#request.ThumbSize#, 'width');
		image.saveAs("#request.imagespath#small#request.bslash##Photo#");
		</cfscript>
		<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif IMG_WIDTH GT #request.tinySize#>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.imagespath#large#request.bslash##Photo#");
		image.resize(#request.tinySize#, 'width');
		image.saveAs("#request.imagespath#tiny#request.bslash##Photo#");
		</cfscript>
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Read the widths and heights--->
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.imagespath#large#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset iHeight = #IMG_HEIGHT#>
	<cfset iWidth = #IMG_WIDTH#>

	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.imagespath#medium#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>
	<cfset imediumHeight = #IMG_HEIGHT#>
	<cfset imediumWidth = #IMG_WIDTH#>

			
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.imagespath#small#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>

	<cfset iThumbHeight = #IMG_HEIGHT#>
	<cfset iThumbWidth = #IMG_WIDTH#>
	
	<cfscript>
	image = createObject("component","ImageJ");
	image.open("#request.imagespath#tiny#request.bslash##Photo#");
	IMAGE_WIDTH = image.getWidth();
	IMAGE_HEIGHT = image.getHeight();
	</cfscript>

	<cfset itinyHeight = #IMG_HEIGHT#>
	<cfset itinyWidth = #IMG_WIDTH#>
	
</cfif>

<!---
*********************************************************
Process the thumbnails using the cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>

	<!---resize the image and create thumbnails--->
							
	<CFX_Image action = "Read" File="#request.imagespath#large#request.bslash##photo#">
	
	<!---Image--->
	<cfif variables.img_width GT #request.ImageSize#>
				<CFX_IMAGE ACTION="RESIZE"
				FILE="#request.imagespath#large#request.bslash##Photo#"
				WIDTH="#request.ImageSize#"
				OUTPUT="#request.imagespath#medium#request.bslash##Photo#"
				QUALITY="100"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---Thumbnail--->	
	<cfif variables.img_width GT #request.ThumbSize#>
				<CFX_IMAGE ACTION="RESIZE"
				FILE="#request.imagespath#large#request.bslash##Photo#"
				WIDTH="#request.ThumbSize#"
				OUTPUT="#request.imagespath#small#request.bslash##Photo#"
				QUALITY="100">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif variables.img_width GT #request.tinySize#>
				<CFX_IMAGE action="RESIZE"
				FILE="#request.imagespath#large#request.bslash##Photo#"
				WIDTH="#request.tinySize#"
				OUTPUT="#request.imagespath#tiny#request.bslash##Photo#"
				QUALITY="100">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>
	
	<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_Image Action = "Read" File="#request.imagespath#large#request.bslash##photo#">
		<cfset iHeight = #variables.IMG_HEIGHT#>
		<cfset iWidth = #variables.IMG_WIDTH#>
			
	<CFX_Image Action = "Read" File="#request.imagespath#small#request.bslash##photo#">
		<cfset iThumbHeight = #variables.IMG_HEIGHT#>
		<cfset iThumbWidth = #variables.IMG_WIDTH#>

	<CFX_Image Action = "Read" File="#request.imagespath#medium#request.bslash##photo#">
		<cfset imediumHeight = #variables.IMG_HEIGHT#>
		<cfset imediumWidth = #variables.IMG_WIDTH#>
	
	<CFX_Image Action = "Read" File="#request.imagespath#tiny#request.bslash##photo#">
		<cfset itinyHeight = #variables.IMG_HEIGHT#>
		<cfset itinyWidth = #variables.IMG_WIDTH#>
</cfif>

<!---
*********************************************************
Process the thumbnails using the cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>

	<!---resize the image and create thumbnails--->
							
	<CFX_OpenImage action = "READ" File="#request.imagespath#large#request.bslash##photo#">
	
	<!---Image--->
	<cfif img_width GT #request.ImageSize#>
				<cfx_openimage action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				commands="resize #request.ImageSize# 
				write #request.imagespath#medium#request.bslash##Photo#"> 
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
	</cfif>
	<!---Thumbnail--->	
	<cfif img_width GT #request.ThumbSize#>
				<cfx_openimage action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				commands="resize #request.ThumbSize# 
				write #request.imagespath#small#request.bslash##Photo#">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
	</cfif>

	<!---tiny Thumnail--->	
	<cfif img_width GT #request.tinySize#>
				<cfx_openimage action="iml"
				file="#request.imagespath#large#request.bslash##Photo#"
				commands="resize #request.tinySize#
				write #request.imagespath#tiny#request.bslash##Photo#
				">
	<cfelse><!---Just copy it--->
		<cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
	</cfif>
	
		<!---Now read all three so that the height and width can be stored in the db for future use--->
	<CFX_OpenImage Action = "Read" File="#request.imagespath#large#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>

	<CFX_OpenImage Action = "Read" File="#request.imagespath#medium#request.bslash##photo#">
		<cfset imediumHeight = #IMG_HEIGHT#>
		<cfset imediumWidth = #IMG_WIDTH#>
			
	<CFX_OpenImage Action = "Read" File="#request.imagespath#small#request.bslash##photo#">
		<cfset iThumbHeight = #IMG_HEIGHT#>
		<cfset iThumbWidth = #IMG_WIDTH#>
	
	<CFX_OpenImage Action = "Read" File="#request.imagespath#tiny#request.bslash##photo#">
		<cfset itinyHeight = #IMG_HEIGHT#>
		<cfset itinyWidth = #IMG_WIDTH#>
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
   
   <CFX_ImageInfoMX FILE = "#request.imagespath#large#request.bslash##photo#">
   
   <!---Image--->
   <cfif imageinfomx.width GT #request.ImageSize#>
         <cfx_jpegresize action = "resize"
               source = "#request.imagespath#large#request.bslash##photo#"
               filename = "#request.imagespath#medium#request.bslash##photo#"
              quality = "100"
               width = "#request.ImageSize#">
      <cfelse><!---Just copy it--->
         <cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#medium#request.bslash##photo#" nameconflict="overwrite">
   </cfif>
   <!---Thumbnail--->
   <cfif imageinfomx.width GT #request.ThumbSize#>
         <cfx_jpegresize action = "resize"
               source = "#request.imagespath#large#request.bslash##photo#"
               filename = "#request.imagespath#small#request.bslash##photo#"
              quality = "100"
               width = "#request.ThumbSize#">
      <cfelse><!---Just copy it--->
         <cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#small#request.bslash##photo#" nameconflict="overwrite">
   </cfif>
   <!---tiny Thumbnail--->
   <cfif imageinfomx.width GT #request.tinySize#>
         <cfx_jpegresize action = "resize"
               source = "#request.imagespath#large#request.bslash##photo#"
               filename = "#request.imagespath#tiny#request.bslash##photo#"
              quality = "100"
               width = "#request.tinySize#">
      <cfelse><!---Just copy it--->
         <cffile action = "copy" source="#request.imagespath#large#request.bslash##photo#" destination="#request.imagespath#tiny#request.bslash##photo#" nameconflict="overwrite">
   </cfif>
   
      <!---Now read all three so that the height and width can be stored in the db for future use--->
   <CFX_ImageInfoMX FILE="#request.imagespath#large#request.bslash##photo#">
      <cfset iHeight = #imageinfomx.height#>
      <cfset iWidth = #imageinfomx.width#>

   <CFX_ImageInfoMX FILE="#request.imagespath#medium#request.bslash##photo#">
      <cfset imediumHeight = #imageinfomx.height#>
      <cfset imediumWidth = #imageinfomx.width#>
         
   <CFX_ImageInfoMX FILE="#request.imagespath#small#request.bslash##photo#">
      <cfset iThumbHeight = #imageinfomx.height#>
      <cfset iThumbWidth = #imageinfomx.width#>
   
   <CFX_ImageInfoMX FILE="#request.imagespath#tiny#request.bslash##photo#">
      <cfset itinyHeight = #imageinfomx.height#>
      <cfset itinyWidth = #imageinfomx.width#>
</cfif>