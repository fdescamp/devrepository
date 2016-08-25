Class Tutorial.ExampleOperation Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter INVOCATION = "Queue";

Method Test(pRequest As Ens.StringRequest, Output pResponse As Ens.StringResponse) As %Status
{
	Set tSC=$$$OK
	Set pResponse=##class(Ens.StringResponse).%New()	
	
	if (pRequest.StringValue="")
	{
		//Generate error in build 
		Set pResponse.StringValue="ERROR"
		Set tSC=$$$ERROR($$$GeneralError, "Test error case")
		
	}
	
	else
	{
	
		Set pResponse.StringValue="OK"		
		Set tSC=$$$OK
	}
	
	$$$LOGINFO(pResponse.StringValue)

	Quit tSC
}

XData MessageMap
{
<MapItems>
	<MapItem MessageType="Ens.StringRequest"> 
		<Method>Test</Method>
	</MapItem>
</MapItems>
}

}
