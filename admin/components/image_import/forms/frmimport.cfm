<h2>Image Import Wizard
</h2>
<p>If you have a large number of images and you don't want to upload each one individually, you can upload them to your photos/large/ folder and use this wizard to automatically generate thumbnails and assign them to products. It is important that you upload all your images to the photos/large/ folder or the wizard will not be able to find the images.</p>
<form name="form1" method="post" action="index.cfm?action=import_step_2">
  <p>Choose a Method of Import:</p>
  <p>
    <input name="import_method" type="radio" id="radio" value="imageurl" checked> 
    <strong>Use ImageURL column </strong>- If you have imported products already and the imageURL column contains image names, you can use this method to locate each image and automatically generate thumbnails for it.</p>
  <p>
    <input type="radio" name="import_method" id="radio2" value="sku">
    <strong>Match item sku to image file</strong> - If your images are named after the item sku, this method will attempt to locate all images containing the item sku and automatically generate thumbnails for each one it finds.</p>
  <p>
    <input type="radio" name="import_method" id="radio3" value="productname">
    <strong>Match item name to image file</strong> - If your images are named after the items, this method will attempt to locate all images containing the item name and automatically generate thumbnails for each one it finds.</p>
  <p>
    <input type="submit" name="button" id="button" value="Continue Importing Images ---&gt;">
  </p>
</form>



















