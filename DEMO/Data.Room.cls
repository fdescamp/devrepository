/// A room to make presentation at
Class Data.Room Extends (%Persistent, %ZEN.DataModel.Adaptor)
{

Property RoomName As %String(ZENLABEL = "Room Name") [ Required ];

Property RoomCapacity As %Integer(ZENLABEL = "Room Capacity, ppl");

Storage Default
{
<Data name="RoomDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RoomName</Value>
</Value>
<Value name="3">
<Value>RoomCapacity</Value>
</Value>
</Data>
<DataLocation>^Data.RoomD</DataLocation>
<DefaultData>RoomDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Data.RoomD</IdLocation>
<IndexLocation>^Data.RoomI</IndexLocation>
<StreamLocation>^Data.RoomS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
