<!---Calculate Taxes--->
<cfinclude template = "../queries/qrytaxes.cfm">
<cfset TempVar.FiguredTax = 0>

<cfoutput query = "qryTaxes">
<!---first figure the taxes for this country, if any--->
<cfif #form.ship_country# IS #Country#>
	<cfif #Region# IS 'None'>
	  <cfset TempVar.FiguredTax = #CartTaxTotal# * #TaxRate#>
	</cfif>
</cfif>
</cfoutput>

<!---Now figure state/region and zip code specific taxes--->
<cfoutput query = "qryTaxes">
<cfif #form.ship_country# IS #Country#>
	<cfif #form.ship_state# IS #Region#>
	 <cfif #ZipCode# IS ''>
		<cfset TempVar.FiguredTax = TempVar.FiguredTax + (#CartTaxTotal# * (#TaxRate#))>
	</cfif>
	<!---If the Zip Code Matches, then charge the specified tax on top of any state tax--->
	<cfif NOT #ZipCode# IS ''>
		<cfif #form.ship_zip# IS #ZipCode#>
			<cfset TempVar.FiguredTax = TempVar.FiguredTax + (#CartTaxTotal# * (#TaxRate#))>
		</cfif>
	</cfif>
   </cfif>
</cfif>
</cfoutput>

<cfset Cart.FiguredTax = TempVar.FiguredTax>
