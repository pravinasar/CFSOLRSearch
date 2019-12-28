<cfprocessingdirective suppresswhitespace="yes">
<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<CFSET CurrentURL = 'http://' & CGI.SERVER_NAME>
<cfparam name = "ApproxAcreage" default="">
<cfif IsDefined("url.MaxAcres") and len(trim(url.MaxAcres))>
  <cfset form.MaxAcres = url.MaxAcres>
 <cfelse>
	<cfparam name = "form.MaxAcres" default="5000">
</cfif>

<cfif IsDefined("url.minimumPrice") and len(trim(url.minimumPrice))>
  <cfset form.minimumPrice = url.minimumPrice>
</cfif>
<cfif IsDefined("url.maximumPrice") and len(trim(url.maximumPrice))>
  <cfset form.maximumPrice = url.maximumPrice>
</cfif>
<cfif IsDefined("url.YearBuilt") and len(trim(url.YearBuilt))>
  <cfset form.YearBuilt = url.YearBuilt>
</cfif>
<cfif IsDefined("url.NumBedrooms") and len(trim(url.NumBedrooms))>
  <cfset form.NumBedrooms = url.NumBedrooms>
</cfif>
<cfif IsDefined("url.FullBaths") and len(trim(url.FullBaths))>
  <cfset form.FullBaths = url.FullBaths>
</cfif>
<cfif IsDefined("url.City") and len(trim(url.City))>
  <cfset form.City = url.City>
</cfif>

<cfif IsDefined("url.ApproxAcreage") and len(trim(url.ApproxAcreage))>
  <cfset form.ApproxAcreage = url.ApproxAcreage>
</cfif>

<cfif IsDefined("url.Type") and len(trim(url.Type))>
  <cfset form.Type = url.Type>
</cfif>
<cfif IsDefined("url.Subdivision") and len(trim(url.Subdivision))>
  <cfset form.Subdivision = url.Subdivision>
</cfif>
<cfif IsDefined("url.TotalFinishedSqFt")>
  <cfset form.TotalFinishedSqFt = url.TotalFinishedSqFt>
</cfif>
<cfif IsDefined("url.DaysOnMarket")>
  <cfset form.DaysOnMarket = url.DaysOnMarket>
</cfif>
<cfif IsDefined("url.ElementarySchool") and len(trim(url.ElementarySchool))>
  <cfset form.ElementarySchool = url.ElementarySchool>
</cfif>
<cfif IsDefined("url.MiddleSchool") and len(trim(url.MiddleSchool))>
  <cfset form.MiddleSchool = url.MiddleSchool>
</cfif>
<cfif IsDefined("url.HighSchool") and len(trim(url.HighSchool))>
  <cfset form.HighSchool = url.HighSchool>
</cfif>
<cfif IsDefined("url.Foreclosure") and len(trim(url.Foreclosure))>
  <cfset form.Foreclosure = url.Foreclosure>
</cfif>
<cfif IsDefined("url.Shortsale") and len(trim(url.Shortsale))>
  <cfset form.Shortsale = url.Shortsale>
</cfif>
<cfif IsDefined("url.MinAcres") and len(trim(url.MinAcres))>
	<cfset form.MinAcres = url.MinAcres>
	<cfif IsDefined("url.MaxAcres") and len(trim(url.MaxAcres)) eq 0>
		<cfset url.MaxAcres = 5000>
	</cfif>
</cfif>
<cfif IsDefined("url.MaxAcres") and len(trim(url.MaxAcres))>
  <cfset form.MaxAcres = url.MaxAcres>
</cfif>
<cfif IsDefined ("URL.searchText")>
  <cfset Form.searchText = trim(URL.searchText)/>
</cfif>
<cfif IsDefined ("URL.searchField")>
  <cfset Form.searchField= trim(URL.searchField)/>
</cfif>
<cfif IsDefined ("URL.Text1")>
  <cfset url.text1 = trim(URL.text1)>
</cfif>
<cfif IsDefined ("URL.SearchField")>
  <cfset Form.SearchField = URL.SearchField/>
</cfif>
<cfif IsDefined ("URL.Text1")>
  <cfset Form.Text1 = URL.Text1/>
</cfif>
<cfif IsDefined ("URL.SortOrder")>
  <cfset Form.SortOrder = URL.SortOrder/>
</cfif>

<!--- Check for quick Search submit --->
<cfif IsDefined ("FORM.searchText")>
  <cfset Form.searchText = trim(FORM.searchText)/>
</cfif>
<cfif IsDefined ("FORM.searchField")>
  <cfset Form.searchField= trim(FORM.searchField)/>
</cfif>
<cfif IsDefined ("FORM.Text1")>
  <cfset FORM.text1 = trim(FORM.text1)>
</cfif>
<cfif IsDefined("Form.searchField")>
  <cfif len (trim(form.searchField)) gt 0>
    <cfif form.searchField is "City">
      <cfset form.City = Form.text1>
    </cfif>
    <cfif form.searchField is "ListID">
      <cfset form.ListID = Form.text1>
    </cfif>
    <cfif form.searchField is "StreetName">
      <cfset form.StreetName = Form.text1>
    </cfif>
     <cfif form.searchField is "Address">
      <cfset form.Address = Form.text1>
    </cfif>
    <cfif form.searchField is "Subdivision">
      <cfset form.Subdivision = Form.text1>
    </cfif>
    <cfif form.searchField is "Type">
      <cfset form.Type = Form.text1>
    </cfif>
    <cfelse>
    <cfset form.searchText = Form.text1/>
  </cfif>
</cfif>

<cfif not isdefined ("Form.sortOrder")>
	<cfset form.sortorder="Price DESC"/>
	<cfset variables.sortorder=#form.sortorder#/>
</cfif>

<!--- Check for Pagination --->
<cfset form.pagination=false/>
<cfif isdefined("url.page")>
  <cfset form.pagination=true>
</cfif>
<cfset xlist="Type,City,MinimumPrice,MaximumPrice,NumBedrooms,FullBaths,Subdivision,MinAcres,MaxAcres,TotalFinishedSqFt,DaysOnMarket,YearBuilt,ElementarySchool,MiddleSchool,HighSchool,Foreclosure,Shortsale">
<cfloop list="#xlist#" index="ii">
<cfparam name="form.#ii#" default="">
</cfloop>
<cfif StructKeyExists(form,"fieldnames")>
  <cfset rlist="submit">
  <cfset searchstring="">
  <cfloop list="#form.fieldnames#" index="ii">
  <cfif Not listfindnocase(variables.rlist,ii)>
    <cfset searchstring=ListAppend(variables.searchstring,ii & "=" & form[ii],"&")>
  </cfif>
  </cfloop>
  <cflock scope="session" type="exclusive" timeout="15">
  <cfset session.searchstring=variables.searchstring>
  </cflock>
</cfif>

<!---form prefill minimumPrice--->
<cfif isDefined("Form.minimumPrice")>
  <cfset CLIENT.minimumPrice = Form.minimumPrice>
  <cfset prefillminimumprice = Form.minimumPrice>
  <cfelseif isDefined("CLIENT.lastminimumPrice")>
  <cfset prefillminimumPrice = CLIENT.lastminimumPrice>
  <cfelse>
  <cfset prefillminimumPrice = " ">
</cfif>

<!---form prefill maximumPrice--->
<cfif isDefined("Form.maximumPrice")>
  <cfset CLIENT.maximumPrice = Form.maximumPrice>
  <cfset prefillmaximumprice = Form.maximumPrice>
  <cfelseif isDefined("CLIENT.lastmaximumPrice")>
  <cfset prefillmaximumPrice = CLIENT.lastmaximumPrice>
  <cfelse>
  <cfset prefillmaximumPrice = " ">
</cfif>

<!---form prefill NumBedrooms--->
<cfif isDefined("Form.NumBedrooms")>
  <cfset CLIENT.NumBedrooms = Form.NumBedrooms>
  <cfset prefillNumBedrooms = Form.NumBedrooms>
  <cfelseif isDefined("CLIENT.lastNumBedrooms")>
  <cfset prefillNumBedrooms = CLIENT.lastNumBedrooms>
  <cfelse>
  <cfset prefillNumBedrooms = " ">
</cfif>

<!---form prefill Baths--->
<cfif isDefined("Form.FullBaths")>
  <cfset CLIENT.FullBaths = Form.FullBaths>
  <cfset prefillFullBaths = Form.FullBaths>
  <cfelseif isDefined("CLIENT.lastFullBaths")>
  <cfset prefillFullBaths = CLIENT.lastFullBaths>
  <cfelse>
  <cfset prefillFullBaths = " ">
</cfif>

<!---form prefill ApproxAcres--->
<cfif isDefined("Form.ApproxAcreage")>
  <cfset CLIENT.ApproxAcreage = Form.ApproxAcreage>
  <cfset prefillApproxAcreage = Form.ApproxAcreage>
  <cfelseif isDefined("CLIENT.lastApproxAcreage")>
  <cfset prefillApproxAcreage = CLIENT.lastApproxAcreage>
  <cfelse>
  <cfset prefillApproxAcreage = " ">
</cfif>

<!---form prefill City--->
<cfif isDefined("Form.City")>
  <cfset CLIENT.City = Form.City>
  <cfset prefillCity = Form.City>
  <cfelseif isDefined("CLIENT.lastCity")>
  <cfset prefillCity = CLIENT.lastCity>
  <cfelse>
  <cfset prefillCity = " ">
</cfif>

<!---form prefill Type--->
<cfif isDefined("Form.Type")>
  <cfset CLIENT.Type = Form.Type>
  <cfset prefillType = Form.Type>
  <cfelseif isDefined("CLIENT.lastType")>
  <cfset prefillType = CLIENT.lastType>
  <cfelse>
  <cfset prefillType = " ">
</cfif>

<!---form prefill Subdivision--->
<cfif isDefined("Form.Subdivision")>
  <cfset CLIENT.Subdivision = Form.Subdivision>
  <cfset prefillSubdivision = Form.Subdivision>
  <cfelseif isDefined("CLIENT.lastSubdivision")>
  <cfset prefillSubdivision = CLIENT.lastSubdivision>
  <cfelse>
  <cfset prefillSubdivision = " ">
</cfif>

<!---form prefill DaysOnMarket--->
<cfif isDefined("Form.DaysOnMarket")>
  <cfset CLIENT.DaysOnMarket = Form.DaysOnMarket>
  <cfset prefillDaysOnMarket = Form.DaysOnMarket>
  <cfelseif isDefined("CLIENT.lastDaysOnMarket")>
  <cfset prefillDaysOnMarket = CLIENT.lastDaysOnMarket>
  <cfelse>
  <cfset prefillDaysOnMarket = " ">
</cfif>

<!---form prefill TotalFinishedSqFt--->
<cfif structKeyExists(FORM, "TotalFinishedSqFt")>
  <cfset CLIENT.TotalFinishedSqFt = Form.TotalFinishedSqFt>
  <cfset variables.prefillTotalFinishedSqFt= Form.TotalFinishedSqFt>
  <cfelseif structKeyExists(CLIENT, "TotalFinishedSqFt")>
  <cfset variables.prefillTotalFinishedSqFt= CLIENT.lastTotalFinishedSqFt>
  <cfelse>
  <cfset variables.prefillTotalFinishedSqFt= " ">
</cfif>

<!---form prefill YearBuilt--->
<cfif structKeyExists(FORM, "YearBuilt")>
  <cfset CLIENT.YearBuilt = Form.YearBuilt>
  <cfset variables.prefillYearBuilt= Form.YearBuilt>
  <cfelseif structKeyExists(CLIENT, "YearBuilt")>
  <cfset variables.prefillYearBuilt= CLIENT.lastYearBuilt>
  <cfelse>
  <cfset variables.prefillYearBuilt= " ">
</cfif>

<!---form prefill ElementarySchool--->
<cfif isDefined("Form.ElementarySchool")>
  <cfset CLIENT.ElementarySchool = Form.ElementarySchool>
  <cfset prefillElementarySchool = Form.ElementarySchool>
  <cfelseif isDefined("CLIENT.ElementarySchool")>
  <cfset prefillElementarySchool = CLIENT.ElementarySchool>
  <cfelse>
  <cfset prefillElementarySchool = " ">
</cfif>

<!---form prefill MiddleSchool--->
<cfif isDefined("Form.MiddleSchool")>
  <cfset CLIENT.MiddleSchool = Form.MiddleSchool>
  <cfset prefillMiddleSchool = Form.MiddleSchool>
  <cfelseif isDefined("CLIENT.MiddleSchool")>
  <cfset prefillMiddleSchool = CLIENT.MiddleSchool>
  <cfelse>
  <cfset prefillMiddleSchool = " ">
</cfif>

<!---form prefill HighSchool--->
<cfif isDefined("Form.HighSchool")>
  <cfset CLIENT.HighSchool = Form.HighSchool>
  <cfset prefillHighSchool = Form.HighSchool>
  <cfelseif isDefined("CLIENT.HighSchool")>
  <cfset prefillHighSchool = CLIENT.HighSchool>
  <cfelse>
  <cfset prefillHighSchool = " ">
</cfif>

<!---form prefill Foreclosure--->

<!---form prefill MinAcres--->
<cfif structKeyExists(FORM, "MinAcres")>
  <cfset CLIENT.MinAcres = Form.MinAcres>
  <cfset variables.prefillMinAcres= Form.MinAcres>
  <cfelseif structKeyExists(CLIENT, "MinAcres")>
  <cfset variables.prefillMinAcres= CLIENT.lastMinAcres>
  <cfelse>
  <cfset variables.prefillMinAcres= " ">
</cfif>

<!---form prefill MaxAcres--->
<cfif structKeyExists(FORM, "MaxAcres")>
  <cfset CLIENT.MaxAcres = Form.MaxAcres>
  <cfset variables.prefillMaxAcres= Form.MaxAcres>
  <cfelseif structKeyExists(CLIENT, "MaxAcres")>
  <cfset variables.prefillMaxAcres= CLIENT.lastMaxAcres>
  <cfelse>
  <cfset variables.prefillMaxAcres= " ">
</cfif>




<cfquery name="Type" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT Type FROM listings
GROUP BY Type,Class DESC
</cfquery>
<cfquery name="city" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT City FROM listings 
ORDER BY City ASC
</cfquery>
<cfquery name="subdivision" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT Subdivision FROM listings 
ORDER BY Subdivision ASC
</cfquery>
<cfquery name="ElementarySchool" datasource="commercial" cachedwithin="#createtimespan(1,0,30,0)#" >
SELECT DISTINCT ElementarySchool FROM listings 
ORDER BY ElementarySchool ASC
</cfquery>
<cfquery name="MiddleSchool" datasource="commercial" cachedwithin="#createtimespan(1,0,30,0)#" >
SELECT DISTINCT MiddleSchool FROM listings 
ORDER BY MiddleSchool ASC
</cfquery>
<cfquery name="HighSchool" datasource="commercial" cachedwithin="#createtimespan(1,0,30,0)#" >
SELECT DISTINCT HighSchool FROM listings 
ORDER BY HighSchool ASC
</cfquery>
<cfinclude template="results_inc.cfm">
<cfif form.pagination is false>
  <cfset client.totalRecordCount=listings.recordCount/>
</cfif>
<cfparam name="url.StartRow" default="1">
<cfset rowsPerPage = 10>
<cfset totalRows = listings.recordCount>
<cfset endRow = min(url.startRow + rowsPerPage - 1, totalRows)>
<cfset startRowNext = endRow + 1>
<cfset startRowBack = url.startRow - rowsPerPage>
<cfscript>
function FormatTeaser(string,number){
	var urlArgument = "";
	var shortString = "";
	
	//return quickly if string is short or no spaces at all
	if(len(string) lte number or not refind("[[:space:]]",string)) return string;
	
	if(arrayLen(arguments) gt 2) urlArgument = "... <a href=""" & arguments[3] & """>[more]</a>";

	//Full Left code (http://www.cflib.org/udf.cfm?ID=329)
	if(reFind("[[:space:]]",mid(string,number+1,1))) {
	  	shortString = left(string,number);
	} else { 
		if(number-refind("[[:space:]]", reverse(mid(string,1,number)))) shortString = Left(string, (number-refind("[[:space:]]", reverse(mid(string,1,number))))); 
		else shortString = left(str,1);
	}
	
	return shortString & urlArgument;

}
</cfscript>

<!DOCTYPE html>
<html lang="en">
<head>
<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Fickling &amp; Company Realtors</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Bootstrap CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="/chosen/docsupport/prism.css">
<link rel="stylesheet" href="/chosen/chosen.css">

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="js/html5.js"></script>
    <![endif]-->

<link rel="shortcut icon" href="img/favicon.ico">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,300|Rambla|Calligraffitti' rel='stylesheet' type='text/css'>
</head>

<body class="page page-features">
<div id="navigation" class="wrapper">
  <div class="navbar  navbar-static-top">
    <cfinclude template="hiddenheader.cfm">
    <cfinclude template="headernav.cfm">
<div id="content">
  <div class="container">
    <div class="row">
      <div class="span12">
        <h3 class="title-divider"><span><i class="icon-search"></i> Search Results (order by <cfoutput>#form.sortorder#</cfoutput>)</span></h3>
      </div>
		<div class="span12">
		<cfform name="f1">
		
          	<cfselect name="sortOrderPick" id="sortOrderPick" class="span3 chosen-select-no-single" onchange="document.getElementById('sortOrder').value = this.value;">
			<option value="Price ASC" <cfif comparenocase("Price ASC", form.sortorder) eq 0>selected</cfif>>Price Low to High</option>
			<option value="Price DESC" <cfif comparenocase("Price DESC", form.sortorder) eq 0>selected</cfif>>Price High to Low</option>
			<option value="DaysOnMarket ASC" <cfif comparenocase("DaysOnMarket ASC", form.sortorder) eq 0>selected</cfif>>Newest Listings First</option>
			<option value="DaysOnMarket DESC" <cfif comparenocase("DaysOnMarket DESC", form.sortorder) eq 0>selected</cfif>>Oldest Listings First</option>
		</cfselect>
             <cfset newLink = "#CGI.script_name#?Type=#Form.Type#&FullBaths=#Form.FullBaths#&NumBedrooms=#Form.NumBedrooms#&minimumPrice=#Form.minimumPrice#&maximumPrice=#Form.maximumPrice#&Subdivision=#Form.Subdivision#&YearBuilt=#Form.YearBuilt#&TotalFinishedSQFT=#Form.TotalFinishedSQFT#&DaysOnMarket=#Form.DaysOnMarket#&MinAcres=#Form.MinAcres#&MaxAcres=#Form.MaxAcres#&City=#Form.City#&ElementarySchool=#Form.ElementarySchool#&MiddleSchool=#Form.MiddleSchool#&HighSchool=#Form.HighSchool#&Foreclosure=#Form.Foreclosure#&Shortsale=#Form.Shortsale#&sortOrder="/>
		<cfinput name="triggerBtn" type="button" class="btn-sort btn-primary" value="SORT"
		onclick="window.location.href='#newLink#'+ document.getElementById('sortOrderPick').value;">
		</cfform>
		</div>
    </div>
    <div class="row">
      <div class="span8">
        <h4>Search Results:
          <cfoutput>#startRow# to
          <cfif startRowNext LTE listings.RecordCount>
            #EndRow#
            <cfelse>
            #listings.RecordCount#
          </cfif>
          of #listings.RecordCount# Properties</cfoutput>
	<!---<cfif #session.searchstring# CONTAINS "SEARCHFIELD"><CFELSE><span class="pull-right"> <cfoutput> <a href="search-map.cfm?quickMap=Yes&#session.searchstring#"  class="btn btn-small btn-primary" target="_blank"><i class="icon-map-marker"></i> Map Results</a></cfoutput></span></cfif>--->
        </h4>
		

        <cfif result.RecordCount IS 0>
          <p>NO RESULTS</p>
          <cfelse>
          <cfloop query="listings" startrow="#url.startRow#" endRow="#endRow#">
          <cfset trendStruct = createObject ("component","cfcs.usrService").getPriceTrend(trim(listid))/>
          <cfoutput>
          <cfif DaysOnMarket lte '8' ><div class="hoverdivNew"><cfelse><div class="hoverdiv"></cfif>
            <div class="row-fluid">
              <div class="span4"> <a href="/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#St#.html">
              <img src="http://199.73.57.156/ftp/rets/photos/#ListID#-1.jpeg" class="imageClip" onerror="this.src='http://199.73.57.156/img/no-photo-sm.png';"></a> </div>
              <div class="span8"> 
              <a href= "#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#State#.html"> 
              <a href= "/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#State#.html"> 
              <span class="address">#AddressNumber# #AddressStreet#</a> - #City#</span> | <a id="pop" href="##" data-toggle="popover" data-content="#trendStruct.details#">  <span class="price"><strong>#RemoveChars(DollarFormat(Price),Len(DollarFormat(Price))-2,3)#</strong></span>  <img src="/img/#trendStruct.trend#.png" width="30" height="30" style="display:inline-block;" title="#trendStruct.trend# #trendStruct.details#" alt="#trendStruct.trend# #trendStruct.details#"/></a> 
              <span class="hoverdivFeatures">
              
                <cfif Class IS "Land">
                <cfif ApproxAcreage IS NOT "">
                  <span class="alert-info pull-right">Acres: #ApproxAcreage#</span><br>
                  <cfelse>
                  <br>
                  #NumBedrooms# Bedrooms | #FullBaths# Full Baths</span>
                </cfif></cfif>
                <br />
                <cfif #Remarks# IS "">
                  <p>&nbsp;</p>
                  <br>
                  <cfelse>
                  #FormatTeaser(Remarks,90,"#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#State#.html")#
                </cfif>
                <p/>
		    <cfif DaysOnMarket lte '8'><p> Days on Market : #DaysOnMarket#</p><cfelse></cfif>
              </div>
            </div>
          </div>
          </cfoutput>
          </cfloop>
          <hr>
          <p>Search Results:<br>
            <cfoutput>#startRow# to
            <cfif startRowNext LTE listings.RecordCount>
              #EndRow#
              <cfelse>
              #listings.RecordCount#
            </cfif>
            of<strong> #listings.RecordCount# </strong>Properties</cfoutput>
          </p>
          <cfinclude template="myPageMgr.cfm">
          <hr>
        </cfif>
      </div>
      <!---CLOSE SPAN8 DIV--->
      
      <div class="span4">
      <div class="row-fluid">
      <cfinclude template="searchsidebar.cfm">
    </div>
  </div>
</div>
<!---CLOSE SPAN4 DIV--->

</div>
<!---CLOSE ROW DIV--->
</div>
<!---CLOSE CONTAINER DIV--->
</div>
<!---CLOSE CONTENT DIV--->

<cfinclude template="footer.cfm">

<!--Scripts --> 
<cfinclude template="/js/scripts.cfm">
<script src="/chosen/chosen.jquery.js" type="text/javascript"></script>
<script src="/chosen/docsupport/prism.js" type="text/javascript" charset="utf-8"></script>
 
<script type="text/javascript">
    $('[data-toggle="popover"]').popover({
    trigger: 'hover',
        'placement': 'top'
});
</script>
<script type="text/javascript">
             $(document).on("show", ".accordion-group", function() {
            $(this).find(".accordion-body").css("overflow","visible");
        });

        $(document).on("hide", ".accordion-group", function() {
            $(this).find(".accordion-body").css("overflow","hidden");
        });
            </script>
            
  <script type="text/javascript">
    var config = {
      '.chosen-select'           : {},
      '.chosen-select-deselect'  : {allow_single_deselect:true},
      '.chosen-select-no-single' : {disable_search_threshold:25},
      '.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
      '.chosen-select-width'     : {width:"95%"}
    }
    for (var selector in config) {
      $(selector).chosen(config[selector]);
    }
  </script>
</body>
</html>
</cfprocessingdirective>