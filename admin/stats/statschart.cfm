<cfsetting enablecfoutputonly="yes">
<cfparam name="attributes.width" default="800">
<cfparam name="attributes.width_percentage" default="100%">
<cfparam name="attributes.height" default="100">
<cfparam name="attributes.title" default="Sample Chart">
<cfparam name="attributes.values" default="#RandRange(0,100)#,#RandRange(0,100)#,#RandRange(0,100)#">
<cfparam name="attributes.legend" default="">
<cfparam name="attributes.urls" default="">

<cfparam name="attributes.color_window_title" default="333366">
<cfparam name="attributes.color_window_border" default="333366">
<cfparam name="attributes.color_window" default="dcdcdc">
<cfparam name="attributes.color_bar" default="0033CC,0033CC,0033CC">

<cfparam name="attributes.font_window_title" default="face=""verdana,arial,helvetica"" color=""ffffff"" size=""2""">
<cfparam name="attributes.font_value" default="face=""verdana,arial,helvetica"" color=""000000"" size=""2""">
<cfparam name="attributes.font_legend" default="face=""verdana,arial,helvetica"" color=""000000"" size=""2""">

<cfscript>
	values = ListToArray(attributes.values);
	legend = ListToArray(attributes.legend);
	urls = ListToArray(attributes.urls);
	colors = ListToArray(attributes.color_bar);
	chart_height = attributes.height;

	for (i=1; i lt ArrayLen(values)+1; i=i+1) {
		if (ArrayLen(legend) lt ArrayLen(values)) {
			ArrayAppend(legend,"");
		}
		if (ArrayLen(urls) lt ArrayLen(values)) {
			ArrayAppend(urls,"");
		}
		if (ArrayLen(colors) lt ArrayLen(values)) {
			ArrayAppend(colors,"3333CC");
		}
	}
	
	max_value = ArrayMax(values);
	if (max_value neq 0) {
		k = chart_height/max_value;
	} else {
		k = 0;
	}
	bar_width = Int(Val(attributes.width)/(2*ArrayLen(values)+1)+10);
</cfscript>

<cfoutput>
<cf_table
	title="#attributes.title#"
	width="#attributes.width_percentage#"
	bgcolor1="#attributes.color_window_title#"
	bgcolor2="#attributes.color_window_border#"
	bgcolor3="#attributes.color_window#"
	font_title="#attributes.font_window_title#"
	>
<table cellspacing="0" cellpadding="0" border="0" width="100%">
	<tr>
		<td><img src="images/sp.gif" width="9" height="1" alt=""></td>
		<cfloop index="i" from="1" to="#ArrayLen(values)#">
			<td valign="bottom">
			<center><br>#values[i]#
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<cfif urls[i] is not "">
					<td bgcolor="#colors[i]#"><a href="#urls[i]#"><img src="images/sp.gif" 
						width="#bar_width#"
						height="#Evaluate(Int(values[i]*k+1))#"
						alt="#legend[i]#"
						border="0"></a></td>
					<cfelse>
					<td bgcolor="#colors[i]#"><img src="images/sp.gif" 
						width="#bar_width#"
						height="#Evaluate(Int(values[i]*k+1))#"
						alt="#legend[i]#"
						border="0"></td>
					</cfif>
				</tr>
			</table>
			</td>
			<td><img src="images/sp.gif" width="9" height="1" alt=""></td>
		</cfloop>
	</tr>
	<tr>
		<td>
		</td>
		<cfloop index="i" from="1" to="#ArrayLen(values)#">
		<td class="gist">
		<center>
			<cfif urls[i] is "">
			#legend[i]#
			<cfelse>
			<a href="#urls[i]#">#legend[i]#</a>
			</cfif>
		</center>
		</td>
		<td>
		</td>
		</cfloop>
	</tr>
</table>
</cf_table>
</cfoutput>

<cfsetting enablecfoutputonly="no">




