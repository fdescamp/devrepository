Class MyPackage.Contact Extends (%Persistent, %Populate, %XML.Adaptor)
{

/// Describes the nature of the contact: Personal or Business
Property ContactType As %String(TRUNCATE = 1, VALUELIST = ",Business,Personal");

/// Represents a contact's name
Property Name As %String(POPSPEC = "Name()", TRUNCATE = 1) [ Required ];

Query ByContactType(type As %String) As %SQLQuery(CONTAINID = 1)
{
SELECT %ID FROM Contact
 WHERE (ContactType = :type)
 ORDER BY Name
}

Storage Default
{
<Data name="ContactDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>ContactType</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
</Data>
<DataLocation>^MyPackage.ContactD</DataLocation>
<DefaultData>ContactDefaultData</DefaultData>
<IdLocation>^MyPackage.ContactD</IdLocation>
<IndexLocation>^MyPackage.ContactI</IndexLocation>
<Property name="ContactType"/>
<Property name="Name"/>
<StreamLocation>^MyPackage.ContactS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
