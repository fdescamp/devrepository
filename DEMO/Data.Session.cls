/// Conference Session
Class Data.Session Extends (%Persistent, %ZEN.DataModel.Adaptor)
{

Property SessionName As %String(ZENLABEL = "Session Name") [ Required ];

Property SessionRoom As Data.Room(ZENLABEL = "Room", ZENSQL = "SELECT ID,RoomName from Data.Room") [ Required ];

Property SessionPresenter As Data.Presenter(ZENLABEL = "Presenter", ZENSQL = "SELECT ID,PresenterName,PresenterDepartment->DepartmentName from Data.Presenter") [ Required ];

Property SessionDate As %Date(ZENCONTROL = "dateText", ZENLABEL = "Date");

Property SessionStartTime As %Time(ZENLABEL = "Start Time");

Property SessionEndTime As %Time(ZENLABEL = "End Time");

Property SessionAttendees As %Integer(ZENLABEL = "Number Of Attendees");

Property ConflictCount As %Integer(ZENHIDDEN = 1) [ Calculated, SqlComputeCode = {set {*}=##class(Data.Session).GetConflictCount({ID})}, SqlComputed ];

Property ConflictHtml As %String(ZENATTRS = "rows:10|cols:40|controlClass:conflict", ZENCONTROL = "textarea", ZENLABEL = "Conflicts", ZENREADONLY = 1) [ Calculated ];

/// Get list of conflicts given object ID 
ClassMethod GetConflictsById(pId As %String) As %List
{
	if pId="" quit ""
	set conflictList=""
	set conflictList=conflictList_..GetTimeConflicts(pId)
	quit conflictList
}

/// Get time conflicts. Happens when one session overlaps
/// with another session scheduled for the same room
ClassMethod GetTimeConflicts(pId As %String) As %List
{
	set conflictList=""
	set roomId=..SessionRoomGetStored(pId)
	set date=..SessionDateGetStored(pId)
	set startTime=..SessionStartTimeGetStored(pId)
	set endTime=..SessionEndTimeGetStored(pId)
	
	&sql(declare GTC1 cursor for
		select SessionName into :conflictSessionName
		from Data.Session
		where SessionRoom=:roomId
			and SessionDate=:date
			and SessionStartTime<:endTime 
			and SessionEndTime>:startTime
			and ID<>:pId
	)
	&sql(open GTC1)
	for {
		&sql(fetch GTC1)
		quit:SQLCODE
		set conflictList=conflictList_$lb("Time overlaps with "_conflictSessionName)
	}
	&sql(close GTC1)
	quit conflictList
}

/// ConflictCount property calculation
Method ConflictCountGet() As %Integer [ CodeMode = expression ]
{
..GetConflictCount(..%Id())
}

/// ConflictHtml property calculation. Return list of conflicts as a string
Method ConflictHtmlGet() As %Integer [ CodeMode = expression ]
{
$listtostring(..GetConflictsById(..%Id()),$c(13,10))
}

/// Get conflict count
ClassMethod GetConflictCount(pId As %String) As %Integer
{
	set conflicts=..GetConflictsById(pId)
	if conflicts="" quit ""
	quit $listlength(conflicts)
}

Storage Default
{
<Data name="SessionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>SessionName</Value>
</Value>
<Value name="3">
<Value>SessionPresenter</Value>
</Value>
<Value name="4">
<Value>SessionDate</Value>
</Value>
<Value name="5">
<Value>SessionStartTime</Value>
</Value>
<Value name="6">
<Value>SessionEndTime</Value>
</Value>
<Value name="7">
<Value>SessionRoom</Value>
</Value>
<Value name="8">
<Value>SessionAttendees</Value>
</Value>
</Data>
<DataLocation>^Data.SessionD</DataLocation>
<DefaultData>SessionDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Data.SessionD</IdLocation>
<IndexLocation>^Data.SessionI</IndexLocation>
<StreamLocation>^Data.SessionS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
