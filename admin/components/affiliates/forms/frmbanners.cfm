<h2>Affiliate Banners</h2>
<cfinclude template="../queries/qrybanners.cfm">

<form action="index.cfm?action=uploadbanner" method="post" enctype="multipart/form-data" name="form1">
Upload New Banner: 
    <input name="ImageFile" type="file" id="ImageFile" size="45">
    <input type="submit" name="Submit" value="Upload Banner">
</form>
<table width="99%" border="0" align="center" cellpadding="2" cellspacing="0">
  <tr bgcolor="3333CC"> 
    <td width="20%"><font color="FFFFFF"><b>&nbsp;&nbsp;Image</b></font></td>
    <td width="40%"><div align="center"><font color="FFFFFF"><strong>Sample Code</strong></font></div></td>
    <td width="10%"><div align="center"><font color="FFFFFF"><b>Action</b></font></div></td>
  </tr>
  <cfoutput query = "qryImages"> 
    <tr <cfif qryImages.currentrow MOD 2>bgcolor="##CCCCCC"</cfif>>
      <td colspan = "3" align="center"><img src="#request.homeurl#images/banners/#location#" border="0"></td>
    </tr>
    <tr <cfif qryImages.currentrow MOD 2>bgcolor="##CCCCCC"</cfif>> 
      <td align="center" colspan="2">
        Sample code:<br />
		<textarea name="textarea" cols="150" rows="8"><a href = "#request.HomeURL#?affilID=1010000001" target="_blank"><img src = "#request.HomeURL#images/banners/#location#" border="0" /></a></textarea>	  </td>
      <td align="center"><a href="index.cfm?action=deletebanner&bannerid=#banner_id#">Delete</a></td>
    </tr>
  </cfoutput> 
</table>












