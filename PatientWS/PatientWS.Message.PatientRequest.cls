Class PatientWS.Message.PatientRequest Extends Ens.Request
{

Property PatientID As %String;

Storage Default
{
<Data name="PatientRequestDefaultData">
<Subscript>"PatientRequest"</Subscript>
<Value name="1">
<Value>PatientID</Value>
</Value>
</Data>
<DefaultData>PatientRequestDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
}

}
