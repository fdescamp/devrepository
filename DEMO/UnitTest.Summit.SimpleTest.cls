/// This is a simple test for illustration only. Don't try to repeat at home.
Class UnitTest.Summit.SimpleTest Extends UnitTest.Abstract
{

Parameter TITLE = "Simple Test";

/// This is a sample test.
Method TestComplexMathematicEquation() As %Status
{
	set Result=2+2
	do $$$AssertEquals(Result,4,"2+2 should be 4")
	quit $$$OK
}

}
