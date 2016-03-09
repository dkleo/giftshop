<cfparam name = "CopyTo" default="0">

<cfinclude template="../queries/qryproducts.cfm">
<cfinclude template="../queries/qryproductoptions.cfm">

<cfset OptionFields = "">
<cfoutput query = "qryProductOptions">
	<cfset OptionFields = listappend(OptionFields, qryProductOptions.optionid)>
</cfoutput>

<table width="90%" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000" height="300">
<cfoutput query = "qryProducts">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td><span class="style3"><span style="font-size: 14pt">Options for #ProductName# - SELECT AN OPTION TO COPY </span></span></td>
      </tr>
      <tr>
        <td>
          <span style="font-weight: bold">Note:  If you want the form field to be a unique form field, be sure to duplicate it before copying it to another product, otherwise whatever changes you make to the option will also be made for the product you copied it from.</span>.		</td>
      </tr>
</cfoutput>
<tr>
<td>
<table width="100%" cellpadding="4" border="0">
<cfset optioncount = 0>
  <cfif NOT #OptionFields# IS 'None' AND NOT #OptionFields# IS ''>
    <cfloop index="MyCount" From="1" To="#ListLen(OptionFields)#">
      <cfset ThisOptionField = ListGetAt(#OptionFields#, #MyCount#)>
	  <cfinclude template = "../queries/qryoptions.cfm">
      <cfoutput query = "qryoptions">
	  	<cfset optioncount = optioncount + 1> 
        <tr> 
          <td width="45%">#Caption# #HTMLCode#</td>
          <td width="55%"><a href = "dooptions.cfm?action=SelectOptionToCopy&CopyTo=#CopyTo#&OptionID=#OptionID#"><img src="icons/check_green.jpg" alt="Select This Option" width="19" height="18" border="0" /></a></td>
        </tr>
      </cfoutput> 
    </cfloop>
  </cfif>
</table>
<cfif optioncount IS 0>
	<p>
	There are no options assigned to this product.  Hit your browser back button to go back and select a item that has option
	form fields.
</cfif>
</td>
</tr>
</table>
