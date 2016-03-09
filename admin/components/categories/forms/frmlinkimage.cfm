<h2>Link Image</h2>
<form name="form9" enctype="multipart/form-data" method="post" action="index.cfm">
  <p>Please note that your images will <strong>not</strong> be resized when you upload them here.</p>
  <p>
    Image: 
    <input name="FileContents" type="file" id="filefield" size="40">
    <cfoutput><br />
      <br />
      Mouse Over Image (optional): 
        <input name="FileContents2" type="file" id="FileContents" size="40" />
        <br />
        <br />
        <input type="Hidden" value="#url.CategoryID#" Name="CategoryID"></cfoutput>
    <input type="hidden" name="action" value="uploadlinkimage">
    <input type="submit" name="Submit4" value="Upload Image">
  </p>
  <p><a href="index.cfm">Go back</a></p>
</form>





















