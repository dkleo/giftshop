<cfparam name = "itemid" default="0">
<cfparam name = "wasdoing" default="images">
<cfparam name = "sortoption" default="ASC">

<cfif itemid IS 0>
	ItemID Invalid.
    <cfabort>
</cfif>

<cfquery name = "qryProduct" datasource="#request.dsn#">
SELECT * FROM products
WHERE itemid = #itemid#
</cfquery>

<cfoutput>
<link href="#request.homeurl#admin/css/default.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="#request.homeURL#admin/swfupload.js"></script>
<script type="text/javascript" src="#request.homeurl#admin/js/swfupload.queue.js"></script>
<script type="text/javascript" src="#request.homeurl#admin/js/fileprogress.js"></script>
<script type="text/javascript" src="#request.homeurl#admin/js/handlers.js"></script>
</cfoutput>

<cfoutput>
<script type="text/javascript">
	var swfu;
	window.onload = function() {
		var settings = {
			flash_url : "#request.homeurl#admin/swfupload.swf",
		upload_url:"#request.homeurl#admin/uploader/uploadimages.cfm?itemid=#itemid#&user=#cookie.admin_username#&pass=#cookie.admin_password#",
			post_params: {"itemid" : "1"},
			file_size_limit : "10 MB",
			file_types : "*.gif;*.jpg;*.jpeg;*.png",
			file_types_description : "All Files",
			file_upload_limit : 100,
			file_queue_limit : 0,
			custom_settings : {
				progressTarget : "fsUploadProgress",
				cancelButtonId : "btnCancel"
			},
			debug: false,

			// Button settings
			button_image_url: "#request.homeurl#/images/defaults/UploadButton.png",
			button_width: "65",
			button_height: "29",
			button_placeholder_id: "spanButtonPlaceHolder",
			button_text: 'Upload',
			button_text_style: ".theFont { font-size: 16; }",
			button_text_left_padding: 12,
			button_text_top_padding: 3,
			
			// The event handler functions are defined in handlers.js
			file_queued_handler : fileQueued,
			file_queue_error_handler : fileQueueError,
			file_dialog_complete_handler : fileDialogComplete,
			upload_start_handler : uploadStart,
			upload_progress_handler : uploadProgress,
			upload_error_handler : uploadError,
			upload_success_handler : uploadSuccess,
			upload_complete_handler : uploadComplete,
			queue_complete_handler : queueComplete	// Queue plugin event
		};

		swfu = new SWFUpload(settings);
	 };
</script>

</cfoutput>
<cfoutput>
<form id="form1" action="" method="post" enctype="multipart/form-data">
  <h2><strong>Upload Images For #qryProduct.productname# (#qryProduct.sku#)</strong></h2>
  <div class="fieldset flash" id="fsUploadProgress">
<span class="legend">Upload Queue</span>			</div>
<div id="divStatus">0 Files Uploaded</div>
<div>
	<span id="spanButtonPlaceHolder"></span>
	<input id="btnCancel" type="button" value="Cancel All Uploads" onClick="swfu.cancelQueue();" disabled="disabled" style="margin-left: 2px; font-size: 8pt; height: 29px;" />
</div>
</form>
<p>Click the Upload button to select files from your computer. The maximum size of the image file can be 10MB. You must wait until all files are uploaded before leaving<br>
this page. If you leave this page, your uploads will be aborted.</p>
<p><a href="dophotomanager.cfm?action=productimages&ItemID=#itemid#&sortoption=#sortoption#&wasdoing=#wasdoing#">Go Back to Product Images</a></p>
</cfoutput>































