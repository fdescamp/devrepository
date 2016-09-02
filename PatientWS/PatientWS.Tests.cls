Class PatientWS.Tests Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION = "PatientWS.Production";
Parameter IGNOREPRODUCTIONERRORS = 1;

Method TestPatientWSOperation()
{
	Set Name="PatientWS.BusinessOperation"
	
	//Test Patient Exists
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=1	
	//Set tSC = ##Class(EnsLib.Testing.Service).SendTestRequest(Name, tRequest, .tResponse, .tSessionID)
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	do $$$AssertEquals(tResponse.Exists,1, "PatientID 1 exists in DB")
	
	//Test Patient does not Exist
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=2	
	//Set tSC = ##Class(EnsLib.Testing.Service).SendTestRequest(Name, tRequest, .tResponse, .tSessionID)
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	do $$$AssertEquals(tResponse.Exists,0, "PatientID 2 does not exist in DB")
}

Method OnAfterProductionStart() As %Status
{
		set tSC=$$$OK
		Set tSC = ..TestPatientWSOperation()
		
		Quit tSC
}


}