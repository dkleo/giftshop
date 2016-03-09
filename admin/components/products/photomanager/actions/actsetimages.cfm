<!---This file uploads pictures to multiple items--->
<cfinclude template = "../../queries/qrycompanyinfo.cfm">

<cfset request.imagespath = '#request.catalogpath##request.bslash#photos#request.bslash#'>

<!---If the ItemID form field is not present then there is nothing to upload--->
<cfif ISDEFINED('form.ItemID')>

  	<!---Loop through all the present items--->
		<cfloop index="MyCount" From="1" To="#ListLen(form.ItemID)#">

			<!---Set ThisFormID equal to the current ItemID in the list we are looping over--->
			<cfset ThisFormID = "#ListGetAt(form.ItemID, MyCount)#">
			<!---Now check to see if the form field for this item is present and filled in.  If so, then resize and assign the image--->
			<cfset MyFormName = 'form.prod_image' & '#ThisFormID#'>
			
			<cfif ISDEFINED(#Evaluate('MyFormName')#)>	
				<cfif NOT #Evaluate(MyFormName)# IS ''>

				<cfset ThisItemID = #ThisFormID#>
				<cfinclude template = "../../queries/qryitemimages.cfm">
				
				<!---Get the next ordervalue for this image--->
				<cfset LastOrderValue = 0>
				<cfoutput query = "qry_Images">
					<cfset LastOrderValue = #OrderValue#>
				</cfoutput>
				
				<cfset NextOrderValue = LastOrderValue + 1>

					<cfset photo = #evaluate(MyFormName)#>
					<cfset thumb = #evaluate(MyFormName)#>
					
					<!---Read the images--->
					<cfinclude template = "actreadimage.cfm">
						
					<!---Insert the database reference for this one---->
					<cfquery name= "qAddFile" datasource="#request.dsn#">
					INSERT INTO products_images
					(iFileName, ItemID, OrderValue, iHeight, iWidth, thumbHeight, thumbWidth, tinyHeight, tinyWidth, mediumheight, mediumwidth)
					VALUES
					('#Photo#', '#ThisFormID#', #NextOrderValue#, #iHeight#, #iWidth#, #ithumbHeight#, #ithumbWidth#, #itinyHeight#, #itinyWidth#, '#imediumheight#', '#imediumwidth#')
					</cfquery>
				</cfif>
			</cfif>
		</cfloop>
	</cfif>
	
<cflocation url = "dophotomanager.cfm?action=selectimages">