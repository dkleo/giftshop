<!---Generates a gift code for a specific customer--->

<style type="text/css">
<!--
.giftcode {
	font-size: 18px;
	font-weight: bold;
}
-->
</style>

<cfquery name = "qryCheck" datasource="#request.dsn#">
SELECT * FROM giftcards
WHERE OrderID = '#OrderNumber#'
</cfquery>

<cfif qryCheck.recordcount IS 0>
<p>&nbsp;</p>
<center><strong>You have purchased one or more gift codes on this order.  They are listed below:</strong></center>
<p>&nbsp;</p>

<cfset charlist  = "0|2|4|6|8|9|7|5|3|1|A|C|E|H|J|K|M|P|O|Q|S|T|U|V|W|X|Y|0|2|4|6|8|9|7|5|3|1">

<cfset TheDateCreated = #Now()#>
<cfset TheDateCreated = #dateformat(TheDateCreated, "yyyy-mm-dd")#>

<cfloop from = "1" to = "#listlen(giftlist, '^')#" index="giftcount">
<cfset thisprice = listgetat(giftlist, giftcount, "^")>

<cfset CertCode = "">
<cfloop condition="NOT len(CertCode)">

	<cfloop from="1" to="20" index="i">
		<!--- pick a random number between 1 and the length of the list of chars to use --->
		<cfset ThisNum = RandRange(1,listlen(charlist, "|"))>
	
		<!--- get the character that is at the random numbers position in the list of characters ---> 
		<cfset ThisChar = ListGetAt(Charlist, ThisNum, "|")>
	
		<!--- append the new random character to the CustPassword ---> 
		<cfset CertCode = "#CertCode##ThisChar#">
	</cfloop>
	
<!--- Make sure code is not already in use --->
<cfquery name="GetCert" datasource="#Request.dsn#">
SELECT gNumber FROM giftcards
WHERE gNumber = '#CertCode#'
</cfquery>

<!---Already used so generate another one--->
<cfif GetCert.RecordCount>
	<cfset CertCode = "">
</cfif>
</cfloop>

<!---Display this gift certificate number--->
<table width = "350" cellpadding="4" cellspacing="0" style="border: dashed 2px #CCCCCC;" align="center">
<tr>
	<td height="150" align="center" valign="middle">
	Use this code
	<p>
	<span class="giftcode"><cfoutput>#CertCode#</cfoutput></span>
	<p>
	at <cfoutput>#replacenocase(request.homeurl, "http://", "", "ALL")#</cfoutput><br />
	to get up to <cfoutput><strong>
    <cfif request.EnableEuro IS 'Yes'>
         #lseurocurrencyformat(gAmount, "Local")#
    <cfelse>
         #lscurrencyformat(gAmount, "Local")# 
    </cfif>
    </strong></cfoutput> off any purchase! </td>
</tr>
</table>
<p>

<cfif paymentsent IS 'Yes'>
	<cfset isactive = 'Yes'>
<cfelse>
    <cfset isactive = 'No'>
</cfif>

<!---Insert this new giftcode into the database and attach the order number and customerid--->
<cfquery name = "qryInsertGiftCode" datasource="#request.dsn#">
INSERT INTO giftcards
(gNumber, gAmount, gAmountLeft, DateCreated, OrderID, CustomerID, Active, LastModified, activated)
VALUES
('#CertCode#', '#thisprice#', '#thisprice#', '#TheDateCreated#', '#OrderNumber#', '#qryOrders.CustomerID#', 'Yes', '#TheDateCreated#', '#isactive#')
</cfquery>


<!---Generate another one if they added another gift card to their order--->
</cfloop>
</cfif>

<!---If there were some already created (they refreshed), so just display the ones that were created--->
<cfif qryCheck.RecordCount GT 0>
<p>&nbsp;</p>
<center><strong>You have purchased one or more gift codes on this order.  They are listed below:</strong></center>
<p>&nbsp;</p>

<cfloop query = "qryCheck">
<!---Display this gift certificate number--->
<table width = "350" cellpadding="4" cellspacing="0" style="border: dashed 2px #CCCCCC;" align="center">
<tr>
	<td height="150" align="center" valign="middle">
	Use this code
	<p>
	<span class="giftcode"><cfoutput>#gNumber#</cfoutput></span>
	<p>
	at <cfoutput>#replacenocase(request.homeurl, "http://", "", "ALL")#</cfoutput><br />
	to get up to <cfoutput><strong>
	<cfif request.EnableEuro IS 'Yes'>
         #lseurocurrencyformat(gAmount, "Local")#
    <cfelse>
         #lscurrencyformat(gAmount, "Local")# 
    </cfif></strong></cfoutput> off any purchase! </td>
</tr>
</table>
<p>
</cfloop>

</cfif>         



















