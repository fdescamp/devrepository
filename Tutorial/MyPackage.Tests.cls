Class MyPackage.Tests Extends %UnitTest.TestCase
{

Method TestAdd()
{
		do $$$AssertEquals(##class(MyPackage.TestMe).Add(2,2),4, "Test Add(2,2)=4")
		do $$$AssertNotEquals(##class(MyPackage.TestMe).Add(2,2),5,"Test Add(2,2)'=5")
}

Method TestCreateContact()
{
	Set name="Smith,John"
	Set type="Business"
	
	Set contact=##class(MyPackage.TestMe).CreateContact(name,type)
	
	Do $$$AssertEquals(contact.Name, name, "Name Assignment")
	Do $$$AssertEquals(contact.ContactType, type, "ContactType Assignment")
	
	Do $$$AssertStatusOK(contact.%Save(),"Saving the Contact")
}

Method TestEditContact()
{
	set contact=##class(MyPackage.Contact).%OpenId(1)
	set contact.Name="Rockwell,Norman"
	set contact.ContactType="Friend"
	Do $$$AssertStatusNotOK(contact.%Save(),"ContactType = Friend")
	Set contact.ContactType="Personal"
	Do $$$AssertStatusOK(contact.%Save(),"ContactType = Personal")
}

Method OnBeforeOneTest(testname As %String) As %Status
{
	
	For i=1:1:5
	{
	 set contact=##class(MyPackage.Contact).%New()
	 
	 if (i#2=0)
	 {
		set contact.Name="NameP"
		set contact.ContactType="Personal"
		do contact.%Save()
		set contact=""	 
	 }	
	 
	 else
	 {
		 set contact.Name="NameB"
		 set contact.ContactType="Business"
		 do contact.%Save()
		 set contact=""
		 
	 }
		
	}
		
 	Quit $$$OK
}

Method TestQuery()
{
	Set type="Personal"
	Set rs=##class(%Library.ResultSet).%New("MyPackage.Contact:ByContactType")
	
	Do rs.Execute(type)
	
	set i=0
	While (rs.Next()){
		
		set i=i+1
		set contact=##class(MyPackage.Contact).%OpenId(rs.Data("ID"))
		Do $$$AssertEquals(contact.ContactType, type, "Contact has correct type")
	}
	
	Do $$$AssertEquals(2,i,"RS has correct number of results")
}

Method OnAfterOneTest(testname As %String) As %Status
{
	Do ##class(MyPackage.Contact).%KillExtent()
 	Quit $$$OK
}

}
