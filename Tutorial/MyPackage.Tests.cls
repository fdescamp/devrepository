Class MyPackage.Tests Extends %UnitTest.TestCase
{

Method TestAdd()
{
	do $$$AssertEquals(##class(MyPackage.Math).Add(2,2),4, "Test Add(2,2)=4")
	do $$$AssertNotEquals(##class(MyPackage.Math).Add(2,2),5,"Test Add(2,2)'=5")
}



}
