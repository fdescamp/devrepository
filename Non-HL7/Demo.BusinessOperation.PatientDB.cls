Class Demo.BusinessOperation.PatientDB Extends Ens.BusinessOperation {

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";


Method InsertPatient(pRequest As Demo.Patient, Output pResponse As %Library.Integer) As %Status
{
	
		set sql = "Insert into Demo.Patient (PatientID,FirstName,LastName,DOB) values ("_pRequest.PatientID_","_pRequest.FirstName_","_pRequest.LastName_","_pRequest.DOB_")"
		
		 S tResult = ##CLASS(EnsLib.SQL.GatewayResultSet).%New()
		 S tSC = ..Adapter.ExecuteQuery(.tResult,sql)
				 
		 Quit:$$$ISERR(tSC)
	
	
	Quit tSC
}

Method SelectPatient (pRequest As Ens.StringContainer, Output pResponse As %Integer) As %Status
{
	
		set sql = "Select count(*) into :count from Demo.Patient where PatientID="_pRequest
		
		 S tResult = ##CLASS(EnsLib.SQL.GatewayResultSet).%New()
		 S tSC = ..Adapter.ExecuteQuery(.tResult,sql)
		 set pResponse=tResult.GetData(1)
				 
		 Quit:$$$ISERR(tSC)
	
	
	Quit tSC
}


XData MessageMap
{
<MapItems>
	<MapItem MessageType="Demo.Patient">
	<Method>InsertPatient</Method>
	</MapItem>
	<MapItem MessageType="Ens.StringContainer">
	<Method>SelectPatient</Method>
	</MapItem>
	
</MapItems>
}

}