Class MyPackage.Math extends %Persistent {



ClassMethod Add (nb1 As %Integer, nb2 As %Integer)As %Integer
{
	
	Quit nb1+nb2 
}

// Developper 1: Add new substract method

ClassMethod Substract(nb1 As %Integer, nb2 As %Integer) As %Integer
{
	Quit nb1-nb2
}

//Developper 2: Add new division method
ClassMethod Division (nb1 As %Integer, nb2 As %Integer) As %Integer
{
	Quit nb1/nb2	
}

}
