<h2>Widget Boxes <cfoutput><a href = "#request.AdminPath#helpdocs/widget_boxes.cfm" onclick="NewWindow(this.href,'Help','375','450','yes');return false;")><b><img src = "#request.AdminPath#images/help.gif" border="0" /></b></a></cfoutput></h2>
<cfinclude template = "../queries/qrywidgets.cfm">
<p>Widgets are the boxes on the left side of the main page of your store. These widgets provide useful information to your customers. You can choose which of the installed widgets you want to show on your site and which ones you want to hide below. Use the order value number to change the order the widget is displayed.</p>
<p><a href="dosetup.cfm?action=NewCustomWidget">Create a custom widget</a></p>
<form name = "widgetform" action="dosetup.cfm" method="post">
<table width="95%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td width="15%" bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Name</span></td>
    <td width="20%" bgcolor="#0099CC"><span style="font-weight: bold; color: #FFFFFF">Title</span></td>
    <td bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Description</span></td>
    <td width="5%" align="center" bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Order Value</span></td>
    <td width="5%" align="center" bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Position?</span></td>
    <td width="5%" align="center" bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Visible?</span></td>
    <td width="5%" align="center" bgcolor="#0099CC"><span style="color: #FFFFFF; font-weight: bold">Remove?</span></td>
  </tr>
  <cfoutput query = "qryWidgets">
  <tr>
    <td valign="top"><a href="dosetup.cfm?action=editwidget&amp;id=#id#">#widgetname#</a> <input type = "hidden" name="id" value="#id#"></td>
    <td valign="top"><input type="widgettitle" name="widgettitle" value="#widgettitle#" /></td>
    <td valign="top">#widgetdesc#</td>
    <td align="center" valign="top">
    <select name="ordervalue" id="ordervalue">
    <cfloop from = "1" to = "#qryWidgets.recordcount#" index="mycount">
	    <option <cfif ordervalue EQ #mycount#>SELECTED</cfif>>#mycount#</option>
    </cfloop>
    </select>	</td>
    <td align="center" valign="top"><select name="widgetposition" id="widgetposition">
      <option <cfif widgetposition IS 'left'>SELECTED</cfif>>Left</option>
      <option <cfif widgetposition IS 'right'>SELECTED</cfif>>Right</option>
        </select></td>
    <td align="center" valign="top"><select name="isvisible" id="isvisible">
    <option <cfif isvisible NEQ 'No'>SELECTED</cfif>>Yes</option>
    <option <cfif isvisible EQ 'No'>SELECTED</cfif>>No</option>
    </select>    </td>
    <td align="center"><cfif candelete IS 'Yes'><a href = "dosetup.cfm?action=DeleteWidget&id=#id#"><img src="../icons/delete.gif" border="0" alt="Delete this widget" title="Delete this widget" /></a></cfif></td>    
  </tr>
  </cfoutput>
</table>
	<p>
	  <input type="submit" name="button" id="button" value="Save Settings">
	  <input type = "hidden" value="updatewidgets" name="action">
    </p>
</form>








