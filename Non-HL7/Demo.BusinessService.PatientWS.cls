Class Demo.BusinessService.PatientWS extends  EnsLib.REST.Service {

Parameter ADAPTER = "EnsLib.HTTP.InboundAdapter";

Parameter EnsServicePrefix = "|Patients";

XData UrlMap
{
<Routes>
<Route Url="/PatientID/:ID" Method="GET" Call="findpatient"/>
</Routes>
}

/// 
/// This method returns 1 if the patient is found in the database and 0 if not
/// 
/// URL to test: http://localhost:9980/Patients/PatientID/1234 
/// Business Service must be started
/// Via Private Apache: http://localhost:57775/Rest/Demo.BusinessService.PatientWS/Patients/PatientID/1234
///  -> Requires definition of WebApplication

Method findpatient(pInput As %Library.AbstractStream, Output pOutput As %Stream.Object, ID As %Library.String) As %Status
{
	$$$TRACE("FindPatient: "_ID)
	set tSC = $$$OK
	try {
		
		&SQL(select count(*) into :count from Demo.Patient where PatientID=:ID)
		$$$TRACE("Found PatientID:"_count)
		
		do pOutput.SetAttribute("Content-Type","text/xml")
 	 		
 		Set tOut=##class(%IO.StringStream).%New()
 		do tOut.Write("<patientresponse>") 
 		do tOut.Write("<result>"_count_"</result>") 	
 		do tOut.Write("</patientresponse>")  		
 		do tOut.Rewind()
 		
 		do pOutput.Write( tOut.Read() )
		

	} catch {
		Set tSC=$$$SystemError
	}
	Quit tSC
   
}




}