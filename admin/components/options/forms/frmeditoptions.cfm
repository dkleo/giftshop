<!---Query the options table.  If there are none available, then do not proceed--->
<cfinclude template = "../queries/qryoptions.cfm">
<cfinclude template = "../queries/qryproducts.cfm">

<cfparam name = "FieldType" default="All">

<!---Now query the products table and get the list of options currently assigned 
	 to this item. If the option field is in the list then check the box next to 
	 that option to indicate it is currently assigned--->
	 
<cfset OptionsList = 'None'>
<cfoutput query = "qryProducts">
<cfset OptionsList = #FormFields#>
<cfset CategoryList = #Category#>
</cfoutput>

<form name="form1" method="post" action="dooptions.cfm?action=EditAllOptions">
<table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
  <tr>
    <td colspan="4" >
      <select name="FieldType">
        <option value="All">View All</option>
        <option value="DropDown" <cfif FieldType IS 'DropDown'>SELECTED</cfif>>Only Drop Downs</option>
        <option value="Radio" <cfif FieldType IS 'Radio'>SELECTED</cfif>>Only Radio Buttons</option>
        <option value="TextBox" <cfif FieldType IS 'TextBox'>SELECTED</cfif>>Only Input Boxes</option>
        <option value="TextArea" <cfif FieldType IS 'TextArea'>SELECTED</cfif>>Only Multi-Line Textboxes</option>
        <option value="Hidden" <cfif FieldType IS 'Hidden'>SELECTED</cfif>>Only  Hidden Fields</option>
        <option value="Checkbox" <cfif FieldType IS 'Checkbox'>SELECTED</cfif>>Only  Checkboxes</option>
      </select>
      <input name="Refresh" type="submit" id="Refresh" value="Refresh" />
	</td>
    </tr>
</table>
</form>

<table width="100%" border="0" align="center" cellpadding="4" cellspacing="0">
<form name="form1" method="post" action="dooptions.cfm">
  <tr bgcolor="#000099">
    <td width="11%" ><center>
      <font color="#FFFFFF"><b>ID</b></font>
    </center>    </td> 
    <td width="11%" ><font color="#FFFFFF"><b> Order Value</b></font></td>
      <td width="16%" ><font color="#FFFFFF"><b> Caption</b></font></td>
    <td width="31%"  align="left"><font color="#FFFFFF"><b> Preview</b></font></td>
    <td width="34%" > <p align="center"> <font color="#FFFFFF"><b>Action</b></font></td>
  </tr>

  <cfset rowcount = 0>
  <cfoutput query = "qryOptions"> 
    <cfset IsChecked = 'No'>
    <!---Now loop through the list and see if this one is in it--->
    <cfif NOT #OptionsList# IS 'None'>
      <cfloop index = "OptionListCount" From="1" To="#ListLen(OptionsList)#">
        <cfset ThisOptionNumber = ListGetAt(#OptionsList#, #OptionListCount#)>
        <cfif #ThisOptionNumber# IS  #OptionID#>
          <cfset IsChecked = 'Yes'>
        </cfif>
      </cfloop>
    </cfif>
	<cfset rowcount = rowcount + 1>
    <tr <cfif rowcount IS 2>bgcolor="##CCCCCC"</cfif>>
      <td width="11%"><center>
        #optionID#
      </center>      </td> 
      <td width="11%"> 
          <input type = "Hidden" value = "#OptionID#" Name = "OptionID">
          <input type="text" name="orderid" size="4" value="#orderid#">		</td>
      <td width="16%" > <div align="left"> #Caption#</div></td>
      <td width="31%"  align="left"><cfif NOT FieldType IS 'hidden'>#HTMLCode#</cfif>
	  	<cfif FieldType IS 'hidden'><font color="##FF0000">Hidden Field</font></cfif></td>
        <td width="34%" > <div align="center"><a href="dooptions.cfm?action=Delete&amp;OptionID=#OptionID#&amp;ItemID=0"> 
            Delete</a>&nbsp;&nbsp; |&nbsp;&nbsp; <a href="dooptions.cfm?action=Edit&amp;OptionID=#OptionID#&amp;Type=#FieldType#&amp;ItemID=0"> 
            Edit</a> | <a href="javascript:PopupPic('#OptionID#')">HTML</a></div></td>
    </tr>
	<cfif rowcount IS 2><cfset rowcount = 0></cfif>
</cfoutput>
	<tr>
	  <td><input type = "hidden" value = "UpdateOrder" name = "Action" />
	    <input type = "submit" value="Update" name="SubmitButton" />    
	  <td>
  	</form>
	<tr>
	  <td>    
  </td> 
</table> 

