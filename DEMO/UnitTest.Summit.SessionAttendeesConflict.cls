/// Make sure that all attendees fit into room
Class UnitTest.Summit.SessionAttendeesConflict Extends UnitTest.Transaction
{

Parameter TITLE = "Session Attendees Conflicts";

// test 2

/// Test that conflict is reported when attendees don't fit into room
Method TestAttendeesNotFit() As %Status
{
	set RoomID=##class(UnitTest.Factory).Add("Data.Room",$lb(
		$lb("RoomCapacity",10),
	))
	
	set SessionID=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",RoomID),
		$lb("SessionAttendees",11),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(SessionID),1,"One conflict for this setup")

	quit $$$OK
}

/// Test that conflict is not reported if it's enough room for all
Method TestEnoughRoom() As %Status
{
	set RoomID=##class(UnitTest.Factory).Add("Data.Room",$lb(
		$lb("RoomCapacity",10),
	))
	
	set SessionID=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",RoomID),
		$lb("SessionAttendees",9),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(SessionID),"","No conflict for this setup")

	quit $$$OK
}

}
