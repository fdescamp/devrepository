Class PatientWS.Message.PatientResponse Extends Ens.Response
{

Property Exist As %Boolean;

Storage Default
{
<Data name="PatientResponseDefaultData">
<Subscript>"PatientResponse"</Subscript>
<Value name="1">
<Value>Exist</Value>
</Value>
</Data>
<DefaultData>PatientResponseDefaultData</DefaultData>
<Type>%Library.CacheStorage</Type>
}

}
