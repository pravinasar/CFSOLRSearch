<CFPROCESSINGDIRECTIVE SUPPRESSWHITESPACE="Yes"><cfoutput>

<cfset form.minimumprice = rereplace(form.minimumprice, "[^0-9\.]", "", "all")>
<cfset form.maximumprice = rereplace(form.maximumprice, "[^0-9\.]", "", "all")>
<cfset form.MaxAcres = rereplace(form.MaxAcres, "[^0-9\.]", "", "all")>
<cfset form.MinAcres = rereplace(form.MinAcres, "[^0-9\.]", "", "all")>

<cfquery name="listings" datasource="commercial" result="result">
SELECT 
listings.ListID,
listings.Status,
listings.Class,
listings.Remarks,
COALESCE(YearBuilt,0)AS YearBuilt,
COALESCE(TotalBuildingSize,0)AS TotalBuildingSize,
listings.Price,
listings.HidePrice,
listings.Type,
listings.PropertyUse,
listings.AddressNumber,
listings.approxacreage,
listings.AddressStreet,
listings.City,
listings.County,
listings.State,
listings.Zipcode,
listings.DaysOnMarket,
listings.Foreclosure,
listings.ListDate,
spaces.ListID,
spaces.Class,
spaces.RentalRate,
spaces.RentalRateMin,
spaces.SpaceType,
spaces.RentalPeriod,
spaces.SpaceStatus,
seo.ListID,
seo.StrNumber,
seo.StrName,
seo.Cty,
seo.St 
FROM listings 
INNER JOIN seo on listings.Listid = seo.Listid
LEFT JOIN fagents ON listings.Agent = fagents.Agent
LEFT JOIN fcoagents ON listings.CoAgent = fcoagents.CoAgent
LEFT JOIN  spaces on listings.Listid = spaces.Listid
WHERE (Status = "Active" OR Status = "Pending")
<cfif getfilefrompath(getbasetemplatepath()) is "searchemail.cfm">
and DaysOnMarket <= 1
</cfif>

<!---Search by Class--->
<cfif StructKeyExists(form,"Class") and len(trim(form.Class))>
AND listings.Class = "#form.Class#"
</cfif>

<!---Search by Type--->
<cfif StructKeyExists(form,"Type") and listLen(trim(form.Type), ",")>
 AND Type IN 
        (
             <cfqueryparam value="#form.Type#" 
                   cfsqltype="cf_sql_varchar" 
                   list="true" 
                   separator=",">
     )
</cfif>

<!---Search by PropertyUse--->
<cfif StructKeyExists(form,"PropertyUse") and listLen(trim(form.PropertyUse), ",")>
 AND PropertyUse IN 
        (
             <cfqueryparam value="#form.PropertyUse#" 
                   cfsqltype="cf_sql_varchar" 
                   list="true" 
                   separator=",">
     )
</cfif>

<!---Search by Zipcode--->
<cfif StructKeyExists(form,"Zipcode") and listLen(trim(form.Zipcode), ",")>
 AND Zipcode IN 
        (
             <cfqueryparam value="#form.Zipcode#" 
                   cfsqltype="cf_sql_varchar" 
                   list="true" 
                   separator=",">
     )
</cfif>


<!---Search by County--->
<cfif StructKeyExists(form,"County") and listLen(trim(form.County), ",")>
 AND County IN 
        (
             <cfqueryparam value="#form.County#" 
                   cfsqltype="cf_sql_varchar" 
                   list="true" 
                   separator=",">
     )
</cfif>


<!---Search by City--->
<cfif StructKeyExists(form,"City") and listLen(trim(form.City), ",")>
 AND City IN 
        (
             <cfqueryparam value="#form.City#" 
                   cfsqltype="cf_sql_varchar" 
                   list="true" 
                   separator=",">
     )
</cfif>


<!---Search by Price--->
<cfif StructKeyExists(form,minimumprice) and listLen(trim(form.minimumprice))>
<cfset form.minimumprice = rereplace(form.minimumprice, "[^0-9\.]", "", "all")>
</cfif>
<cfif StructKeyExists(form,maximumprice) and listLen(trim(form.maximumprice))>
<cfset form.maximumprice = rereplace(form.maximumprice, "[^0-9\.]", "", "all")>
</cfif>

<cfif isNumeric(form.minimumprice) AND isNumeric(form.maximumprice)>
AND listings.Price BETWEEN #form.minimumprice# AND #form.maximumprice#
<cfelseif isNumeric(form.minimumprice) AND NOT isNumeric(form.maximumprice)>
AND listings.Price >= #form.minimumprice#
<cfelseif isNumeric(form.maximumprice) AND NOT isNumeric(form.minimumprice)>
AND listings.Price <= #form.maximumprice#
</cfif>


<!---Search by SQFT--->
<cfif StructKeyExists(form,MinimumSqft) and listLen(trim(form.MinimumSqft))>
<cfset form.MinimumSqft = rereplace(form.MinimumSqft, "[^0-9\.]", "", "all")>
</cfif>
<cfif StructKeyExists(form,MaximumSqft) and listLen(trim(form.MaximumSqft))>
<cfset form.MaximumSqft = rereplace(form.MaximumSqft, "[^0-9\.]", "", "all")>
</cfif>

<cfif isNumeric(form.MinimumSqft) AND isNumeric(form.MaximumSqft)>
AND listings.TotalBuildingSize BETWEEN #form.MinimumSqft# AND #form.MaximumSqft#
<cfelseif isNumeric(form.MinimumSqft) AND NOT isNumeric(form.MaximumSqft)>
AND listings.TotalBuildingSize >= #form.MinimumSqft#
<cfelseif isNumeric(form.MaximumSqft) AND NOT isNumeric(form.MinimumSqft)>
<cfset form.MinimumSqft = 1>
AND listings.TotalBuildingSize <= #form.MaximumSqft#
</cfif>


<!---Search by Acreage--->
<cfset form.MaxAcres = rereplace(form.MaxAcres, "[^0-9\.]", "", "all")>
<cfset form.MinAcres = rereplace(form.MinAcres, "[^0-9\.]", "", "all")>

<cfif isNumeric(form.MinAcres) AND isNumeric(form.MaxAcres)>
AND listings.TotalLotSize BETWEEN #form.MinAcres# AND #form.MaxAcres#
<cfelseif isNumeric(form.MinAcres)>
AND listings.TotalLotSize >= #form.MinAcres#
<cfelseif isNumeric(form.MaxAcres)>
<cfset form.MinAcres = 0>
AND listings.TotalLotSize BETWEEN #form.MinAcres# AND #form.MaxAcres#
</cfif>


<!---Search by keywords--->
<cfif StructKeyExists(form,"Keyword") and len(trim(form.Keyword))>
AND
(
MATCH(listings.Class,listings.Type,listings.SubType,listings.PropertyName,listings.Highlights,listings.Remarks,listings.Agent,listings.AddressNumber,listings.AddressStreet,listings.Zipcode) AGAINST('#form.Keyword#' IN BOOLEAN MODE)
OR
MATCH(AgentFName,AgentLName,AgentEmail) AGAINST('#form.Keyword#' IN BOOLEAN MODE)
OR
MATCH(CoAgentFName,CoAgentLName,CoAgentEmail) AGAINST('#form.Keyword#' IN BOOLEAN MODE)
)
</cfif>

Group BY listings.ListID

<cfif StructKeyExists(form,"SortOrder")>
ORDER BY #form.sortorder#
<cfelse>
ORDER BY Price ASC
</cfif> 

</cfquery>

</cfoutput></CFPROCESSINGDIRECTIVE>