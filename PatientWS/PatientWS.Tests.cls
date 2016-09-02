Class PatientWS.Tests Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION = "PatientWS.Production";

Parameter IGNOREPRODUCTIONERRORS = 1;

Method OnBeforeProductionStart() As %Library.Status
{
	Set ..MainDir = "C:\Tutorial"
	
	//Check namespace - if "DEVBUILD" do not use mock services and use settings defined in sys default settings

	//Change Setting parameter on Business Operation WS to use mock service
	Do ..LogMessage("NAMESPACE="_$NAMESPACE)
	if ($NAMESPACE'="DEVBUID")
	{
		Set tSC = ..ChangeSetting("PatientWS.Production","PatientWS.BusinessOperation", "HTTPPort","8082",0)	
		Do $$$AssertEquals(tSC,$$$OK)
		Set tSC = ..ChangeSetting("PatientWS.Production","PatientWS.BusinessOperation", "URL","/REST/PatientExist/Patients",0)	
		Do $$$AssertEquals(tSC,$$$OK)
	}
	
	
	
	
	if 'tSC {Quit ..Error("Error in OnBeforeProductionStart()")}
	
	Quit $$$OK
}


Method OnAfterProductionStart() As %Status
{
	Set tSC=$$$OK
	
	//Log Settings
	set tSC=..GetSetting("PatientWS.Production","PatientWS.BusinessOperation","URL",.value)
	Do ..LogMessage("URL="_value)
	set tSC=..GetSetting("PatientWS.Production","PatientWS.BusinessOperation","HTTPPort",.value)
	Do ..LogMessage("HTTPPort="_value)
	
	//Test PatientWS Business Operation
	//Test Patient Exists
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=1	
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	if 'tSC {Quit ..Error("Error in TestPatientWSOperation Patient Exist")}
	do $$$AssertEquals(tResponse.Exist,1, "PatientID 1 exists in DB")
	
	//Test Patient does not Exist
	set tRequest=##class(PatientWS.Message.PatientRequest).%New()
	set tRequest.PatientID=2	
	Set tSC = ..SendRequest( "PatientWS.BusinessOperation" ,tRequest,.tResponse,1,40)
	if 'tSC {Quit ..Error("Error in TestPatientWSOperation Patient does not Exist")}
	do $$$AssertEquals(tResponse.Exist,0, "PatientID 2 does not exist in DB")
	
	//Test PatientSQL Business Operation
	//Test Patient Insert

	//Test Patient Select
		
	Quit tSC

}

}
