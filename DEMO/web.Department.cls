/// Department edit page
Class web.Department Extends web.AbstractPage
{

/// Displayed name of this page.
Parameter PAGENAME = "Department Edit";

/// Define controller and table
XData tableGroupPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<dataController id="controller" modelClass="Data.Department" />
<tablePane id="table" fixedHeaders="false" tableName="Data.Department" orderByClause="DepartmentName" 
	onselectrow="zen('controller').setModelId(zenThis.value)" valueColumn="ID" showRowSelector="false">
<column colName="ID" hidden="true" />
<column colName="DepartmentName" header="Department Name" />
</tablePane>
</pane>
}

}
