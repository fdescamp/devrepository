Class Demo.BusinessOperation.PatientDB Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method InsertPatient(pRequest As Demo.Patient, Output pResponse As Ens.StringContainer) As %Status
{
	
		set tSC=$$$OK
		set pResponse=##class(Ens.StringContainer).%New()
		/*set sql = "Insert into Demo.Patient (PatientID,FirstName,LastName,DOB) values ("_pRequest.PatientID_","_pRequest.FirstName_","_pRequest.LastName_","_pRequest.DOB_")"
		
		 S tResult = ##CLASS(EnsLib.SQL.GatewayResultSet).%New()
		 S tSC = ..Adapter.ExecuteQuery(.nrows,sql)
		 */
		  &SQL(insert into Demo.Patient (PatientID,FirstName,LastName,DOB) values (:pRequest.PatientID,:pRequest.FirstName,:pRequest.LastName,:pRequest.DOB))
		  
		 Quit:$$$ISERR(tSC)
		 
		 set pResponse.StringValue=SQLCODE
	
	
	Quit tSC
}

Method SelectPatient(pRequest As Ens.StringContainer, Output pResponse As Ens.StringContainer) As %Status
{

	 set tSC=$$$OK
	 set pResponse=##class(Ens.StringContainer).%New("")
	 set id=""
	 
	 &SQL(select ID into :id from Demo.Patient where PatientID=:pRequest.StringValue)
	
	 set pResponse.StringValue=id 
	 
	
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
