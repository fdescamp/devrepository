Class Tutorial.HL7ProductionTest Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION = "Tutorial.HL7ExampleProduction";

Method OnBeforeProductionStart() As %Library.Status
{
	set tSC=$$$OK
	
	
	//Change Setting parameter on Business Operation and Service
	Do ..LogMessage("-----Change Settings------")
	Set ..MainDir="C:\Users\fdescamp\Documents\3. Documentation\Source Control\Git+Jenkins\GitHubRepository\Dev1\Tutorial\HL7"
	//set ..HL7InputDir=MainDir_"\In"
	//set ..HL7OutputDir=MainDir_"\Out"
	Set tSC = ..ChangeSetting("Tutorial.HL7ExampleProduction","TutorialHL7FileOperation", "FilePath",..HL7OutputDir,0)	
	Do $$$AssertEquals(tSC,$$$OK)
	Set tSC = ..ChangeSetting("Tutorial.HL7ExampleProduction","TutorialHL7FileService", "FilePath",..HL7InputDir,0)	
	Do $$$AssertEquals(tSC,$$$OK)
	

	Set s1=$$$AssertStatusOK(..CreateMainDirTree())
	
	Set s2 = $$$AssertStatusOK(..CleanUpDirectory(..HL7InputDir))
	Set s3 = $$$AssertStatusOK(..CleanUpDirectory(..HL7OutputDir))
	
	Set s4 = $$$AssertStatusOK(..CopyFile("ABC1.txt",..MainDir))
	
	if 'tSC|| 's1||'s2||'s3||'s4 
	{Quit ..Error("Error in OnBeforeProductionStart()")}
	
	Quit $$$OK
}

Method CheckResults() As %Library.Status
{
	Do $$$AssertStatusOK(..CompareFiles("ABC1Out.txt","ABC1Out_Reference.txt",..HL7OutputDir,..MainDir))
	
	&SQL(Select TOP 1 ID,ActivityName,ErrorMsg,ReturnValue,Reason 
	INTO :Id,Act,Msg,Ret,Rea FROM Ens_Rule.Log
	WHERE RuleName='Tutorial.TutorialHL7MessageRouterRules'
	ORDER BY ID DESC
	)
	
	Set r = $$$AssertEquals(SQLCODE, 0, "Rule Log Entry")
	
	if r {
		
		Set r1=$$$AssertEquals(Rea,"rule#1:when#1", "Rule:("_Rea_")")
		Set r2=$$$AssertTrue(Ret["TutorialHL7FileOperation","Target: "_Ret)
		
	}
	

	Quit $$$OK
}

}
