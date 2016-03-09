<h3>Check For Updates</h3>
<p>Setting this to yes will query th eupdate server for updates when you first login to your control panel (or whenever you visit the main page).&nbsp; You can set this to NO if you do not want to have it check for updates.&nbsp; If you have this set to Yes, a silent post is sent to the update server (No private information is sent; only the version number and a couple other things that are necessary to see if there is an update).&nbsp; If there is an update it will atempt to run the update script automatically.&nbsp; Updates require that CFZIP is enabled on your server. If you do not CFZIP enabled in Coldfuison 8 then you will need to disable this option (set it to No). </p>
<p><strong>IMPORTANT:</strong> In order for most updates to work, write permissions need to be provided to Coldfusion for the folder CF Shopkart is installed in. If your updates are failing then more then likely write permissions have been disabled. This is usually only a problem on Linux, but it can happen on Windows hosting too. Check with your provider to make sure &lt;cffile&gt; and &lt;cfdirectly&gt; can write to files and folders in your website.</p>
<p><strong>TIP:&nbsp; </strong>You should always keep a backup copy of your database.&nbsp; If any files get overwritten in updates, they are generally backedup to the backups folder in the root of your website.</p>




