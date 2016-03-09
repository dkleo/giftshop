<h2>Category HTML</h2>
<cfinclude template = "../queries/qrycategories.cfm">
<cfoutput query="qryCategories">
The HTML code below will create a text link to this category.  You can substitute an image for the text
<p>
HTML Code for this category:
<p>
<textarea name="HTMLCode" cols="8" rows="5" readonly="readonly"><a href="index.cfm?action=viewcategory&category=#ur.CategoryID#">#CategoryName#</a></textarea></p>
</cfoutput>
<p>
<a href = "index.cfm">Back</a>





















