<cfparam name = "pLinkID" default="0">
<cfinclude template="../queries/qrycomponents.cfm">
<cfoutput>
<h2>Select a Link Type Below To Continue Adding a New Link</h2>
<p><span><a style="font-size: 18px; font-weight: bold" href="index.cfm?action=newsitelink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&amp;pLinkID=#pLinkID#&level=#level#">Page Link	</a></span><br />
A Page Link is a link to a page or file within your own website. Select which file you want to link to and select some options and a link will be created in your menu. <a href="index.cfm?action=newsitelink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&pLinkID=#pLinkID#">Create  Page Link.</a>
<cfif qryComponents.recordcount GT 0><p><span><a style="font-size: 18px; font-weight: bold" href="index.cfm?action=newpluginlink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&amp;pLinkID=#pLinkID#">Component Link</a></span><br />
This is a link to a component that is installed on your website.  Select this if you want to add a link to your navigation menu to one of the built-in features. <a href="index.cfm?action=newpluginlink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&pLinkID=#pLinkID#&level=#level#">Create	a	Component Link
</a>
</cfif>  
<p><span><a style="font-size: 18px; font-weight: bold" href="index.cfm?action=newcustomlink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&amp;pLinkID=#pLinkID#&level=#level#">Custom Link</a></span><br />
A Custom Link is a link that doesn't fit the above. An example of a custom link is a link to another website. <a href="index.cfm?action=newcustomlink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&pLinkID=#pLinkID#&level=#level#">Create a Web Link</a>.
<p><span><a style="font-size: 18px; font-weight: bold" href="index.cfm?action=newcategorylink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&amp;pLinkID=#pLinkID#&level=#level#">Category Link</a></span><br />
Creates a link to a specific category in your catalog. <a href="index.cfm?action=newcategorylink&amp;nView=#url.nView#&amp;mView=#url.mView#&amp;ov=#url.ov#&amp;pLinkID=#pLinkID#&level=#level#">Create Category Link</a>. </cfoutput>
<p>
<cfoutput>
<cfif NOt isdefined('url.pLinkID')>
	<a href = "index.cfm?mView=#url.mView#&nview=#url.nView#&level=#level#">Cancel Add</a>
<cfelse>
	<a href = "index.cfm?action=editsubmenu&mView=#url.mView#&pLinkID=#url.pLinkID#&nview=#url.nView#&level=#level#">Cancel Add</a>
</cfif>
</cfoutput>



















