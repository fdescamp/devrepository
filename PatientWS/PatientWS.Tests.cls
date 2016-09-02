Class PatientWS.Tests Extends %UnitTest.TestCase
{

Method TestPatientWSOperation()
{
	//Test Patient Exists
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=1	
	Set tSC = ##Class(EnsLib.Testing.Service).SendTestRequest(Name, tRequest, .tResponse, .tSessionID)
	do $$$AssertEquals(tResponse.Exists,1, "PatientID 1 exists in DB")
	
	//Test Patient does not Exist
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=2	
	do $$$AssertEquals(tResponse.Exists,0, "PatientID 2 does not exist in DB")
}




}