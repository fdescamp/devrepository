/// Presenter edit page
Class web.Presenter Extends web.AbstractPage
{

/// Displayed name of this page.
Parameter PAGENAME = "Presenter Edit";

/// Define controller and table
XData tableGroupPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<dataController id="controller" modelClass="Data.Presenter" />
<tablePane id="table" fixedHeaders="false" tableName="Data.Presenter" orderByClause="PresenterName" 
	onselectrow="zen('controller').setModelId(zenThis.value)" valueColumn="ID" showRowSelector="false">
<column colName="ID" hidden="true" />
<column colName="PresenterName" header="Presenter Name" />
<column colName="PresenterDepartment->DepartmentName" header="Department" />
</tablePane>
</pane>
}

}
