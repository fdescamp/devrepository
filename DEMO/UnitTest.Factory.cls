Include (%occInclude, %outUnitTest)

/// This is a generic object factory class
Class UnitTest.Factory [ Abstract ]
{

/// This method is used to add new object of ClassName class into database.
/// Returns ID of new object.
/// If there is an error during save throws an exception
/// Properties are in form $lb($lb(propName1,value1),$lb(propName2,value2),....)
/// 
/// You can specify property names and values for ClassName and for any of its required DRs.
/// If property is a required DR this method will create a new object by calling itself recursively.
/// If property is required string it will fill it with a random value.
ClassMethod Add(ClassName As %String, Properties As %List = "", ByRef Status As %Status = {$$$OK}) As %String
{
	If $TLevel = 0 {
		Set Status = $$$ADDSC(Status, $$$ERROR($$$GeneralError, "UnitTest.Factory unavailable outside a transaction."))
		Quit ""
	}
	
	s initValue=""
	d ..GetFieldsInfo(ClassName,.populate,.parref)
	f i=1:1:$ll(Properties) i $lg($lg(Properties,i),1)=parref s initValue=$lg($lg(Properties,i),2)
	i parref'="",initValue="" {
		s initValue=..Add($$$comMemberKeyGet(ClassName,$$$cCLASSproperty,parref,$$$cPROPtype),Properties,.Status)
		s Properties=Properties_$lb($lb(parref,initValue))
	}
	s obj=$ClassMethod(ClassName,"%New",initValue)
	d obj.%DowngradeConcurrency(0)
	f i=1:1:$ll(Properties) {
		s prop=$lg($lg(Properties,i),1)
		s value=$lg($lg(Properties,i),2)
		i prop="" continue
		i '##class(%Dictionary.CompiledProperty).%ExistsId(ClassName_"||"_prop) continue
		i ##class(%Dictionary.CompiledMethod).%ExistsId(ClassName_"||"_prop_"SetObjectId") {
			/// object reference property
			d $Method(obj,prop_"SetObjectId",value)
		} elseif ##class(%Dictionary.CompiledMethod).%ExistsId(ClassName_"||"_prop_"BuildValueArray") {
			/// list of datatype property
			d $Method($Property(obj,prop),"InsertObjectId",value)
		} else {
			/// scalar property
			s $Property(obj,prop)=value
		}
		kill populate(prop)
	}
	
	// Fill remaining required fields with random values
	set prop=""
	for {
		set prop=$o(populate(prop),1,required)
		quit:prop=""
		
		set value = ""
		set collection = $$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPcollection)
		set dataType = $$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPtype)
		Set classType = $$$getClassType(dataType)
		Set typeCategory = $Case(classType,$$$cCLASSCLASSTYPEDATATYPE:"literal",$$$cCLASSCLASSTYPEPERSISTENT:"reference",$$$cCLASSCLASSTYPESTREAM:"stream",:"serial")
		
		i ##class(%Dictionary.CompiledMethod).%ExistsId(ClassName_"||"_prop_"SetObjectId") {
			// object reference property
			if $Method(obj,prop_"GetObjectId")="" {
				set value = ..Add(dataType,Properties,.Status)
				d $Method(obj,prop_"SetObjectId",value)
				if $g(%debug) write !,prop," = $lb("""_value_""","""_dataType_""")"
			}
		} elseif ($$$comMemberArrayGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPparameter,"VALUELIST")'="") {
			set value = $p($$$comMemberArrayGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPparameter,"VALUELIST"),",",2)
			set $Property(obj,prop) = value
			if $g(%debug) write !,prop," = "_value
		} elseIf collection = $$$cPROPCOLLECTIONARRAY, typeCategory = "literal" {
			s array = $property(obj,prop)
			set value = ..GetLiteralValue(ClassName, prop, dataType)
			d array.SetAt(value,1)
			if $g(%debug) write !,prop,"(1) = "_value
		}	ElseIf collection = $$$cPROPCOLLECTIONLIST, typeCategory = "literal" {
			s array = $property(obj,prop)
			set value = ..GetLiteralValue(ClassName, prop, dataType)
			d array.Insert(value)
			if $g(%debug) write !,prop," = $lb("_value_")"
		} elseif $zobjproperty(obj,prop)="" {
			// scalar property
			set value = ..GetLiteralValue(ClassName, prop, dataType)
			set $Property(obj,prop) = value
			if $g(%debug) write !,prop," = "_value
		}
	}
	
	set Status = $$$ADDSC(Status, $Method(obj,"%Save",0))
	if $g(%debug),$$$ISERR(Status) break
	set id = $Method(obj,"%Id")
	quit id
}

/// Get information about required fields and parref of a given class
ClassMethod GetFieldsInfo(ClassName As %String, Output Populate As %String, Output ParRef As %String) As %Status
{
	set ParRef=""
	set prop=""
	for {
		set prop=$$$comMemberNext(ClassName,$$$cCLASSproperty,prop)
		quit:prop=""
		
		#; Check to see if this property is the parent.
		set relationship=$$$defMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPrelationship)
		if relationship {
			Set cardinality=$$$defMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPcardinality)
			if (cardinality="parent") set ParRef=prop
		}
		
		if ($e(prop)="%") continue
		#; oddDEF is used as oddCOM does not reflect required fields in all circumstances.
		set required = ($$$defMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPrequired))||($$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPrequired))
		if ('required) continue
		if $$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPprivate) continue
		if $$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPcalculated) continue
		if $$$comMemberKeyGet(ClassName,$$$cCLASSproperty,prop,$$$cPROPtransient) continue
		
		set Populate(prop)=required
	}
	quit $$$OK
}

ClassMethod GetLiteralValue(ClassName, Property, DataType As %String)
{
	set dataTypeShortName = $$$ClassShortName(DataType)
	set minlen = $$$comMemberArrayGet(ClassName,$$$cCLASSproperty,Property,$$$cPROPparameter,"MINLEN")
	set maxlen = $$$comMemberArrayGet(ClassName,$$$cCLASSproperty,Property,$$$cPROPparameter,"MAXLEN")
	if (dataTypeShortName = "String") && (minlen > 1) {
		set val = ##class(%PopulateUtils).StringMin(minlen,maxlen)
	} else {
		#; Property parameter should remain undefined if there is not a value.
		#; Using null instead of undefined will change the populate behaviour.
		Set minval = $$$comMemberArrayGet(ClassName,$$$cCLASSproperty,Property,$$$cPROPparameter,"MINVAL")
		Set maxval = $$$comMemberArrayGet(ClassName,$$$cCLASSproperty,Property,$$$cPROPparameter,"MAXVAL")
		Set scale = $$$comMemberArrayGet(ClassName,$$$cCLASSproperty,Property,$$$cPROPparameter,"SCALE")
		If minval = "" Kill minval
		If maxval = "" Kill maxval
		If scale = "" Kill scale
		
		Set val = $Case(dataTypeShortName,
			"String":		##class(%PopulateUtils).String(.maxlen),
			"Integer":		##class(%PopulateUtils).Integer(.minval,.maxval),
			"Date":			##class(%PopulateUtils).Date(.minval,.maxval),
			"Time":	##class(%PopulateUtils).Integer($g(minval,0),$g(maxval,83699)),
			"Binary":		##class(%PopulateUtils).String(.maxlen),
			"Double":		##class(%PopulateUtils).Float(.minval,.maxval,.scale),
			"Name":			##class(%PopulateUtils).Name(),
			"Boolean":		$random(2),
			"Currency":		##class(%PopulateUtils).Currency(.minval,.maxval),
			"Float":		##class(%PopulateUtils).Float(.minval,.maxval,.scale),
			"Numeric":		##class(%PopulateUtils).Float(.minval,.maxval,.scale),
			"TimeStamp":	##class(%PopulateUtils).TimeStamp(.minval,.maxval),
			:			"")
	}
	
	If val = "" Break
	Quit val
}

}
