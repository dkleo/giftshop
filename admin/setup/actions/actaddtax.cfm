
<!---Check to make sure the user didn't enter more than 1 in there...if they did, divide by 100--->
<cfif form.TaxRate GT 1.00>
	<cfset form.TaxRate = form.TaxRate / 100>
</cfif>

<cfif #form.TaxRate# is '' OR #form.TaxRate# IS '.00'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You have to supply a tax rate for this area.  You cannot set the tax rate to null or 
zero.  Please specify an amount in decimal format (i.e. 7% = .07) 
<a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.TaxRate# CONTAINS '%'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You have to supply a tax rate in decimal format(i.e. 7% = .07) 
<a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.Country# IS ''>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You did not specify a country! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif #form.Country# IS 'Select Country'>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  You need to specify a country! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif form.region is 'Other' AND form.OtherRegion IS ''>
<font face="Verdana, Arial, Helvetica, sans-serif" size="2">
ERROR:  If you choose OTHER you must specify an alternate state or region not in the list! <a href="javascript:history.go(-1);">Click here</a> to go back.</font>
<cfabort>
</cfif>

<cfif NOT #form.Region# IS 'Other'>
<cfquery name = "AddTax" datasource = "#request.dsn#">
INSERT INTO taxes
(Region, Country, ZipCode, TaxRate)
VALUES
('#form.Region#', '#form.Country#', '#form.ZipCode#', '#form.TaxRate#')
</cfquery>
</cfif>

<cfif #form.Region# IS 'Other'>
<cfquery name = "AddTax" datasource = "#request.dsn#">
INSERT INTO taxes
(Region, Country, TaxRate)
VALUES
('#form.OtherRegion#', '#form.Country#', '#form.ZipCode#', '#form.TaxRate#')
</cfquery>
</cfif>

<cflocation URL = "dosetup.cfm?action=taxes">







