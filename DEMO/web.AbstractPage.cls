/// Abstract application page
Class web.AbstractPage Extends %ZEN.Component.page
{

/// Class name of application this page belongs to.
Parameter APPLICATION = "web.Application";

/// Displayed name of this page.
Parameter PAGENAME = "Room Edit";

/// Domain used for localization.
Parameter DOMAIN = "SUMMIT";

/// This Style block contains page-specific CSS style definitions.
XData Style
{
<style type="text/css">
</style>
}

/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="Room">
<html OnDrawContent="DrawHeader" />
<menu width="100%">
<menuItem caption="Sessions" link="web.Session.zen" />
<menuItem caption="Rooms" link="web.Room.zen" />
<menuItem caption="Presenters" link="web.Presenter.zen" />
<menuItem caption="Departments" link="web.Department.zen" />
<menuSeparator width="100%" />
</menu>
<hgroup id="mainScreen" width="100%">
<vgroup id="tableGroup" groupClass="screen" width="50%" valign="top">
<pane paneName="tableGroupPane" />
</vgroup>
<vgroup id="editGroup" groupClass="screen" width="50%" valign="top">
<hgroup>
<button caption="New" onclick="zenPage.onclickNew()" />
<button caption="Save" onclick="zenPage.onclickSave()" />
<button caption="Delete" onclick="zenPage.onclickDelete()" />
</hgroup>
<dynaForm controllerId="controller" />
<pane paneName="conflictPane" />
</vgroup>
</hgroup>
</page>
}

/// This is a placeholder for table pane
XData tableGroupPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
<dataController id="controller" />
<html> Not implemented </html>
</pane>
}

/// This is a placeholder for additional conflict data
XData conflictPane [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<pane xmlns="http://www.intersystems.com/zen">
</pane>
}

/// This method is invoked from <html> Zen component to draw standard page header
Method DrawHeader(pSeed As %String) As %Status
{
	&html<
	<div class="portalTitle">
		<div class="portalTitleTabBox"  id="titleTab">#(..#PAGENAME)#</div>
		<div class="portalLogoBox">
			<div class="portalLogo" title='Powered by Zen'>Summit</div>
			<div class="portalLogoSub">by InterSystems</div>
		</div>
	</div>
	>
	quit $$$OK
}

/// "New" button handler
ClientMethod onclickNew() [ Language = javascript ]
{
	zen('controller').setModelId('');
	zen('table').selectRow('');
}

/// "Save" button handler
ClientMethod onclickSave() [ Language = javascript ]
{
	zen('controller').save();
	zen('table').refreshContents();
}

/// "Delete" button handler
ClientMethod onclickDelete() [ Language = javascript ]
{
	if(zen('controller').getModelId()=='') {
		// don't try to delete unsaved object
		zen('controller').setModelId('');
		return; 
	}
	zen('controller').deleteId(zen('controller').getModelId());
	zen('controller').setModelId('');
	zen('table').refreshContents();
}

}
