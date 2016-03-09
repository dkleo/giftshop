<cftry>

<cfparam name="action" default="">

<cfswitch expression="#action#">

    <cfcase value = "New">
        <cfinclude template = "forms/frmaddcouponcode.cfm">
    </cfcase>
    <cfcase value = "Edit">
        <cfinclude template = "forms/frmeditcouponcode.cfm">
    </cfcase>
    <cfcase value = "Delete">
        <cfinclude template = "actions/actdeletecouponcode.cfm">
    </cfcase>
    <cfcase value = "Add">
        <cfinclude template = "actions/actaddcouponcode.cfm">
    </cfcase>
    <cfcase value = "Update">
        <cfinclude template = "actions/actupdatecouponcode.cfm">
    </cfcase>
    <cfdefaultcase>
         <cfinclude template = "forms/frmcouponcodes.cfm">
    </cfdefaultcase>

</cfswitch>      

<cfcatch type = "any">
	<cfinclude template = "../../errorprocess.cfm">
    <cfabort>
</cfcatch>

</cftry>