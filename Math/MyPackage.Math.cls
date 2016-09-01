Class MyPackage.Math Extends %Persistent
{

ClassMethod Add(nb1 As %Integer, nb2 As %Integer) As %Integer
{
	
	Quit nb1+nb2
}

// Developper 1: Add new substract method
ClassMethod Substract(nb1 As %Integer, nb2 As %Integer) As %Integer
{
	Quit nb1-nb2	
}

// Developper 2: Add new division method

/*ClassMethod Division (nb1 As %Integer, nb2 As %Integer) As %Integer
{
	Quit nb1/nb2	
}*/
Storage Default
{
<Data name="MathDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<DataLocation>^MyPackage.MathD</DataLocation>
<DefaultData>MathDefaultData</DefaultData>
<IdLocation>^MyPackage.MathD</IdLocation>
<IndexLocation>^MyPackage.MathI</IndexLocation>
<StreamLocation>^MyPackage.MathS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}
