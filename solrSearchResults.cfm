<script type="text/javascript">
    function ImgError(source){
        source.src = "https://commercial.fickling.com/img/no-photo-sm.png";
        source.onerror = ""; 
        return true; 
}
</script>


<!--- Form is defined, user submitted via solrSearch button click --->

<!--- Deal with the inputs and show results --->
<cfif isdefined ("form.solrSearch")>
    <cfparam name="variables.solrSearch" default="#form.solrSearch#">
<cfelseif isdefined ("url.solrSearch")>
    <cfparam name="variables.solrSearch" default="#url.solrSearch#">
</cfif>

<!--- Deal with the inputs and show results --->
<cfif isdefined ("form.IsSolrSearch")>
    <cfparam name="variables.IsSolrSearch" default="#form.IsSolrSearch#">
<cfelseif isdefined ("url.IsSolrSearch")>
    <cfparam name="variables.IsSolrSearch" default="#url.IsSolrSearch#">
</cfif>

<cfif not isdefined("variables.solrSearch") >
    <h1>You are not searching with solrSearch.</h1>
    <cfinclude template="solrSearchForm.cfm"/>
    <cfexit/>
</cfif>

<!--- Do not need this now 

<h3><a href="solrSearchForm.cfm">New Solr Search</a></h3>

--->
<!--- Initialize criteria --->
<cfparam name="form.criteria" default="">
<cfif isdefined ("form.criteria")>
    <cfset variables.criteria= form.criteria>
</cfif>
<cfif isdefined ("url.criteria")>
    <cfset variables.criteria= url.criteria>
</cfif>

<!--- Initialize pagesize --->
<cfif isdefined ("form.pagesize")>
    <cfparam name="variables.pagesize" default="#form.pagesize#">
<cfelseif isdefined ("url.pagesize")>
    <cfparam name="variables.pagesize" default="#url.pagesize#">
</cfif>

<!--- Initialize sort order --->
<cfif isdefined ("form.SolrSortOrder")>
    <cfparam name="variables.SolrSortOrder" default="#form.SolrSortOrder#">
<cfelseif isdefined ("url.SolrSortOrder")>
    <cfparam name="variables.SolrSortOrder" default="#url.SolrSortOrder#">
<cfelse>
    <cfparam name="variables.SolrSortOrder" default="custom2 asc">
</cfif>



<!--- Initialize page Index --->
<cfif not isdefined("url.page")>
    <cfparam name="variables.page" default="1"/>
<cfelse>
    <cfparam name="variables.page" default="#url.page#"/>
</cfif>

<!--- Set the path to where we store our collection--->
<cfset colpath="#ExpandPath("/solr")#">

<!--- Get a list of existing collections --->
<cfcollection action="list" name="collectionList">

<!--- Convert the collections name column to a value list --->
<cfset collectionList = valueList(collectionList.name)>

<!--- If a collection with that name does not already exist --->
<cfif NOT listFind(collectionList,"comlistings")>
 <!--- Create the collection --->
 <cfcollection
      action="create"
      collection="comlistings"
      engine="solr"
      path="#colpath#">
</cfif>


<!--- First get some data to index --->
<cfquery name="getcomlistings" datasource="commercial">
SELECT 
	  listings.listID,
	  listings.Status,
	  listings.AddressNumber,
	  listings.AddressStreet,
	  listings.City,
	  listings.State,
	  listings.County,
	  listings.Zipcode,
	  listings.Remarks,
	  listings.Type,
	  listings.Class,
	  listings.SubType,
	  listings.PropertyUse,
	  listings.Price,
      listings.HidePrice,
	  listings.LocationDesc,
	  listings.PropertyName,
	  listings.Agent,
	  listings.CoAgent,
      listings.DaysOnMarket,
	  seo.ListID,
	  seo.StrNumber,
	  seo.StrName,
	  seo.Cty,
	  seo.St,
	  fagents.Agent,
    fagents.AgentFName,
    fagents.AgentLName,
	fcoagents.CoAgent,
    fcoagents.CoAgentFName,
    fcoagents.CoAgentLName,
	CONCAT(seo.StrNumber,"-",seo.StrName,"-",seo.Cty,"-",seo.St) AS seoaddress
FROM listings
LEFT JOIN seo ON listings.listid = seo.listid
LEFT JOIN fagents ON listings.Agent = fagents.Agent
LEFT JOIN fcoagents ON listings.CoAgent = fcoagents.CoAgent
WHERE Status = "ACTIVE"
</cfquery>



<!--- Then refresh index --->
<cfindex 
      collection="comlistings" 
      action="refresh" 
      type="custom" 
      title="PropertyName"
      body="listID,Status,AddressNumber,AddressStreet,City,State,County,Zipcode,Type,Class,HidePrice,SubType,Remarks,seoaddress,LocationDesc,PropertyName,PropertyUse,AgentFName,AgentLName,CoAgentFName,CoAgentLName"
      custom1="seoaddress"
	  custom2="Price"
      custom3="DaysOnMarket"
	  custom4="City"
      class_s="Class"
      type_s="Type"
      remarks_s="Remarks"
      hideprice_s="HidePrice"
      query="getcomlistings" 
      key="ListID">


<!--- Then index it --->
<cfindex 
      collection="comlistings" 
      action="update" 
      type="custom" 
      title="PropertyName"
      body="listID,Status,AddressNumber,AddressStreet,City,State,County,Zipcode,Type,Class,HidePrice,SubType,Remarks,seoaddress,LocationDesc,PropertyName,PropertyUse,AgentFName,AgentLName,CoAgentFName,CoAgentLName"
      custom1="seoaddress"
	  custom2="Price"
      custom3="DaysOnMarket"
	  custom4="City"
      class_s="Class"
      type_s="Type"
      remarks_s="Remarks"
      hideprice_s="HidePrice"
      query="getcomlistings" 
      key="ListID">
	  
	  
 
<cfsearch name="RawsearchResults" collection="comlistings" criteria="#variables.criteria#">







<!--- Price Ascending is the default --->

    <cfquery name="searchResults" dbtype="query">
        select * from RawSearchResults 
    </cfquery>




<div id="content">
    <div class="container">
    
   
  
  
  <div class="row-fluid">
<div class="span6"> <h3>Search Results: <cfoutput>#searchresults.RecordCount# Properties</cfoutput> </h3> </div> 
<div class="span6"> <cfif IsUserLoggedIn()>
  <div class="btn-group  pull-right">
	<a href="##myModalSavedSearch" role="button" class="btn " data-toggle="modal"> <i class="icon-star"></i> Save Search </a>
    
    <cfoutput><a href="search-map.cfm?quickMap=Yes&#session.searchstring#"  class="btn" target="_blank"><i class="icon-map-marker"></i> Map Results</a></cfoutput>
	</div>
</cfif></div>  
</div>         

<div class="row-fluid">

<div class="span12">
	
 
            <cfif result.RecordCount IS 0>
              <p>NO RESULTS</p>
              
              <cfelse>
	
 <!---footable implementation--->
 
  
  <table class="table" data-paging="true" data-paging-limit="10" data-paging-size="10" data-state="true" data-sorting="true">
	<thead>

		<tr>
			<th data-type="html">ListID</th>
            <th data-type="html"  data-sortable="false" data-breakpoints="xs sm">Photo</th>
			<th data-type="html"  data-sortable="false">Address</th>
            <th>City</th>
            <th data-type="number" data-formatter="dollarFormat" data-thousand-separator="," data-sort-initial="true">Price</th>
            <th data-breakpoints="xs" data-type="html">Class</th>
			<th data-breakpoints="all">Remarks</th>
            <th data-breakpoints="all">Type</th>

		</tr>
	</thead>
	<tbody> 
	
	<cfloop query="searchresults">
	<cfdirectory action="list" directory="#ExpandPath('/uploads/photos/thumbs/')#/#TRIM(Key)#" name="pics">
    <!---<cfset trendStruct = createObject ("component","cfcs.usrService").getPriceTrend(trim(listid))/>--->
	 <cfoutput>
	 
	<tr>
    <td>#Key#</td>
    <td><a href="/#urlencodedformat(trim(Key))#/#custom1#.html" title="#title#"><img src="/uploads/photos/thumbs/#Key#/#ListFirst(pics.Name)#"  width="120" onerror="ImgError(this)"></a></td>
     
    <td><a href="/#urlencodedformat(trim(Key))#/#custom1#.html" title="#title#">#custom1#</a></td>
    <td>#custom4#</td>
    
    <cfif hideprice_s IS "1">
    <td data-value="0.00"></td><cfelse><td data-value="#custom2#">#DollarFormat(custom2)#</td></cfif>
    <td data-value="#class_s#">#class_s#</td>
    <td data-value="#remarks_s#">#remarks_s#</td>
	<td data-value="#type_s#">#type_s#</td>
    </tr>
	</cfoutput>
	</cfloop>
	</tbody>

	</table>
  
  
 </cfif>
  
  <!---end footable implementation--->


</div>
	</div>
