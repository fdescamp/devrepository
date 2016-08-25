Class Demo.BusinessOperation.PatientWS Extends EnsLib.REST.Operation
{

Parameter ADAPTER = "EnsLib.HTTP.OutboundAdapter";

Property Adapter As EnsLib.HTTP.OutboundAdapter;

Parameter INVOCATION = "Queue";

// Check if PatientID exists in the database

Method PatientExists(pRequest As Demo.Message.PatientRequest, Output pResponse As Demo.Message.PatientResponse) As %Status
{
   
   try {
      // Prepare and log the call
      Set tURL=..Adapter.URL_"/PatientID/"_pRequest.PatientID
      
      // Execute the call
      Set tSC=..Adapter.GetURL(tURL,.tHttpResponse)
      
      // Return the response
      If $$$ISERR(tSC)&&$IsObject(tHttpResponse)&&$IsObject(tHttpResponse.Data)&&tHttpResponse.Data.Size {
         Set tSC=$$$ERROR($$$EnsErrGeneral,$$$StatusDisplayString(tSC)_":"_tHttpResponse.Data.Read())
      }
      Quit:$$$ISERR(tSC)
     If $IsObject(tHttpResponse) {
        set xmldoc=##class(EnsLib.EDI.XML.Document).ImportFromLibraryStream(tHttpResponse.Data)
        set result=xmldoc.GetValueAt("/patientresponse/result")
        set pResponse=##class(Demo.Message.PatientResponse).%New()
        set pResponse.Exist=result
         
       }
   }catch{
       Set tSC=$$$SystemError
   }
   Quit tSC
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="Demo.Message.PatientRequest">
    <Method>PatientExists</Method>
  </MapItem>
</MapItems>
}

}
