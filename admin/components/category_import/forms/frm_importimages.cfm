<b>Import Images</b><strong> with CFDIRECTORY</strong>
<p>
Use this utlility to import images into your file manager that you have uploaded via FTP.  You will then be able to use the images in the HTML editor and/or assign
images to products.  You need to have CFDIRECTORY (or installed equivelant) enabled on the server in 
order for this to work.
NOTE:  Upload your images to the #request.bslash#USERFILES#request.bslash#IMAGES folder!
<p>
<cfoutput>
<a href = "index.cfm?action=products.images.RunImageImport">Continue Importing Images using CFDirectory</a></cfoutput>
<p><strong>Import Images CSV file</strong>
<p>If you have a CSV file of all the image file names, you can import the filenames into your database using the form below. Copy and paste or type the names of the image files into the box below (each one needs to be seperated with a comma!). An entry will be made in the User_Files table for each image, but size information will not be available for each file. NOTE:  Upload your images to the #request.bslash#USERFILES#request.bslash#IMAGES folder!
<form id="form1" name="form1" method="post" action="index.cfm?action=images_importcsv">
  <p>
    <textarea name="csvimport" cols="50" rows="10" id="csvimport"></textarea>
  </p>
  <p>
    <input type="submit" name="Submit" value="Import Images Filenames" />
</p>
</form>
<p>




















