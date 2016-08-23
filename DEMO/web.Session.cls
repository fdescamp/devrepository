/// Session edit page
Class web.Session Extends web.AbstractPage
{

/// Displayed name of this page.
Parameter PAGENAME = "Session Edit";

/// Define controller and table
XData tableGroupPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<dataController id="controller" onupdate="zenPage.refreshConflicts()" modelClass="Data.Session" />
<tablePane id="table" fixedHeaders="false" tableName="Data.Session" orderByClause="SessionDate,SessionRoom->RoomName,SessionStartTime" 
	onselectrow="zen('controller').setModelId(zenThis.value)" valueColumn="ID" showRowSelector="false">
<column colName="ID" hidden="true" />
<column colName="SessionDate" header="Date" />
<column colName="SessionRoom" colExpression="SessionRoom->RoomName" header="Room" />
<column colName="SessionStartTime" header="Time" OnDrawCell="FormatTime" />
<column colName="SessionName" header="Session Name" />
<column colName="ConflictCount" header="Conflicts" style="font-color:red;" />
</tablePane>
</pane>
}

/// This is a placeholder for additional conflict data
XData conflictPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<html id="conflicts" />
</pane>
}

/// Display time in HH:MM format instead of HH:MM:SS
Method FormatTime(pTable As %ZEN.Component.tablePane, pName As %String, pSeed As %String) As %Status
{
 If $length(%query(pName),":")=3 { 
 	Write $piece(%query(pName),":",1,2)
 } Else { 
 	Write %query(pName) 
 } 
 Quit $$$OK
}

ClientMethod refreshConflicts() [ Language = javascript ]
{
	//zen('conflicts').setContent('<PRE class="conflicts">'+zen('controller').getDataByName('Conflicts')+'</PRE>');
}

}
