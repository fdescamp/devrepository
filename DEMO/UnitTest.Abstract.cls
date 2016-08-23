/// This is an abstract Requirement class.
/// Requirement implement classic Cache's %UnitTest functionality.
/// Also it may be runned through web browser.
/// Each requirement may also be represented as a CSP page.
/// After execution, requirement results are stored in ^UnitTest.Result global.
Class UnitTest.Abstract Extends (%UnitTest.TestCase, %CSP.Page)
{

/// This Parameter is updated by Perforce
Parameter SrcVer = "$Id: //trak/main/DEV/internal/cls/UnitTest/Abstract.xml#3 $";

/// Your test title
Parameter TITLE As %String;

/// This method is used to display a test page.
ClassMethod OnPage() As %Status [ ServerOnly = 1 ]
{
	do ##class(UnitTest.Formatter).Run(..%ClassName(1))
	Quit $$$OK
}

/// Run this specific test (in debug mode)
ClassMethod Run(qualifiers As %String = "") As %Status [ ProcedureBlock = 1 ]
{
	set sc=##class(UnitTest.Manager).RunTest(..%ClassName(1),"/recursive=0"_qualifiers)
	quit sc
}

/// Run this test and all its children
ClassMethod RunRecursive(qualifiers As %String = "") As %Status [ ProcedureBlock = 1 ]
{
	set sc=##class(UnitTest.Manager).RunTest(..%ClassName(1),"/recursive=1"_qualifiers)
	quit sc
}

/// Log execution HTML result. Now it is stored as a log message.
Method LogResult(result)
{
	set oldDisplay=..Manager.Display
	set ..Manager.Display=""
	do ..LogMessage($g(result))
	set ..Manager.Display=oldDisplay
	quit
}

/// Get last test result instance id, dateTime, status, duration and HTML
/// All this information is stored in ^UnitTest.Result
ClassMethod GetLastResult(ByRef dateTime, ByRef status, ByRef duration, ByRef html, ByRef suite) As %String [ ProcedureBlock = 1 ]
{
	set (dateTime,status,duration,html,suite)=""
	set name=..%ClassName(1)
	&sql(select Duration, TestSuite->TestInstance, TestSuite->Name, TestSuite->TestInstance->DateTime
		into :qDuration, :qInstance, :qSuite, :qDateTime
		from %IGNOREINDICES %UnitTest_Result.TestCase.idxName %UnitTest_Result.TestCase
		where Name=:name
		order by TestSuite->TestInstance DESC)
	if SQLCODE quit ""
	set dateTime=qDateTime
	set duration=qDuration
	set status=##class(%UnitTest.Report).GetTestStatus($znspace, qInstance, qSuite, name)
	set htmlIndex=$o(^UnitTest.Result(qInstance, qSuite, name, "TestRequirement",""),-1)-1
	set html=$lg($g(^UnitTest.Result(qInstance, qSuite, name, "TestRequirement",htmlIndex)),3)
	set suite=qSuite
	quit qInstance
}

}
