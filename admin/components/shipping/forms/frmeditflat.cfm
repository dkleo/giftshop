<cfinclude template = "../queries/qrycompanyinfo.cfm">

<cfoutput Query="qryCompanyInfo">
<cfset TheInStateShipRate = #InStateShipRate#>
<cfset TheOutStateShipRate = #OutStateShipRate#>
</cfoutput>

<form method="POST" Action="doshipping.cfm">
<table border="0" cellpadding="0" cellspacing="0" width="95%" align="center">
<cfoutput>
	<tr>
	    <td width="24%">$
<input type="text" name="InStateShipRate" size="6" value="#TheInStateShipRate#"></td>
        <td width="76%">Interstate charge</td>
    </tr>
    <tr>
        <td width="24%">$
<input type="text" name="OutStateShipRate" size="6" value="#TheOutStateShipRate#"></td>
        <td width="76%">Out-of-state charge</td>
    </tr>
</cfoutput>
</table>
  <div align="center">
    <input type="hidden" Name="Action" Value="UpdateFlat">
    <input type="Submit" Name="S1" Value="Update Flat Rate">
  </div>
</form>
