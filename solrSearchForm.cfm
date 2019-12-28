<!--- Initialize criteria --->
<cfparam name="form.criteria" default="">
<cfif isdefined ("form.criteria")>
    <cfset variables.criteria= form.criteria>
</cfif>
<cfif isdefined ("url.criteria")>
    <cfset variables.criteria= url.criteria>
</cfif>

<!--- Initialize pagesize --->
<cfparam name="form.pagesize" default="6"/>
<cfif isdefined ("form.pagesize")>
    <cfset variables.pagesize= form.pagesize>
</cfif>

<cfif (not isdefined ("form.solrSearch")) && (not isdefined ("url.solrSearch")) >
    <h2>Keyword Search</h2> 
    <cfform name="searchForm" method="post" action="/results.cfm"> 
        <p>Enter search term(s) in the box below. You can use AND, OR, NOT, and 
        parentheses. Surround an exact phrase with quotation marks.</p> 
        <p>
            <cfinput type="hidden" name="pagesize" value="#variables.pagesize#"/>
            <cfinput type="hidden" name="IsSolrSearch" value="Yes"/>
            <cfinput type="text" name="criteria"  value="#variables.criteria#" size="100" maxLength="100">
            <cfinput type="submit" class="btn-small btn-primary" name="solrSearch" value=" Search ">  
        </p> 
    </cfform>
</cfif>
