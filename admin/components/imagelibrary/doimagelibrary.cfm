<cftry>
<link href="../../controlpanel.css" rel="stylesheet" type="text/css" />
<cfparam name = "action" default="">

<cfswitch expression="#action#">
	<cfdefaultcase>
		<cfinclude template = "forms/frmimages.cfm">
    </cfdefaultcase>
    
    <cfcase value="upload">
    	<cfinclude template = "actions/actuploadimage.cfm">
	</cfcase>
	<cfcase value="viewimage">
    	<cfinclude template = "forms/frmviewimage.cfm">
	</cfcase>
    <cfcase value="browse">
    	<cfinclude template = "forms/frmbrowse.cfm">
    </cfcase>
    <cfcase value="DELETE">
    	<cfinclude template = "actions/actdelete.cfm">
    </cfcase>    
</cfswitch>

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>









