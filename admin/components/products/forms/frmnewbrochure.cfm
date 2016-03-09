<h2>New Brochure</h2>
<p>To create a new brochure for this product select some images to upload. Image sizes you upload should be around 800x600 so that when they zoom in they will be able to read the page.</p>
<form <cfoutput>action="doproducts.cfm?action=addbrochure&itemid=#url.itemid#"</cfoutput> method="post" enctype="multipart/form-data" name="form1">
  <table width="75%" border="0" cellspacing="0" cellpadding="4">
    <tr>
      <td><b>Page 1</b></td>
      <td><input name="page1" type="file" id="page1" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 2 </b></td>
      <td><input name="page2" type="file" id="page2" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 3 </b></td>
      <td><input name="page3" type="file" id="page3" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 4 </b></td>
      <td><input name="page4" type="file" id="page4" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 5 </b></td>
      <td><input name="page5" type="file" id="page5" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 6 </b></td>
      <td><input name="page6" type="file" id="page6" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 7 </b></td>
      <td><input name="page7" type="file" id="page7" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 8 </b></td>
      <td><input name="page8" type="file" id="page8" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 9 </b></td>
      <td><input name="page9" type="file" id="page9" size="35"></td>
    </tr>
    <tr>
      <td><b>Page 10 </b></td>
      <td><input name="page10" type="file" id="page10" size="35"></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" name="Submit" value="Create New Brochure"></td>
    </tr>
  </table>
</form>
<p>&nbsp; </p>


















