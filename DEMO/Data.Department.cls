/// InterSystems Department
Class Data.Department Extends (%Persistent, %ZEN.DataModel.Adaptor)
{

Property DepartmentName As %String [ Required ];

Storage Default
{
<Data name="DepartmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DepartmentName</Value>
</Value>
</Data>
<DataLocation>^Data.DepartmentD</DataLocation>
<DefaultData>DepartmentDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Data.DepartmentD</IdLocation>
<IndexLocation>^Data.DepartmentI</IndexLocation>
<StreamLocation>^Data.DepartmentS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
