Class UnitTest.HL7TestProduction  Extends %UnitTest.TestProduction
{

/// Class name of the production.  It must contain the production class name.
Parameter PRODUCTION = "Tutorial.HL7ExampleProduction";

Method OnBeforeProductionStart() As %Library.Status
{
	//MainDir where HL7 test messages are
	Set ..MainDir = "C:\Users\fdescamp\Documents\3. Documentation\Source Control\Git+Jenkins\GitHubRepository\Dev1\HL7\"
	
	//HL7INputDir and outputdir are automatically created from Intersystems install dir
	//C:\InterSystems\TestAuto624\HL7
	Set s = ..ChangeSetting(
	"Tutorial.HL7ExampleProduction","TutorialHL7FileOperation", 
	"FilePath",..HL7OutputDir,0)
	
	Do $$$AssertEquals(s,$$$OK)
	
	Set s0 = ..ChangeSetting("Tutorial.HL7ExampleProduction",
	 "TutorialHL7FileService","FilePath",..HL7InputDir,0)

	Do $$$AssertEquals(s0,$$$OK)
	

	Set s1=$$$AssertStatusOK(..CreateMainDirTree())
	Set s2 = $$$AssertStatusOK(..CleanUpDirectory(..HL7InputDir))
	Set s3 = $$$AssertStatusOK(..CleanUpDirectory(..HL7OutputDir))
	set s4 = $$$AssertStatusOK(..CopyFile("ORMO01_In.txt",..MainDir))

	if 's||'s0||'s1||'s2||'s3||'s4
	
	{Quit ..Error("Error in OnBeforeProductionStart()")}
	
	Quit $$$OK
}


Method CheckResults(ByRef Log As %String, New As %String) As %Status
{
	
	//Check Data Transformation vs. ORM01Out_reference.txt file
	Do $$$AssertStatusOK(..CompareFiles("ORMO01Out.txt",,,..MainDir))
	
	&SQL(Select TOP 1 ID,ActivityName,ErrorMsg,ReturnValue,Reason 
	INTO :Id,Act,Msg,Ret,Rea FROM Ens_Rule.Log
	WHERE RuleName='Tutorial.TutorialHL7MessageRouterRules'
	ORDER BY ID DESC
	)
	
	Set r = $$$AssertEquals(SQLCODE, 0, "Rule Log Entry")
	
	//If ORMO01 then send to HL7FileOperation and transform message 
	if r {
		
		Set r1=$$$AssertEquals(Rea,"rule#1:when#1", "Rule:("_Rea_")")
		Set r2=$$$AssertTrue(Ret["TutorialHL7FileOperation","Target: "_Ret)
		
	}
	
	Quit $$$OK
}

}