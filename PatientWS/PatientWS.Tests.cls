Class PatientWS.Tests Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION = "PatientWS.Production";

Parameter IGNOREPRODUCTIONERRORS = 1;

Method OnBeforeProductionStart() As %Library.Status
{
	Set ..MainDir = "C:\Tutorial"
	
	//Change Setting parameter on Business Operation to use mock service
	Set tSC = ..ChangeSetting("PatientWS.Production","PatientWS.BusinessOperation", "HTTPPort","8082",0)	
	Do $$$AssertEquals(tSC,$$$OK)
	Set tSC = ..ChangeSetting("PatientWS.Production","PatientWS.BusinessOperation", "URL","/REST/PatientExist/Patients",0)	
	Do $$$AssertEquals(tSC,$$$OK)
	
	if 'tSC {Quit ..Error("Error in OnBeforeProductionStart()")}
	
	Quit $$$OK
}

Method TestPatientWSOperation()
{
	
	
	//Test Patient Exists
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=1	
	//Set tSC = ##Class(EnsLib.Testing.Service).SendTestRequest(Name, tRequest, .tResponse, .tSessionID)
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	if 'tSC {Quit ..Error("Error in TestPatientWSOperation Patient Exist")}
	do $$$AssertEquals(tResponse.Exist,1, "PatientID 1 exists in DB")
	
	//Test Patient does not Exist
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=2	
	//Set tSC = ##Class(EnsLib.Testing.Service).SendTestRequest(Name, tRequest, .tResponse, .tSessionID)
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	if 'tSC {Quit ..Error("Error in TestPatientWSOperation Patient does not Exist")}
	do $$$AssertEquals(tResponse.Exist,0, "PatientID 2 does not exist in DB")
}

Method OnAfterProductionStart() As %Status
{
		set tSC=$$$OK
		Set tSC = ..TestPatientWSOperation()
		
		Quit tSC
}

}
