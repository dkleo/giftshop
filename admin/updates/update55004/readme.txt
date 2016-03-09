Update 5.5 004

- Fixed session.productid not found when going to checkout.
- Fixed UPS Shipping calculations script where some variables were not named correctly.
- Fixed bugs in Multiple shipping points and alternate origin shipping address in admin control panel
- Fixed details not showing after product import.
- Updated image import feature when importing on imageurl column to only process 50 at a time to keep server from timing out and possibly crashing due to heavy use of the cfimage tag.
- Fixed a bug in importing categories where the ^ was left in the name of the category and you had to manually delete it from each one.
- Fixed bug when clicking on Clear Gateway settings so that you can now use the shopping cart with just a third party processor.
- Fixed broken image in wishlist widget and broken image in shopping cart widget on Linux.
- Adjusted product detail layout for better formatting as well as a few styles in global.css
- Fixed value for "is item shipped" under settings when adding/editing a product not saving.
- Fixed bug in validation script at checkout where when shipping was not needed it still said the form fields were empty.
- Added a couple more filters for auto-ban features.
- Fixed a couple bugs in the multiple file uploader.
- Fixed a few missing images in the admin on Linux.
- Fixed email item.  It wasn't working.
- Fixed data truncation error in stats logging when logging user agent.
- Fixed qryreviews.cfm error where variable DISP was not found
- Added errorstop.cfm and extra error handling to Application.cfm files for added protection against vulnerabilities.