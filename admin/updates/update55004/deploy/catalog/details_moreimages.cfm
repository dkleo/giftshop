<cfif NOT qryProducts.showimage IS 'No'>
<table width="100%" cellpadding="4" cellspacing="0">
<tr>
	<td class="TableTitles"><strong>
    More Images    </strong></td>
  </tr>
<tr>
	<td>
		<!---displays the product image(s)--->
        <cfinclude template = "productimages_more.cfm">
        <cfoutput>#imagetable2#</cfoutput>
    </td>
</tr>
</table>
</cfif>



