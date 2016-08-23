/// This is a class for tests that change transactional data.
/// It's run within a transaction which is rolled back at the end.
Class UnitTest.Transaction Extends UnitTest.Abstract
{

Method OnBeforeOneTest() As %Status
{
 TStart
 Quit $$$OK
}

Method OnAfterOneTest() As %Status
{
 TRollback
 Quit $$$OK
}

}
