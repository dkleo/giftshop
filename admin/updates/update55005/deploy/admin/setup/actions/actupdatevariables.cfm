<cfif qryLoginCheck.username IS 'demo'>
	<font color="#FF0000"><strong>This feature is disabled in the demo</strong></font>
	<cfabort>
</cfif>

<!---
<cfif NOT cgi.SERVER_SOFTWARE CONTAINS 'apache'><cfset form.use_urlrewrite = 'No'></cfif>
--->
<cfif #left(server.ColdFusion.ProductVersion, 1)# LT 8><cfset form.checkforupdates = 'No'></cfif>

<CFQUERY Name = 'UpdateUserInfo' Datasource = '#Request.dsn#'>
UPDATE settings_main
SET MaxRecords = '#form.maxrecords#',
ThumbSize = '#form.thumbsize#',
DefaultStockValue = '#form.DefaultStockValue#',
ShowPoweredBy = '#form.ShowPoweredBy#',
ProductLayout = '#form.ProductLayout#',
FeaturedLayout = '#form.FeaturedLayout#',
EnableAutoThumb = '#form.EnableAutoThumb#',
CartThumbnails = '#form.CartThumbNails#',
UnitOfMeasure = '#form.UnitOfMeasure#',
ShowProductID = '#form.ShowProductID#',
EnableInventory = '#form.EnableInventory#',
ShowItemAvailability = '#form.ShowItemAvailability#',
showoutofstockitems = '#form.showoutofstockitems#',
Location = '#form.MyLocation#',
EnableEuro = '#form.EnableEuro#',
CommRate='#form.CommRate#',
CommRate_2='#form.CommRate_2#',
CommType='#form.CommType#',
ImageProcessor = '#form.ImageProcessor#',
ImageSize = '#form.ImageSize#',
LinksDisplay = '#form.LinksDisplay#',
CategoryDisplay = '#form.CategoryDisplay#',
CustomAffiliateCodeStartup = '#form.CustomAffiliateCodeStartup#',
CustomAffiliateCodeCheckout = '#form.CustomAffiliateCodeCheckout#',
sidebysidecols = '#form.sidebysidecols#',
defaultcountry = '#form.defaultcountry#',
showproductreviews = '#form.showproductreviews#',
enablecreateaccount = '#form.enablecreateaccount#',
WebsiteTitle='#form.WebsiteTitle#',
MetaDescription='#form.MetaDescription#',
MetaKeywords='#form.MetaKeywords#',
defaultaction='#form.defaultaction#',
enablecoupons='#form.enablecoupons#',
ShowGiftCardAtCheckout = '#form.ShowGiftCardAtCheckout#',
checkforupdates = '#form.checkforupdates#',
PasswordSite = '#form.PasswordSite#',
SitePassword = '#form.SitePassword#',
EnableWishlists = '#form.EnableWishLists#',
NavMenuType = '#form.NavMenuType#',
OrderNumber_Prefix = '#form.OrderNumber_Prefix#',
checkout_terms = '#form.checkout_terms#',
use_urlrewrite = '#form.use_urlrewrite#',
checkoutstyle = '#form.checkoutstyle#',
stats_enabled = #form.stats_enabled#
</CFQUERY>

<cfquery name = "qryDisableWishlistWidget" datasource="#request.dsn#">
UPDATE widgets SET enabled = '#form.EnableWishLists#'
WHERE widgetname = 'Wish List'
</cfquery>

<CFQUERY Name = 'UpdateUserInfo' Datasource = '#Request.dsn#'>
UPDATE settings_mail
SET mailPassword='#Form.mailPassword#',
UseMailServer='#form.UseMailServer#',
mailUser='#Form.mailuser#',
MailServer = '#form.MailServer#',
UseMailLogin = '#form.UseMailLogin#',
EndOrderSubj = '#form.EndOrderSubj#',
EmailText = '#form.EmailText#',
EndOrderMessage = '#form.EndOrderMessage#'
</CFQUERY>

<h2>Store Settings</h2>
<b>Settings Saved!</b>

<cfset funcpath = replace(request.absolutepath, "/", "", "ALL")>
<cfif NOT len(funcpath) IS 0>
	<cfset funcpath = "#funcpath#.">
</cfif>

<cfinvoke component="#funcpath#admin.functions.dumpsettings" method="WriteSettings" returnvariable="outputmsg">
	<cfinvokeargument name="cfdsn" value="#request.dsn#">
	<cfinvokeargument name="path" value="#request.catalogpath#">
</cfinvoke>