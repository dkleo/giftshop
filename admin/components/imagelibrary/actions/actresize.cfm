<!---resizes the image depending on what tag they are using--->
<cfset photo = url.filename>

<!---ERROR CHECKS--->
<cfset waserror = 'No'>

<cfif len(form.newwidth) IS 0 AND len(form.newheight) IS 0>
	You must specify either a width or a height
    <cfabort>
</cfif>

<!----values must be numeric or they will be ignored--->
<cfif len(form.newwidth) GT 0>
	<cfif NOT isnumeric(form.newwidth)>
    	Value for width must be numeric.  Enter a number only!
        <cfabort>
    </cfif>
</cfif>

<cfif len(form.newheight) GT 0>
	<cfif NOT isnumeric(form.newheight)>
		Value for height must be numeric.  Enter a number only!
		<cfabort>
    </cfif>
</cfif>

<!---NO ERRORS, THEN RESIZE...--->

<!---*********************************************************
using the cfx_image tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_image'>

	<cfif len('form.newwidth') GT 0>
        <cfx_image action="iml"
        file="#request.Catalogpath#images#request.bslash##photo#"
        commands="resize #form.newwidth#
        sample
        segment
        setjgpdpi 300
        setjpgquality 95
        antialias
        write #request.Catalogpath#images#request.bslash##Photo# 
        ">
	</cfif>
    
    <!---resize by height (if specified) after resizing by width (to maintain aspect ratio)--->
	<cfif len('form.newheight') GT 0>
        <cfx_image action="iml"
        file="#request.Catalogpath#images#request.bslash##photo#"
        commands="resize -1,#form.newheight#
        sample
        segment
        setjgpdpi 300
        setjpgquality 95
        antialias
        write #request.Catalogpath#images#request.bslash##Photo# 
        ">
     </cfif>
    
    <!---get new width and height--->    
	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #IMG_HEIGHT#>
		<cfset iWidth = #IMG_WIDTH#>
</cfif>	
	
<!---
*********************************************************
with the cfx_imagecr3 tag by Efflare
*********************************************************
--->
<cfif request.ImageProcessor IS 'cfx_imagecr3'>
						
	<!---resize by width--->
	<cfif len('form.newwidth') GT 0>
 		<cfx_imagecr3 load="#request.Catalogpath#images#request.bslash##photo#"
		resize="#form.newwidth#x"
		save="#request.Catalogpath#images#request.bslash##Photo#"
		cache="0">
	</cfif>

	<!---resize by height--->
	<cfif len('form.newheight') GT 0>
 		<cfx_imagecr3 load="#request.Catalogpath#images#request.bslash##photo#"
		resize="x#form.newheight#"
		save="#request.Catalogpath#images#request.bslash##Photo#"
		cache="0">
	</cfif>

	<!---read new width and height--->
	<cfx_imagecr3 GetImageInfo = "#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #imagecr.height#>
		<cfset iWidth = #imagecr.width#>	
</cfif>

<!---*********************************************************
the imagej component by benorama.com
*********************************************************
--->
<cfif request.ImageProcessor IS 'ImageJ'>
						
	<!---resize by width--->
    <cfif len(form.newwidth) GT 0>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.Catalogpath#images#request.bslash##photo#");
		image.resize(#form.newwidth#, 'width');
		image.saveAs("#request.Catalogpath#images#request.bslash##Photo#");
	</cfscript>
	</cfif>
    
    <cfif len(form.newheight) GT 0>
	<cfscript>
		image = createObject("component","ImageJ");
		image.open("#request.Catalogpath#images#request.bslash##photo#");
		image.resize(#form.newheight#, 'height');
		image.saveAs("#request.Catalogpath#images#request.bslash##Photo#");
	</cfscript>
	</cfif>    

	<!---Read the widths and heights--->
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
using the cfximage tag by Gafware
*********************************************************
--->
<cfif request.ImageProcessor is 'cfximage'>

	<!---resize by width--->
    <cfif len(form.newwidth) GT 0>
    <CFX_IMAGE ACTION="RESIZE"
    FILE="#request.Catalogpath#images#request.bslash##photo#"
    WIDTH="#form.newwidth#"
    OUTPUT="#request.Catalogpath#images#request.bslash##Photo#"
    QUALITY="100">
	</cfif>

	<!---resize by height--->
    <cfif len(form.newheight) GT 0>
    <CFX_IMAGE ACTION="RESIZE"
    FILE="#request.Catalogpath#images#request.bslash##photo#"
    WIDTH="#form.newheight#"
    OUTPUT="#request.Catalogpath#images#request.bslash##Photo#"
    QUALITY="100">
	</cfif>
    
	<CFX_Image Action = "Read" File="#request.Catalogpath#images#request.bslash##photo#">
		<cfset iHeight = #variables.IMG_HEIGHT#>
		<cfset iWidth = #variables.IMG_WIDTH#>
			
</cfif>

<!---
*********************************************************
using the cfx_openimage tag by Jukka
*********************************************************
--->
<cfif request.ImageProcessor is 'cfx_openimage'>

<!---by width--->

	<cfif len(form.newwidth) GT 0>
        <cfx_openimage action="iml"
        file="#request.Catalogpath#images\#photo#"
        commands="resize #form.newwidth# 
        write #request.Catalogpath#images\#Photo#">
	</cfif>

<!---by height--->

	<cfif len(form.newheight) GT 0>
        <cfx_openimage action="iml"
        file="#request.Catalogpath#images\#photo#"
        commands="resize -1,#form.newheight# 
        write #request.Catalogpath#images\#Photo#">
	</cfif>

	<CFX_OpenImage Action = "Read" File="#request.Catalogpath#images\#photo#">
	<cfset iHeight = #IMG_HEIGHT#>
    <cfset iWidth = #IMG_WIDTH#>
</cfif>

<!---
*********************************************************
using the cfimage built into cf8
*********************************************************
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# GT 7>
	<cfinclude template = "actresize8.cfm">
</cfif>

<!---
*********************************************************
using cfx_jpegresize tag by chestysoft
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

<cflocation url = "doimagelibrary.cfm?action=viewimage&name=#url.name#&filename=#url.filename#&dir=#url.dir#">



















