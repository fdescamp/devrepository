Class MyPackage.Tests Extends %UnitTest.TestCase
{

Method TestAdd()
{
	do $$$AssertEquals(##class(MyPackage.Math).Add(2,2),4, "Test Add(2,2)=4")
	do $$$AssertNotEquals(##class(MyPackage.Math).Add(2,2),5,"Test Add(2,2)'=5")
}

//Developper 1: Add new substract test
 /*Method TestSubstract()
{
	do $$$AssertEquals(##class(MyPackage.Math).Substract(3,2),1, "Test Substract(3,2)=1")
	do $$$AssertEquals(##class(MyPackage.Math).Substract(2,3),-1,"Test Substract(2,3)=-1")
}*/

//Developper 2: Add new division test
//Handle division by 0
Method TestDivision()
{
	do $$$AssertEquals(##class(MyPackage.Math).Division(4,0),0, "Test Division by 0 - return 0")
	do $$$AssertEquals(##class(MyPackage.Math).Division(4,2),2, "Test Division (4,2)=2")
}


}
