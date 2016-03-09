<!---Updates the ID number of the items -- The ID Number determines what order the
options appear in.  This will organize your form fields how you want them--->

<cfloop Index="MyCount" From="1" To="#ListLen(form.OptionID)#">
<cfset OptionOrder = "#ListGetAt(form.orderid, MyCount)#">
<cfset ThisOptionID = "#ListGetAt(form.OptionID, MyCount)#">

<cfif isnumeric(OptionOrder)>
<cfquery name = "UpdateOptionIndex" datasource="#request.dsn#">
UPDATE options
SET orderid = #OptionOrder#
WHERE OptionID = #ThisOptionID#
</cfquery>
</cfif>
</cfloop>

<cflocation url = "dooptions.cfm?action=Editalloptions">

