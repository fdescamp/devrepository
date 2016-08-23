/// Room edit page
Class web.Room Extends web.AbstractPage
{

/// Displayed name of this page.
Parameter PAGENAME = "Room Edit";

/// Define controller and table
XData tableGroupPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<dataController id="controller" modelClass="Data.Room" />
<tablePane id="table" fixedHeaders="false" tableName="Data.Room" orderByClause="RoomName" 
	onselectrow="zen('controller').setModelId(zenThis.value)" valueColumn="ID" showRowSelector="false">
<column colName="ID" hidden="true" />
<column colName="RoomName" header="Room Name" />
<column colName="RoomCapacity"  header="Room Capacity" />
</tablePane>
</pane>
}

}
