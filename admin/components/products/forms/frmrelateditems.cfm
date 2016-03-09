<!---Displays a list of related items if there are any below the description of the product--->
<cfset relatedcount = 0>

<cfif listlen(qryItem.SimilarItems, "^") IS 0>
<center>You do not have any related items set for this item</center>
</cfif>

<cfif listlen(qryItem.SimilarItems, "^") GT 0>
<table width = 100% border="0" cellpadding="3" cellspacing="0">
<tr> 
 <td class="TableTitles" colspan="4"> 
 <div align="center"><strong>Currently Selected Related Items</strong></div></td>
 </tr>
	 <tr> 
	<cfloop from = "1" to = "#listlen(qryItem.SimilarItems, '^')#" index="r">
	<cfset relatedid = listgetat(qryItem.SimilarItems, r, "^")>
	
	<cfinclude template = "../queries/qryrelateditem.cfm">
	<cfoutput query = "qryRelatedItem"> 
	 <cfset relatedcount = relatedcount + 1>
	  <td width="25%" valign="top" class="bodytxt"> 
		<p align="center"><img src="#request.homeURL#photos/small/#qryRelatedImage.iFileName#" alt="#ProductName#" name="RelatedItem" border="0"><br>#ProductName#<br>
	   #sku# (#productid#)
       <p>
		   <center><a href = "doproducts.cfm?action=removerelated&relatedid=#itemid#&ritem=#ritem#&listcount=#relatedcount#">Remove</a></center>
		  </td>
		  <cfif relatedcount IS 4>
		  </tr><tr>
		  <cfset relatedcount = 0>
		  </cfif>
	  </cfoutput> 
</cfloop>
	  </tr>
<tr> 
 <td class="TableTitles" colspan="4"> 
 <div align="center"><strong>Add Related Items</strong></div></td>
 </tr>
	 <tr>      
</table>
</cfif>















