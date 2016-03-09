<!---this adds a new form field--->
<!---Error check here.  Send back if an error is generated--->
<cfparam name="itemid" default="">

<!---setup passback default perameters in case the fields don't exist--->
<cfset TheWidth="25">
<cfset TheHeight="5">
<cfset TheCaption="">
<cfset TheCartCaption="">
<cfset ThePrice="0.00">
<cfset TheWeight="0.00">
<cfset TheFieldValue="">
<cfset ThisIsrequired="No">

<!---Now set the values if each form field exists--->
<cfif ISDEFINED('form.Width')>
	<cfset TheWidth="#form.Width#">
</cfif>

<cfif ISDEFINED('form.Height')>
	<cfset TheHeight="#form.Height#">
</cfif>

<cfif ISDEFINED('form.Caption')>
	<cfset TheCaption="#form.Caption#">
</cfif>

<cfif ISDEFINED('form.CartCaption')>
	<cfset TheCartCaption="#form.CartCaption#">
</cfif>

<cfif ISDEFINED('form.Price')>
	<cfset ThePrice="#form.Price#">
</cfif>

<cfif ISDEFINED('form.Weight')>
	<cfset TheWeight="#form.Weight#">
</cfif>

<cfif ISDEFINED('form.FieldValue')>
	<cfset TheFieldValue="#form.FieldValue#">
</cfif>

<cfif ISDEFINED('form.IsRequired')>
	<cfset ThisIsRequired="#form.IsRequired#">
</cfif>

<cfif #TheCaption# IS ''>
	<cfset ErrorLine = 1>
	<cfset ErrorMessage = "ERROR:  Please enter a caption for this form field!"> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #ThePrice# IS ''>
	<cfset ErrorLine = 2>
	<cfset ErrorMessage = "ERROR:  Please enter a Price for this form field!  Enter 0.00 if no price increase."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #TheWeight# IS ''>
	<cfset ErrorLine = 3>
	<cfset ErrorMessage = "ERROR:  Please enter a Weight for this form field!  Enter 0.00 if no weight increase."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif NOT isnumeric(#TheWeight#)>
	<cfset ErrorLine = 3>
	<cfset ErrorMessage = "ERROR:  The Weight must be a numeric value.  Do not enter a symbol."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif NOT isnumeric(#ThePrice#)>
	<cfset ErrorLine = 2>
	<cfset ErrorMessage = "ERROR:  The Price must be a numeric value.  Please do NOT enter any symbols."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #TheHeight# IS "">
	<cfset ErrorLine = 5>
	<cfset ErrorMessage = "ERROR:  You need to specify a height for the form field."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #TheWidth# IS "">
	<cfset ErrorLine = 4>
	<cfset ErrorMessage = "ERROR:  You must specify a width for the form field."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif NOT isnumeric(#TheHeight#)>
	<cfset ErrorLine = 5>
	<cfset ErrorMessage = "ERROR:  The Height must be a numeric value.  Please do NOT enter any symbols."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif NOT isnumeric(#TheWidth#)>
	<cfset ErrorLine = 4>
	<cfset ErrorMessage = "ERROR:  The Width must be a numeric value.  Please do NOT enter any symbols."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #TheHeight# LT 1 OR #TheHeight# GT 40>
	<cfset ErrorLine = 5>
	<cfset ErrorMessage = "ERROR:  The Height of the form field cannot be less than 0 or greater than 40.  Please correct your entry."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<cfif #TheWidth# LT 1 OR #TheWidth# GT 55>
	<cfset ErrorLine = 4>
	<cfset ErrorMessage = "ERROR:  The Width of the form field cannot be less than 1 or greater than 55.  Please modify the value."> 
	<cflocation url = "dooptions.cfm?action=Edit&OptionID=#form.OptionID#&Type=#form.Type#&TheWidth=#TheWidth#&TheHeight=#TheHeight#&TheCaption=#TheCaption#&ThePrice=#ThePrice#&TheWeight=#TheWeight#&TheFieldValue=#TheFieldValue#&ThisIsRequired=#ThisIsRequired#&ErrorLine=#ErrorLine#&ErrorMessage=#ErrorMessage#&itemid=#itemid#">
</cfif>

<!---END ERROR CHECK--->

<!---Recreate the HTML Code--->
<cfset ThisFieldName = #form.OptionID#>

<cfoutput>
<cfif #form.Type# IS 'TextBox'>
	<cfif not form.isrequired IS 'Yes'>
		<cfset MyOptionCode = '<input name="ffield#ThisFieldName#" type="text" value="#Form.FieldValue#" size="#form.width#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.IsRequired#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.Weight#">'>
	</cfif>
	<cfif form.isrequired IS 'Yes'>
		<cfset MyOptionCode = '<input name="ffield#ThisFieldName#" type="text" value="#Form.FieldValue#" size="#form.width#" onchange="this.form.ffield#ThisFieldName#js.value = this.value"><span id="msgffield#ThisFieldName#js" style="visibility: hidden;"><i><font color="FF0000">*</font></i></span><input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.IsRequired#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.Weight#"><input type="hidden" name="ffield#ThisFieldName#js" value="#form.FieldValue#">'>
	</cfif>
</cfif>

<cfif #form.Type# IS 'TextArea'>
<cfif not form.isrequired IS 'Yes'>
	<cfset MyOptionCode = '<TextArea name="ffield#ThisFieldName#" cols="#form.width#" rows="#form.Height#">#Form.FieldValue#</textarea><input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.IsRequired#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.Weight#">'>
</cfif>
<cfif form.isrequired IS 'Yes'>
	<cfset MyOptionCode = '<TextArea name="ffield#ThisFieldName#" cols="#form.width#" rows="#form.Height#" onchange="this.form.ffield#ThisFieldName#js.value = this.value">#Form.FieldValue#</textarea><span id="msgffield#ThisFieldName#js" style="visibility: hidden;"><i><font color="FF0000">*</font></i></span><input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.IsRequired#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.Weight#"><input type="hidden" name="ffield#ThisFieldName#js" value="#form.FieldValue#">'>
</cfif>
</cfif>

<cfif #form.Type# IS 'Hidden'>
<cfset MyOptionCode = '<input name="ffield#ThisFieldName#" type="hidden" value="#form.caption#"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="No"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.weight#">'>
</cfif>

<cfif #form.Type# IS 'CheckBox'>

<cfif #form.FieldValue# IS 'Checked'>
<cfset MyOptionCode = '<input name="ffield#ThisFieldName#" type="CheckBox" value="Yes" CHECKED> #form.caption#<input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="No"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.weight#">'>
</cfif>

<cfif #form.FieldValue# IS 'Unchecked'>
<cfset MyOptionCode = '<input name="ffield#ThisFieldName#" type="CheckBox" value="Yes"> #form.caption#<input name="ffield#ThisFieldName#" type="Hidden" value="#form.price#"><input name="ffield#ThisFieldName#" type="Hidden" value="No"><input name="ffield#ThisFieldName#" type="Hidden" value="#form.weight#">'>
</cfif>
</cfif>
</cfoutput>
<!---Update the database with the new settings--->

<cfquery name = "qupateoptions" datasource="#request.dsn#">
UPDATE options
SET caption='#Thecaption#',
cartcaption='#TheCartCaption#',
Width='#TheWidth#', 
Height='#TheHeight#', 
FieldValue='#TheFieldValue#', 
isrequired='#Thisisrequired#', 
OptionPrice='#ThePrice#', 
OptionWeight='#TheWeight#',
<cfif isdefined('form.optionitemid')>itemid = '#form.optionitemid#',</cfif>
HTMLCode='#MyOptionCode#'
WHERE OptionID = #Form.OptionID#
</cfquery>
<p align="center">The Form Field was Updated!</p>

<p align="center"><a href="dooptions.cfm?action=Editoptions">Edit Another one</a></p>

<cfif NOT form.itemid IS '0'>
	<cflocation url = "dooptions.cfm?action=editoptions&itemid=#form.itemid#">
<cfelse>
	<cflocation url = "dooptions.cfm?action=editalloptions">
</cfif>

