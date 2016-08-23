/// Person making one or more session presentations
Class Data.Presenter Extends (%Persistent, %ZEN.DataModel.Adaptor)
{

Property PresenterName As %String(ZENLABEL = "Name") [ Required ];

Property PresenterDepartment As Data.Department(ZENLABEL = "Department", ZENSQL = "SELECT ID,DepartmentName from Data.Department") [ Required ];

Storage Default
{
<Data name="PresenterDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>PresenterName</Value>
</Value>
<Value name="3">
<Value>PresenterDepartment</Value>
</Value>
</Data>
<DataLocation>^Data.PresenterD</DataLocation>
<DefaultData>PresenterDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Data.PresenterD</IdLocation>
<IndexLocation>^Data.PresenterI</IndexLocation>
<StreamLocation>^Data.PresenterS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
