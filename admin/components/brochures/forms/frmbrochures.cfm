<cfinclude template = "../queries/qrybrochures.cfm">
<h2>Brochures</h2>
<p>You can create an interactive flash brochure up to 10 pages. The brochures you create here cannot be assigned to products. You can paste links to it anywhere in your website. To create a brochure for a product, go to the catalog editor.</p>
<p>+ <a href="index.cfm?action=new">Create a Brochure</a> </p>
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
    <td><a href="index.cfm?action=Delete&id=#id#">Delete</a></td>
  </tr>
</cfoutput>
</table>
<p>&nbsp;</p>




















