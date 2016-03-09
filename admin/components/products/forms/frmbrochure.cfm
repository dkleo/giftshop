<cfinclude template = "../queries/qrybrochures.cfm">
<h2>Brochures</h2>
<cfif qryBrochures.recordcount IS 0>
<p>+ <cfoutput><a href="doproducts.cfm?action=NewBrochure&itemid=#url.itemid#">Create a Brochure for this product</a></cfoutput></p>
</cfif>
<cfif qryBrochures.recordcount GT 0>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td bgcolor="#003399"><b><font color="#FFFFFF">Name</font></b></td>
    <td bgcolor="#003399"><b><font color="#FFFFFF">URL To this Brochure (Use this to create a link to it) </font></b></td>
    <td bgcolor="#003399"><b><font color="#FFFFFF">Options</font></b></td>
  </tr>
<cfoutput query = "qryBrochures">
  <tr>
    <td>#Name#</td>
    <td><a href = "#request.HomeURL#/brochures/#name#/brochure.html" target="_blank">#request.HomeURL#brochures/#name#/brochure.html</td>
    <td><a href="doproducts.cfm?action=DeleteBrochure&id=#id#">Delete</a></td>
  </tr>
</cfoutput>
</table>
</cfif>















