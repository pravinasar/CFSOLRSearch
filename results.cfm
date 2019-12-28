<cfprocessingdirective suppresswhitespace="yes">
<cfset CurrentPage=GetFileFromPath(GetTemplatePath())>
<CFSET CurrentURL = 'http://' & CGI.SERVER_NAME>
<cfparam name="session.searchstring" default="">
<cfparam name = "ApproxAcreage" default="">
<cfif IsDefined("url.MaxAcres") and len(trim(url.MaxAcres))>
  <cfset form.MaxAcres = url.MaxAcres>
 <cfelse>
	<cfparam name = "form.MaxAcres" default="50000">
</cfif>

<cfparam name="form.MinimumSqft" default="">
<cfparam name="form.MaximumSqft" default="">

<cfif IsDefined("url.minimumPrice") and len(trim(url.minimumPrice))>
  <cfset form.minimumPrice = url.minimumPrice>
</cfif>
<cfif IsDefined("url.maximumPrice") and len(trim(url.maximumPrice))>
  <cfset form.maximumPrice = url.maximumPrice>
</cfif>
<cfif IsDefined("url.minimumrentalrate") and len(trim(url.minimumrentalrate))>
  <cfset form.minimumrentalrate = url.minimumrentalrate>
</cfif>
<cfif IsDefined("url.maximumrentalrate") and len(trim(url.maximumrentalrate))>
  <cfset form.maximumrentalrate = url.maximumrentalrate>
</cfif>
<cfif IsDefined("url.YearBuilt") and len(trim(url.YearBuilt))>
  <cfset form.YearBuilt = url.YearBuilt>
</cfif>

<cfif IsDefined("url.City") and len(trim(url.City))>
  <cfset form.City = url.City>
</cfif>

<cfif IsDefined("url.County") and len(trim(url.County))>
  <cfset form.County = url.County>
</cfif>

<cfif IsDefined("url.PropertyType") and len(trim(url.PropertyType))>
  <cfset form.PropertyType = url.PropertyType>
</cfif>

<cfif IsDefined("url.Keyword") and len(trim(url.Keyword))>
  <cfset form.Keyword = url.Keyword>
</cfif>

<cfif IsDefined("url.Class") and len(trim(url.Class))>
  <cfset form.Class = url.Class>
</cfif>

<cfif IsDefined("url.PropertyUse") and len(trim(url.PropertyUse))>
  <cfset form.PropertyUse = url.PropertyUse>
</cfif>

<cfif IsDefined("url.ApproxAcreage") and len(trim(url.ApproxAcreage))>
  <cfset form.ApproxAcreage = url.ApproxAcreage>
</cfif>

<cfif IsDefined("url.Type") and len(trim(url.Type))>
  <cfset form.Type = url.Type>
</cfif>
<cfif IsDefined("url.MinimumSqft")>
  <cfset form.MinimumSqft = url.MinimumSqft>
</cfif>
<cfif IsDefined("url.MaximumSqft")>
  <cfset form.MaximumSqft = url.MaximumSqft>
</cfif>
<cfif IsDefined("url.DaysOnMarket")>
  <cfset form.DaysOnMarket = url.DaysOnMarket>
</cfif>

<cfif IsDefined("url.Foreclosure") and len(trim(url.Foreclosure))>
  <cfset form.Foreclosure = url.Foreclosure>
</cfif>

<cfif IsDefined("url.Zipcode") and len(trim(url.Zipcode))>
  <cfset form.Zipcode = url.Zipcode>
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

<cfif not isdefined ("Form.sortOrder")>
	<cfset form.sortorder="Price DESC"/>
	<cfset variables.sortorder=#form.sortorder#/>
</cfif>



<!--- Check for Pagination --->
<cfset form.pagination=false/>
<cfif isdefined("url.page")>
  <cfset form.pagination=true>
</cfif>
<cfset xlist="Class,Type,PropertyType,City,Zipcode,County,PropertyUse,MinimumPrice,MaximumPrice,MinAcres,MaxAcres,TotalBuildingSize,DaysOnMarket,YearBuilt,Foreclosure,Keyword">
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

<!---form prefill minimumRentalRate--->
<cfif isDefined("Form.minimumrentalrate")>
  <cfset CLIENT.minimumrentalrate = Form.minimumrentalrate>
  <cfset prefillminimumrentalrate = Form.minimumrentalrate>
  <cfelseif isDefined("CLIENT.lastminimumrentalrate")>
  <cfset prefillminimumrentalrate = CLIENT.lastminimumrentalrate>
  <cfelse>
  <cfset prefillminimumrentalrate = " ">
</cfif>

<!---form prefill maximumRentalRate--->
<cfif isDefined("Form.maximumrentalrate")>
  <cfset CLIENT.maximumrentalrate = Form.maximumPrice>
  <cfset prefillmaximumprice = Form.maximumrentalrate>
  <cfelseif isDefined("CLIENT.lastmaximumrentalrate")>
  <cfset prefillmaximumrentalrate = CLIENT.lastmaximumrentalrate>
  <cfelse>
  <cfset prefillmaximumrentalrate = " ">
</cfif>

<!---form prefill MinimumSqft--->
<cfif isDefined("Form.MinimumSqft")>
  <cfset CLIENT.MinimumSqft = Form.MinimumSqft>
  <cfset prefillMinimumSqft = Form.MinimumSqft>
  <cfelseif isDefined("CLIENT.lastMinimumSqft")>
  <cfset prefillMinimumSqft = CLIENT.lastMinimumSqft>
  <cfelse>
  <cfset prefillMinimumSqft = " ">
</cfif>

<!---form prefill MaximumSqft--->
<cfif isDefined("Form.MaximumSqft")>
  <cfset CLIENT.MaximumSqft = Form.MaximumSqft>
  <cfset prefillMaximumSqft = Form.MaximumSqft>
  <cfelseif isDefined("CLIENT.lastMaximumSqft")>
  <cfset prefillMaximumSqft = CLIENT.lastMaximumSqft>
  <cfelse>
  <cfset prefillMaximumSqft = " ">
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

<!---form prefill Class--->
<cfif isDefined("Form.Class")>
  <cfset CLIENT.Class = Form.Class>
  <cfset prefillClass = Form.Class>
  <cfelseif isDefined("CLIENT.lastClass")>
  <cfset prefillClass = CLIENT.lastClass>
  <cfelse>
  <cfset prefillClass = " ">
</cfif>

<!---form prefill County--->
<cfif isDefined("Form.County")>
  <cfset CLIENT.County = Form.County>
  <cfset prefillCounty = Form.County>
  <cfelseif isDefined("CLIENT.lastCounty")>
  <cfset prefillCounty = CLIENT.lastCounty>
  <cfelse>
  <cfset prefillCounty = " ">
</cfif>

<!---form prefill Zipcode--->
<cfif isDefined("Form.Zipcode")>
  <cfset CLIENT.Zipcode = Form.Zipcode>
  <cfset prefillZipcode = Form.Zipcode>
  <cfelseif isDefined("CLIENT.lastZipcode")>
  <cfset prefillZipcode = CLIENT.lastZipcode>
  <cfelse>
  <cfset prefillZipcode = " ">
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

<!---form prefill PropertyUse--->
<cfif isDefined("Form.PropertyUse")>
  <cfset CLIENT.PropertyUse = Form.PropertyUse>
  <cfset prefillPropertyUse = Form.PropertyUse>
  <cfelseif isDefined("CLIENT.lastPropertyUse")>
  <cfset prefillPropertyUse = CLIENT.lastPropertyUse>
  <cfelse>
  <cfset prefillPropertyUse = " ">
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

<!---form prefill TotalBuildingSize--->
<cfif structKeyExists(FORM, "TotalBuildingSize")>
  <cfset CLIENT.TotalBuildingSize = Form.TotalBuildingSize>
  <cfset variables.prefillTotalBuildingSize= Form.TotalBuildingSize>
  <cfelseif structKeyExists(CLIENT, "TotalBuildingSize")>
  <cfset variables.prefillTotalBuildingSize= CLIENT.lastTotalBuildingSize>
  <cfelse>
  <cfset variables.prefillTotalBuildingSize= " ">
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

<!---form prefill Keyword--->
<cfif isDefined("Form.Keyword")>
  <cfset CLIENT.Keyword = Form.Keyword>
  <cfset prefillKeyword = Form.Keyword>
  <cfelseif isDefined("CLIENT.lastKeyword")>
  <cfset prefillKeyword = CLIENT.lastKeyword>
  <cfelse>
  <cfset prefillKeyword = " ">
</cfif>





<cfquery name="Type" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT Type FROM listings
GROUP BY Type,Class DESC
</cfquery>
<cfquery name="City" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT City FROM listings 
ORDER BY City ASC
</cfquery>

<cfquery name="County" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT County FROM listings 
ORDER BY County ASC
</cfquery>

<cfquery name="Zipcode" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT Zipcode FROM listings 
ORDER BY Zipcode ASC
</cfquery>

<cfquery name="PropertyUse" datasource="commercial" cachedwithin="#createtimespan(0,0,30,0)#" >
SELECT DISTINCT PropertyUse FROM listings 
ORDER BY PropertyUse ASC
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
	
	if(arrayLen(arguments) gt 2) urlArgument = "... <a href=""" & arguments[3] & """>[More Info]</a>";

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

<cfinclude template="google-analytics.cfm">
<!-- Bootstrap CSS -->
<link href="/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="chosen/docsupport/prism.css">
<link rel="stylesheet" href="chosen/chosen.css">

<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
      <script src="js/html5.js"></script>
    <![endif]-->

<link rel="shortcut icon" href="img/favicon.ico">
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700,300|Rambla|Calligraffitti' rel='stylesheet' type='text/css'>

	
</head>

<body class="page page-features">
<div id="navigation" class="wrapper">
 <div class="navbar  navbar-static-top"> 
      
<cfinclude template="/headernav.cfm">

    
    
    <div id="content">
      <div class="container">
        

<div class="span12" style="height:40px;"></div>


<cfif result.RecordCount IS 0>
              <H3>NO SEARCH RESULTS FOUND.</H3>
			  
			  <div class="span12" style="height:40px;"></div>
              
              <cfelse>
			        
  
   <div class="row-fluid">
          
		
		  <div class="span9">
		  
		  
		  <div class="row-fluid">
		  
		  <div class="span6"><h4>Results:
              <cfoutput>#startRow# to
              <cfif startRowNext LTE listings.RecordCount>
                #EndRow#
                <cfelse>
                #listings.RecordCount#
              </cfif>
              of #listings.RecordCount# Properties</cfoutput>
    	
            </h4></div>
		  
		  <div class="span6">
		  <span class="pull-right">
		  <cfform name="f1">
		
          	<cfselect name="sortOrderPick" id="sortOrderPick" class="span12 chosen-select-no-single pull-right" onchange="document.getElementById('sortOrder').value = this.value;">
			<option value="Price ASC" <cfif comparenocase("Price ASC", form.sortorder) eq 0>selected</cfif>>PRICE > Low to High</option>
			<option value="Price DESC" <cfif comparenocase("Price DESC", form.sortorder) eq 0>selected</cfif>>PRICE < High to Low</option>
			<option value="County ASC" <cfif comparenocase("County ASC", form.sortorder) eq 0>selected</cfif>>COUNTY > Ascending</option>
			<option value="County DESC" <cfif comparenocase("County DESC", form.sortorder) eq 0>selected</cfif>>COUNTY < Descending</option>
			<option value="City ASC" <cfif comparenocase("City ASC", form.sortorder) eq 0>selected</cfif>>CITY > Ascending</option>
			<option value="City DESC" <cfif comparenocase("City DESC", form.sortorder) eq 0>selected</cfif>>CITY < Descending</option>
			<option value="Zipcode ASC" <cfif comparenocase("Zipcode ASC", form.sortorder) eq 0>selected</cfif>>ZIPCODE > Ascending</option>
			<option value="Zipcode DESC" <cfif comparenocase("Zipcode DESC", form.sortorder) eq 0>selected</cfif>>ZIPCODE < Descending</option>
		</cfselect>
             <cfset newLink = "#CGI.script_name#?Class=#Form.Class#&Type=#Form.Type#&PropertyType=#Form.PropertyType#&MinimumSqft=#Form.MinimumSqft#&MaximumSqft=#Form.MaximumSqft#&minimumPrice=#Form.minimumPrice#&maximumPrice=#Form.maximumPrice#&TotalBuildingSize=#Form.TotalBuildingSize#&MinAcres=#Form.MinAcres#&MaxAcres=#Form.MaxAcres#&City=#Form.City#&Zipcode=#Form.Zipcode#&County=#Form.County#&Foreclosure=#Form.Foreclosure#&Keyword=#Form.Keyword#&sortOrder="/>
		<cfinput name="triggerBtn" type="button" class="btn-sort btn-primary" value="SORT"
		onclick="window.location.href='#newLink#'+ document.getElementById('sortOrderPick').value;">
		</cfform>
		</span>
		</div>
		

		  </div>
		

    		
            <cfif result.RecordCount IS 0>
              <h3>NO SEARCH RESULTS</h3>
              <cfelse>
              <cfloop query="listings" startrow="#url.startRow#" endRow="#endRow#">
              <cfset trendStruct = createObject ("component","cfcs.usrService").getPriceTrend(trim(listid))/>
              <cfoutput>
    		  <cfdirectory action="list" directory="#ExpandPath('/uploads/photos/thumbs/')#/#ListID#" name="pics">
              <cfif DaysOnMarket lte '8' ><div class="hoverdivNew"><cfelse><div class="hoverdiv"></cfif>
			   <div class = "bottom-right hidden-phone"><a href="/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#St#.html" 
			   class="btn btn-small btn-primary pull-right">View Full Listing &nbsp; <i class=" icon-circle-arrow-right"></i></a></div>
                <div class="row-fluid">
                  <div class="span3"> <a href="/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#St#.html">
                  <img src="../../uploads/photos/resized/#ListID#/#ListFirst(pics.Name)#" class="imageClip" onerror="this.src='https://commercial.fickling.com/img/no-photo-sm.png';"></a> </div>
                  
                  <div class="span9">        
                   <cfif HidePrice IS NOT "1">
                  <a id="pop" href="##" data-toggle="popover" data-content="#trendStruct.details#">  <span class="price">#RemoveChars(DollarFormat(Price),Len(DollarFormat(Price))-2,3)#</span>  
				  <img src="/img/#trendStruct.trend#.png" width="30" height="30" style="display:inline-block;" title="#trendStruct.trend# #trendStruct.details#" alt="#trendStruct.trend# #trendStruct.details#"/></a>
                   <cfelse><span class="price">Contact Agent For Price. &nbsp; &nbsp;</span></cfif>
                  
                  <a href= "/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#State#.html"> 
                  <span class="address">#AddressNumber# #AddressStreet#</a> - #City#, #State# #Zipcode#</span> 
				 
                  <span class="hoverdivFeatures">

                    <cfif #Remarks# IS "">
                      <p>&nbsp;</p>
                      <br>
                      <cfelse>
                      <p>#FormatTeaser(Remarks,90,"/#urlencodedformat(trim(ListID))#/#StrNumber#-#StrName#-#Cty#-#State#.html")#</p>
                    </cfif>
                   
    		   
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
          
        <div class="span3">
            <div class="row-fluid">
			
			<div class="btn-group pull-right"> 
			<cfif IsUserLoggedIn()>
			<a href="##myModalSavedSearch" role="button" class="btn " data-toggle="modal"> <i class="icon-star"></i> Save Search </a>
			</cfif>
			<cfoutput><a href="/search-map.cfm?quickMap=Yes&#session.searchstring#" class="btn" target="_blank"><i class="icon-map-marker"></i> Map Results</a></cfoutput>
			</div>
			
			 
			 
               <cfinclude template="searchsidebar.cfm">
				

            </div>
        </div> <!---CLOSE SPAN4 DIV--->
    </div>
</div>
<!---CLOSE ROW DIV--->
</cfif>

</div>
<!---CLOSE CONTAINER DIV--->
</div>
<!---CLOSE CONTENT DIV--->

</div>

<cfinclude template="/footer.cfm">



<!-- Modal SavedSearch -->
<div id="myModalSavedSearch" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

  <div class="modal-header hidden-phone">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
    <h3 id="myModalLabel">saved search</h3>
  </div>
  
<div class="modal-body">
    
	
	<cfparam name="session.pk_usr" default="">
		<cfparam name="session.searchstring" default="">
		<cfparam name="session.searchname" default="">
        
		<!---<cfif isNumeric(session.pk_usr)>--->
        <cfif IsUserLoggedIn()>
        	
        <h4 class="title-divider"><span><i class="icon-star"></i> Save <span class="de-em">This Search</span></span></h4>	
		<IFRAME name="hide" id="hide" style="display:none;height:0;width:0;"></IFRAME>
			<cfif len(trim(session.searchstring))>
			<cfoutput>
			<form action="/searchsave.cfm" target="hide" method="post">
			<input type="text" name="Searchname" value="#session.Searchname#"> Search Name
			<!--- &nbsp;&nbsp;&nbsp;
			<input type="checkbox" name="SearchDefault" value="1">Make Default
			&nbsp;&nbsp;&nbsp; --->
			<input type="submit" value="Save This Search" class="btn btn-primary btn-block" /> 
			</form>	
			</cfoutput>	
			<hr class="line" />
			<br />
			</cfif>
			<cfparam name="url.searchaction" default="">
			<cfparam name="url.searchID" default="">
			
			<cfif url.searchaction is "deletesavedsearch" and isNumeric(url.SearchID)>
			<cfquery datasource="commercial">
			DELETE FROM Saved_Search
			WHERE SearchID = #Url.SearchID#
			</cfquery>
			<cfquery datasource="commercial">			
			UPDATE Saved_Search
			SET SearchDefault = 1
			Where UserID = #session.pk_usr# 
			Order by SearchDate desc
			Limit 1				
			</cfquery>
			</cfif>
			<cfquery datasource="commercial" name="SavedResults">
			Select SearchID,Searchname,SearchDefault,Searchstring
			From saved_Search
			Where UserID = #session.pk_usr#
			Order by <!--- case when SearchDefault = 1 then 1 else 2 end, --->Searchname
			</cfquery>			
			<cfif SavedResults.recordcount>
			<div style="padding-left:5px;">
			<b>Saved Searches</b><br>
			<table>
			</cfif>
			<cfoutput query="SavedResults">
				<tr>
				<td align="left" style="padding-left:15px;"><a href="results.cfm?#SavedResults.Searchstring#" style="font-weight:bold;">#SavedResults.Searchname#</a> - </td>
				
				<td align="left"><a href="#cgi.script_name#?searchaction=deletesavedsearch&SearchID=#SavedResults.SearchID#" title="Delete #SavedResults.Searchname#"
					> <i class="icon-trash"></i></a></td>			
				</tr>
			</cfoutput>			
			<cfif SavedResults.recordcount>
			</table>
			</div>
			<hr class="line" />
			<br>
			</cfif>	
            
		</cfif>	
	
	
</div>


  
  <div class="modal-footer">
  
  
 
  </div>
</div>

<!-- END Modal SavedSearch -->




  
<!--Scripts --> 
<cfinclude template="/js/scripts.cfm">
<script src="/chosen/chosen.jquery.js" type="text/javascript"></script>
<script src="/chosen/docsupport/prism.js" type="text/javascript" charset="utf-8"></script>


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
	  $(".chosen-select").chosen('destroy');
	  $(".chosen-select").chosen({width: "100%"});
	  $('.chosen-container .chosen-results').on('touchend', function(event) {
    event.stopPropagation();
    event.preventDefault();
    return;
});
    }
</script>
<script type="text/javascript">
		$(function() {
		$(".tip").tooltip();
		});
	</script>


</body>
</html>
</cfprocessingdirective>