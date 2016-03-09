<cftry>
<link href="../../../controlpanel.css" rel="stylesheet" type="text/css"> 
<cfif NOT ISDEFINED ('url.action') AND NOT ISDEFINED('form.action')>
	<!---FOR BACKWORDS COMPATABILITY WE WILL INCLUDE THE OLD UPLOAD FOR STORES THAT WERE PUT IN 
	PRIOR TO THE MULTIPLE IMAGE FEATURE--->
	<cfinclude template = "forms/frmuploadimages.cfm">
</cfif>
    
<cfif ISDEFINED('url.action')>
    <cfif url.action IS 'search'>
        <cfinclude template = "forms/frmproductimages.cfm">
    </cfif>
    <cfif url.action IS 'productimages'>
        <cfinclude template = "forms/frmproductimages.cfm">
    </cfif>
    <cfif url.action IS 'delete'>
        <cfinclude template = "actions/actdeleteimage.cfm">
    </cfif>
    <cfif url.action IS 'moveleft'>
        <cfinclude template = "actions/actmoveimageleft.cfm">
    </cfif>
    <cfif url.action IS 'moveright'>
        <cfinclude template = "actions/actmoveimageright.cfm">
    </cfif> 
    <cfif url.action IS 'multipleupload'>
        <cfinclude template = "forms/frmuploadimages.cfm">
    </cfif>
    <cfif url.action IS 'uploadimages'>
        <cfinclude template = "actions/actuploadimages.cfm">
    </cfif>
    <cfif url.action IS 'selectimages'>
        <cfinclude template = "forms/frmassignimages.cfm">
    </cfif>
    <cfif url.action IS 'setimages'>
        <cfinclude template = "actions/actsetimages.cfm">
    </cfif>   
    <cfif url.action IS 'browse'>
        <cfinclude template = "forms/frmbrowse.cfm">
    </cfif> 
    <cfif url.action IS 'makethumbs'>
        <cfinclude template = "actions/actresizeimages.cfm">
    </cfif> 
    <cfif url.action IS 'multiProdupload'>
        <cfinclude template = "forms/frmmultiimages.cfm">
    </cfif> 
</cfif>

<cfif ISDEFINED('form.action')>
	<cfif form.action IS 'Upload'>
    <cfinclude template="actions/actuploadpictures.cfm">
    </cfif>    
    <cfif form.action IS 'UploadProductPic'>
    <cfinclude template="actions/actuploadproductimage.cfm">
    </cfif>    
    <cfif form.action IS 'Search'>
    <cfinclude template="actions/dspsearchresults.cfm">
    </cfif>
</cfif>

<cfcatch type = "any">
	<cfinclude template = "../../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>