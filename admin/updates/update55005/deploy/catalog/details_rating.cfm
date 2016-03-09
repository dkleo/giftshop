<cfif request.showproductreviews IS 'Yes'>
	<cfinclude template = "../queries/qryreviews.cfm">
    
    <table width="250" border="0" cellspacing="0" cellpadding="8" align="center">
      <tr>
        <td style="border: 1px solid #000000;">
        <cfif qryReviews.recordcount GT 0>
        <strong>Average Customer Rating:</strong> <cfinclude template = "showrating.cfm">
        <cfoutput><br /><a href = "index.cfm?action=reviews_read&carttoken=#carttoken#&itemid=#itemid#">Read Reviews</a></cfoutput></td>
		<cfelse>
        <strong>Average Customer Rating:</strong> None<br />
		<cfoutput><a href = "index.cfm?action=reviews_write&carttoken=#carttoken#&itemid=#itemid#">Be the first to review this</a>
		</cfoutput>
		</cfif>
      </tr>
    </table> 
       
</cfif>



