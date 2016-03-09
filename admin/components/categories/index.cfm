<cftry>

<cfparam name="action" default="">

<cfswitch expression="#action#">
	<cfcase value="newcategory">
	  	<cfinclude template = "forms/frmNewCategory.cfm">
    </cfcase>
	<cfcase value="delete">
	  	<cfinclude template = "actions/actdelete.cfm">    
    </cfcase>
	<cfcase value="removepic">
	  	<cfinclude template = "actions/actremovepic.cfm">   
    </cfcase>
	<cfcase value="changesubcategory">
	  	<cfinclude template = 'forms/frmsetsub.cfm'>   
    </cfcase>
	<cfcase value="changeorder">
	  	<cfinclude template = 'forms/frmchangeorder.cfm'>   
    </cfcase>
	<cfcase value="setimage">
	  	<cfinclude template = 'forms/frmimage.cfm'>    
    </cfcase>
	<cfcase value="editdetails">
 	  	<cfinclude template = "forms/frmdetails.cfm">   
    </cfcase>
	<cfcase value="updateorder">
	  	<cfinclude template = "actions/actSaveReorder.cfm">   
    </cfcase>
	<cfcase value="setlinkimage">
	  	<cfinclude template = "forms/frmlinkimage.cfm">   
    </cfcase>
	<cfcase value="removelinkpic">
	  	<cfinclude template = "actions/actremovelinkpic.cfm">   
    </cfcase>
	<cfcase value="add">
        <cfinclude template = "actions/actadd.cfm">
    </cfcase>
	<cfcase value="updatecategories">
		<cfinclude template = "actions/actupdatecategories.cfm">
    </cfcase>
	<cfcase value="updatesub">
		<cfinclude template = "actions/actupdatesub.cfm">    
    </cfcase>
	<cfcase value="upload">
    	<cfinclude template = "actions/actupload.cfm">
    </cfcase>
	<cfcase value="uploadlinkimage">
    	<cfinclude template = "actions/actuploadlinkimage.cfm">
    </cfcase>
	<cfcase value="updatedetails">
    	<cfinclude template = "actions/actupdatedetails.cfm">
    </cfcase>
    <cfdefaultcase>
    	<cfinclude template = "forms/frmcategories.cfm">
    </cfdefaultcase>
</cfswitch>
 
<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>

      	  











