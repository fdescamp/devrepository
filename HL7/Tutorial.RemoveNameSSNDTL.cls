Class Tutorial.RemoveNameSSNDTL Extends Ens.DataTransformDTL [ ClassType = "", ProcedureBlock ]
{

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<?xml version="1.0" ?>
<transform targetClass='EnsLib.HL7.Message' targetDocType='2.3.1:ORM_O01' sourceClass='EnsLib.HL7.Message' sourceDocType='2.3.1:ORM_O01' create='copy' language='objectscript'>
<assign property='target.{PIDgrp.PID:PatientName()}' value='""' action='set'/>
<assign property='target.{PIDgrp.PID:PatientAddress()}' value='""' action='set'/>
<assign property='target.{PIDgrp.PID:PhoneNumberHome()}' value='""' action='set'/>
<assign property='target.{PIDgrp.PID:PhoneNumberBusiness()}' value='""' action='set'/>
<assign property='target.{PIDgrp.PID:SSNNumberPatient}' value='""' action='set'/>
</transform>
}

}
