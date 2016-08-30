Class MyPackage.TestMe Extends %RegisteredObject
{

ClassMethod Add(arg1 As %Integer, arg2 As %Integer) As %Integer
{

	quit arg1 + arg2
}

ClassMethod CreateContact(name As %String, type As %String) As MyPackage.Contact
{
	Set contact = ##class(MyPackage.Contact).%New()
	Set contact.Name=name
	Set contact.ContactType=type
	Quit contact
}

ClassMethod GetContactsByType(type As %String) As %ListOfObjects
{
	
	Set list=##class(%Library.ResultSet).%New()
}

}
