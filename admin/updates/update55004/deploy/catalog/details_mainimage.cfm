<!---displays main image only--->
<cfif NOT qryProducts.showimage IS 'No'>
    <cfinclude template = "productimages_single.cfm">
    <cfoutput>#imagetable#</cfoutput>
</cfif>



