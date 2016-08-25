Class Demo.Patient Extends %Persistent
{

Property PatientID As %Library.String;

Property FirstName As %Library.String;

Property LastName As %Library.String;

Property DOB As %Library.String;

Storage Default
{
<Data name="PatientDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PatientID</Value>
</Value>
<Value name="3">
<Value>FirstName</Value>
</Value>
<Value name="4">
<Value>LastName</Value>
</Value>
<Value name="5">
<Value>DOB</Value>
</Value>
</Data>
<DataLocation>^Demo.PatientD</DataLocation>
<DefaultData>PatientDefaultData</DefaultData>
<IdLocation>^Demo.PatientD</IdLocation>
<IndexLocation>^Demo.PatientI</IndexLocation>
<StreamLocation>^Demo.PatientS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
