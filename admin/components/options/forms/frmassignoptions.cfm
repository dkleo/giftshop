<cfparam name = "itemid" default="0">

<cfinclude template="../queries/qryproducts.cfm">
<cfinclude template="../queries/qryproductoptions.cfm">
<cfinclude template="../queries/qryoptions.cfm">

<STYLE>
<!--
  .selecttr { background-color: #FFFFFF; cursor: pointer;}
  .initial { background-color: #000000; color:#000000; cursor: pointer; }
  .normal { background-color: #FFFFFF; cursor: pointer; }
  .highlight { background-color: #CCCCCC; cursor: pointer; }
  .delcheckbox {cursor: None;} 
//.style1 {font-size: 14px}
.style2 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>

<table width="90%" border="4" align="center" cellpadding="4" cellspacing="0" bordercolor="#000000" height="300">
<cfoutput query = "qryProducts">
  <tr>
    <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="4">
      <tr>
        <td><span class="style3"><span style="font-size: 14pt">Options for #ProductName#</span></span></td>
      </tr>
      <tr>
        <td><hr align="center" width="100%" size="2" />          
        <a href="#request.AdminPath#/components/options/dooptions.cfm?action=adddropdown&newdropdown=yes&itemid=#ItemID#"><img src="../../icons/listbox.gif" alt="Add a List Menu" title="Add a List Menu" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=addformfield&amp;type=textbox&amp;itemid=#ItemID#"><img src="../../icons/textboxes.gif" alt="Add a Text Box" title="Add a Text Box" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=addformfield&type=checkbox&itemid=#ItemID#"><img src="../../icons/checkboxes.gif" alt="Add Checkbox" title="Add Checkbox" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=addformfield&type=textarea&itemid=#ItemID#"><img src="../../icons/textarea.gif" alt="Add a Multi-Line Textbox" title = "Add a Multi-Line Textbox" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=addradiolist&newradiolist=yes&itemid=#ItemID#"><img src="../../icons/radiobutton.gif" alt="Add a Radio List" title="Add a Radio List" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=addformfield&type=hidden&itemid=#ItemID#"><img src="../../icons/hiddenfield.gif" alt="Add A Hidden Field" title="Add A Hidden Field" width="16" height="16" border="0" /></a> <a href="#request.AdminPath#/components/options/dooptions.cfm?action=copyoption&amp;copyto=#ItemID#"><img src="../../icons/copy.gif" alt="Copy an option from another product" title="Copy an option from another product" width="16" height="16" border="0" /></a><br>
		<hr align="center" width="100%" size="2">
		</td>
      </tr>
</cfoutput>
<tr>
<td>

<table width="650" cellpadding="8" cellspacing="0" border="0">
<cfset optioncount = 0>

<cfif qryProductOptions.recordcount GT 0>

	<cfloop query="qryProductOptions">  	

	  <cfquery name = "qryThisOption" dbtype="query">
		SELECT * FROM qryOptions
		WHERE optionid = #qryProductOptions.optionid#
       </cfquery>
	 <tr>
     	<td width="5%" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">Order </span></td>
        <td bgcolor="#000000"></td>
        <td width="10%" bgcolor="#000000"><span style="color: #FFFFFF; font-weight: bold">ID</span></td>
        <td width="20%" bgcolor="#000000"></td>
    </tr>          	
    <form name="UpdateOrderForm" method="post" <cfoutput>action="dooptions.cfm?action=UpdateOrder2&itemid=#qryProducts.itemid#"</cfoutput>>
         <cfoutput query = "qryThisOption">
		  <cfset optioncount = optioncount + 1> 
            <tr class="selecttr" onMouseOver="this.className='highlight'" onMouseOut="this.className='normal'">
              <td valign="middle"><input type = "hidden" value="#optionid#" name = "optionID"><input type = "text" name = "OrderID" value = "#orderid#" size="3"></td> 
              <td><cfif NOT FieldType IS 'Radio' AND NOT FieldType IS 'Checkbox'>#Caption#</cfif> #HTMLCode#</td>
              <td width="5%">#optionid#</td>
              <td><div align="center"><a href="dooptions.cfm?action=duplicate&amp;optionid=#optionid#&ItemID=#qryProducts.Itemid#"><img src="../../icons/duplicate2.gif" alt="Duplicate This Option" title="Duplicate This Option" width="16" height="16" border="0" /></a> <a href="dooptions.cfm?action=Edit&amp;OptionID=#OptionID#&amp;Type=#FieldType#&amp;itemid=#qryProducts.Itemid#"><img src="../../icons/edit.gif" alt="Edit This Option" title="Edit This Option" width="16" height="16" border="0" /></a> <a href="dooptions.cfm?action=RemoveOption&amp;OptionID=#OptionID#&amp;itemid=#qryProducts.ItemID#"><img src="../../icons/delete.gif" alt="Remove this option (DOES NOT DELETE IT)" title="Remove this option (DOES NOT DELETE IT)" width="16" height="16" border="0" /></a><a href="javascript:PopupPic('#OptionID#')"><img src="../../icons/search.gif" alt="View HTML for this option" title="View HTML for this option" width="16" height="16" border="0" /></a></div></td>
            </tr>
          </cfoutput> 
</cfloop>

<tr>
<td colspan = "4" align="left"><input type = "submit" value = "Save Order" name="submit"></td>
</tr>
</form>
</cfif>
</table>
<cfif qryProductOptions.recordcount IS 0>
	<p>
	There are no options assigned to this product.  Hit your browser back button to go back and select a item that has option
	form fields.
</cfif>
</td>
</tr>
</table>

