/// We want to report conflicts for every session that is run the same day, same room
/// and same time as anouther session of Summit.
Class UnitTest.Summit.SessionTimeConflict Extends UnitTest.Transaction
{

Parameter TITLE = "Session Time Conflicts";

/// Test two non-intersecting sessions same day and same room
Method TestSameDaySameRoomDiffTime() As %Status
{
	set Room=##class(UnitTest.Factory).Add("Data.Room")
	set Session1=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("9:00")),
		$lb("SessionEndTime",$zth("10:00")),
	))

	set Session2=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("11:00")),
		$lb("SessionEndTime",$zth("12:00")),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session1),"","No conflicts for this setup")
	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session2),"","No conflicts for this setup")

	quit $$$OK
}

/// Test two intersecting sessions same day and same room
Method TestSameDaySameRoomIntersectTime() As %Status
{
	set Room=##class(UnitTest.Factory).Add("Data.Room")
	set Session1=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("9:00")),
		$lb("SessionEndTime",$zth("11:00")),
	))

	set Session2=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("10:00")),
		$lb("SessionEndTime",$zth("12:00")),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session1),1,"One conflict for this setup")
	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session2),1,"One conflict for this setup")

	quit $$$OK
}

/// Test two intersecting sessions different day and same room
Method TestDiffDaySameRoomIntersectTime() As %Status
{
	set Room=##class(UnitTest.Factory).Add("Data.Room")
	set Session1=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("9:00")),
		$lb("SessionEndTime",$zth("11:00")),
	))

	set Session2=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room),
		$lb("SessionDate",$zdh("01/02/2013")),
		$lb("SessionStartTime",$zth("10:00")),
		$lb("SessionEndTime",$zth("12:00")),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session1),"","No conflicts for this setup")
	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session2),"","No conflicts for this setup")

	quit $$$OK
}

/// Test two intersecting sessions same day and different room
Method TestSameDayDiffRoomIntersectTime() As %Status
{
	set Room1=##class(UnitTest.Factory).Add("Data.Room")
	set Room2=##class(UnitTest.Factory).Add("Data.Room")
	set Session1=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room1),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("9:00")),
		$lb("SessionEndTime",$zth("11:00")),
	))

	set Session2=##class(UnitTest.Factory).Add("Data.Session",$lb(
		$lb("SessionRoom",Room2),
		$lb("SessionDate",$zdh("01/01/2013")),
		$lb("SessionStartTime",$zth("10:00")),
		$lb("SessionEndTime",$zth("12:00")),
	))

	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session1),"","No conflicts for this setup")
	do $$$AssertEquals(##class(Data.Session).GetConflictCount(Session2),"","No conflicts for this setup")

	quit $$$OK
}

}
